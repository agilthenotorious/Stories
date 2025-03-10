struct Story: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let profilePictureURL: URL
    var isSeen: Bool = false
    var isLiked: Bool = false
}