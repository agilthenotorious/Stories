struct StoryListView: View {
    @StateObject var viewModel = StoryViewModel()
    @State private var selectedIndex: Int = 0
    @State private var showFullScreenStory: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(Array(viewModel.stories.enumerated()), id: \.element.id) { index, story in
                        StoryCell(story: story)
                            .onTapGesture {
                                selectedIndex = index
                                showFullScreenStory = true
                            }
                            .onAppear {
                                // Load more stories when reaching the end
                                if index == viewModel.stories.count - 1 {
                                    viewModel.loadMoreStories()
                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Stories")
        }
        .fullScreenCover(isPresented: $showFullScreenStory) {
            StoryFullScreenView(viewModel: viewModel, currentIndex: $selectedIndex)
        }
    }
}
