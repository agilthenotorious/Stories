import Foundation

class PersistenceManager {
    private let seenKey = "seenStories"
    private let likedKey = "likedStories"
    
    static let shared = PersistenceManager()
    
    private init() { }
    
    func saveSeenStory(id: Int) {
        var seen = UserDefaults.standard.array(forKey: seenKey) as? [Int] ?? []
        if !seen.contains(id) {
            seen.append(id)
            UserDefaults.standard.set(seen, forKey: seenKey)
        }
    }
    
    func isStorySeen(id: Int) -> Bool {
        let seen = UserDefaults.standard.array(forKey: seenKey) as? [Int] ?? []
        return seen.contains(id)
    }
    
    func toggleLikedStory(id: Int) {
        var liked = UserDefaults.standard.array(forKey: likedKey) as? [Int] ?? []
        if liked.contains(id) {
            liked.removeAll { $0 == id }
        } else {
            liked.append(id)
        }
        UserDefaults.standard.set(liked, forKey: likedKey)
    }
    
    func isStoryLiked(id: Int) -> Bool {
        let liked = UserDefaults.standard.array(forKey: likedKey) as? [Int] ?? []
        return liked.contains(id)
    }
}
