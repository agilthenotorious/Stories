import SwiftUI

struct StoryFullScreenView: View {
    @ObservedObject var viewModel: StoryViewModel
    @Binding var currentIndex: Int
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if currentIndex < viewModel.stories.count {
            let story = viewModel.stories[currentIndex]
            ZStack {
                // Story content (using the profile image as a placeholder)
                AsyncImage(url: story.profilePictureURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                } placeholder: {
                    ProgressView()
                }
                .onAppear {
                    viewModel.markStorySeen(story: story)
                }
                // Right-half tap gesture for next story and left-half tap gesture for previous story
                GeometryReader { geo in
                    HStack {
                        Rectangle()
                            .foregroundStyle(.clear)
                            .contentShape(Rectangle())
                            .frame(width: geo.size.width / 2)
                            .onTapGesture {
                                withAnimation {
                                    if currentIndex > 0 {
                                        currentIndex -= 1
                                    }
                                }
                            }
                        Rectangle()
                            .foregroundStyle(.clear)
                            .contentShape(Rectangle())
                            .frame(width: geo.size.width / 2)
                            .onTapGesture {
                                withAnimation {
                                    if currentIndex == viewModel.stories.count - 1 {
                                        viewModel.loadMoreStories()
                                    }
                                    currentIndex += 1
                                }
                            }
                    }
                }
                // User details and Dismiss button
                VStack {
                    HStack {
                        AsyncImage(url: story.profilePictureURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Image(systemName: "person.circle")
                        }
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        Text(story.name)
                            .font(.callout)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .padding()
                        }
                    }
                    Spacer()
                }
                .padding()

                // Like button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            viewModel.toggleLike(for: story)
                        } label: {
                            Image(systemName: story.isLiked ? "heart.fill" : "heart")
                                .font(.largeTitle)
                                .padding()
                                .clipShape(Circle())
                                .foregroundStyle(Color.red)
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
            // Ensure that if the current index changes (via right tap), the new story is marked as seen.
            .onChange(of: currentIndex, { _, newIndex in
                if newIndex < viewModel.stories.count {
                    let newStory = viewModel.stories[newIndex]
                    viewModel.markStorySeen(story: newStory)
                }
            })
        }
    }
}
