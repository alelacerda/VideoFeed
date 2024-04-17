import Foundation

struct ViewModel {

    var currentVideoData: Look?
    var currentVideoId: Int = 0 {
        didSet {
            if let videos = videos {
                    currentVideoData = videos.looks[currentVideoId]
                }
            }
        }
    var videos: DataModel? {
        didSet {
            if let videos = videos {
                    currentVideoData = videos.looks[currentVideoId]
                }
            }
        }

    init() {
        loadItemsFromJSONFile()
    }

    mutating func loadItemsFromJSONFile() {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                videos = try JSONDecoder().decode(DataModel.self, from: data)
            } catch {
                print("Error reading JSON file:", error)
            }
        } else {
            print("File not found")
        }
    }

    mutating func increaseHeartCount() {
        if var videos = videos {
            videos.looks[currentVideoId].heartReactions += 1
            self.videos = videos
        }
    }

    mutating func increaseFlameCount() {
        if var videos = videos {
            videos.looks[currentVideoId].flameReactions += 1
            self.videos = videos
        }
    }

    mutating func incrementVideoId() {
        currentVideoId = (currentVideoId + 1) % (videos?.looks.count ?? 1)
    }

    mutating func decrementVideoId() {
        if currentVideoId != 0 {
            currentVideoId -= 1
        } else {
            currentVideoId = (videos?.looks.count ?? 1) - 1
        }
    }
}
