import SwiftUI
import AVKit

struct VideoPlayerView: View {

    @State var data: Look

    @State private var videoPlayer: AVPlayer?
    @State private var audioPlayer = AVPlayer()
    @State private var videoPlayerObserver: Any?

    var body: some View {
        VideoPlayer(player: videoPlayer)
            .onAppear {
                playNewVideo()
            }
            .onDisappear {
                videoPlayer?.pause()
                audioPlayer.pause()
                if let observer = videoPlayerObserver {
                    NotificationCenter.default.removeObserver(observer)
                }
            }
    }

    private func playNewVideo() {
        let playerItem = AVPlayerItem(url: data.compressedForIOSURL)
        let audioItem = AVPlayerItem(url: data.songURL)
        audioPlayer = AVPlayer(playerItem: audioItem)
        videoPlayer = AVPlayer(playerItem: playerItem)
        videoPlayer?.actionAtItemEnd = .none

        videoPlayerObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: .main) { _ in
            resetAudioAndVideo()
        }

        videoPlayer?.play()
//        audioPlayer.play()
    }

    private func resetAudioAndVideo() {
        videoPlayer?.seek(to: .zero)
        videoPlayer?.play()
        audioPlayer.seek(to: .zero)
//        audioPlayer.play()
    }
}
