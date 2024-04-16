import SwiftUI

struct ContentView: View {
    var viewModel = ViewModel()

    var body: some View {
        ZStack {
            VStack() {
                HStack {
                    AsyncImage(url: viewModel.currentVideoData?.profilePictureURL) { image in
                        image.resizable()
                    } placeholder: { Color.black }
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 24))

                    VStack(alignment: .leading){
                        Text(viewModel.currentVideoData?.username ?? "username")
                            .font(.subheadline)
                            .fontDesign(.rounded)
                            .foregroundStyle(.white)
                        Text(viewModel.currentVideoData?.body ?? "caption")
                            .font(.headline)
                            .fontDesign(.rounded)
                            .foregroundStyle(.white)
                            .lineLimit(nil)
                            .frame(width: 200)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 38)
                        .foregroundStyle(.black)
                        .opacity(0.6)
                }
                Spacer()
                HStack {
                    IconView(systemIcon: "heart.fill", count: viewModel.currentVideoData?.heartReactions ?? 0)
                    Spacer()
                    IconView(systemIcon: "flame.fill", count: viewModel.currentVideoData?.fireReactions ?? 0)
                }
                Spacer()
            }
            .padding()
            .background {
                VideoPlayerView(data: viewModel.currentVideoData!)
                    .ignoresSafeArea(edges: [.bottom, .horizontal, .top])
                    .scaledToFill()
            }
        }
        .background(.black)
    }
}

#Preview {
    ContentView()
}
