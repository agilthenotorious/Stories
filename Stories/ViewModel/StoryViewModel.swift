import SwiftUI

class StoryViewModel: ObservableObject {
    @Published var stories: [Story] = []
    private var originalStories: [Story] = []
    
    init() {
        loadStories()
    }
    
    func loadStories() {
        // Load the JSON from the bundle (users.json)
        if let url = Bundle.main.url(forResource: "users", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            do {
                let decodedPages = try JSONDecoder().decode(UserPages.self, from: data)
                let baseStories = decodedPages.pages.flatMap { $0.users.map { user in
                    Story(
                        id: user.id,
                        name: user.name,
                        profilePictureURL: user.profile_picture_url,
                        isSeen: PersistenceManager.shared.isStorySeen(id: user.id),
                        isLiked: PersistenceManager.shared.isStoryLiked(id: user.id)
                    )
                }}
                originalStories = baseStories
                stories = baseStories
            } catch {
                print("Decoding error: \(error)")
            }
        }
    }
    
    func loadMoreStories() {
        // Create a fresh batch from the original stories.
        // For each story, if it hasn’t been liked or seen per persistence, it appears fresh.
        let newBatch = originalStories.map { base in
            Story(
                id: base.id + self.stories.count,
                name: base.name,
                profilePictureURL: base.profilePictureURL,
                isSeen: false,
                isLiked: false
            )
        }
        self.stories.append(contentsOf: newBatch)
    }
    
    func markStorySeen(story: Story) {
        PersistenceManager.shared.saveSeenStory(id: story.id)
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            stories[index].isSeen = true
        }
    }
    
    func toggleLike(for story: Story) {
        PersistenceManager.shared.toggleLikedStory(id: story.id)
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            stories[index].isLiked.toggle()
        }
    }
}
