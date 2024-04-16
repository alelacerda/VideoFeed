import Foundation

struct DataModel: Codable {
    let looks: [Look]
}

struct Look: Codable, Equatable {
    let id: Int
    let songURL: URL
    let body: String
    let profilePictureURL: URL
    let username: String
    let compressedForIOSURL: URL
    var heartReactions: Int = 0
    var fireReactions: Int = 0

    enum CodingKeys: String, CodingKey {
        case id
        case songURL = "song_url"
        case body
        case profilePictureURL = "profile_picture_url"
        case username
        case compressedForIOSURL = "compressed_for_ios_url"
    }
}
