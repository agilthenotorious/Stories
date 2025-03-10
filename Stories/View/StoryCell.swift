import SwiftUI

struct StoryCell: View {
    let story: Story
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: story.profilePictureURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(story.isSeen ? Color.gray : Color.blue, lineWidth: 3)
            )
            Text(story.name)
                .font(.callout)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(width: 70)
        }
    }
}
