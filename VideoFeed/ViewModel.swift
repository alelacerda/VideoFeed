import Foundation

struct ViewModel {

    var videos: DataModel?
    var currentVideoId: Int = 0
    var currentVideoData: Look?

    init() {
        loadItemsFromJSONFile()
        if let videos = self.videos {
            currentVideoData = videos.looks[0]
        } else {
            return
        }
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

    
}
