import SwiftUI

struct ContentView: View {
    @State var viewModel = ViewModel()
    @State var offsetX: CGFloat = 0
    @State var offsetY: CGFloat = 0
    @State var showHeart = true
    @State var showFlame = true

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    AsyncImage(url: viewModel.currentVideoData?.profilePictureURL) { image in
                        image.resizable()
                    } placeholder: { Color.black }
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 24))

                    VStack(alignment: .leading){
                        Text(viewModel.currentVideoData?.username ?? "username")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                        Text(viewModel.currentVideoData?.body ?? "caption")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .lineLimit(nil)
                    }
                    .frame(width: 200, alignment: .leading)
                    Spacer()
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 38)
                        .foregroundStyle(.black)
                        .opacity(0.6)
                }
            }
            .padding()
            .background {
                VideoPlayerView(data: viewModel.currentVideoData!)
                    .ignoresSafeArea(edges: [.bottom, .horizontal, .top])
                    .scaledToFill()
            }
            .offset(x: offsetX, y: offsetY)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    withAnimation {
                        if abs(value.translation.width) > abs(value.translation.height) {
                            offsetX = value.translation.width
                            if value.translation.width < 0 {
                                showHeart = false
                                showFlame = true
                            } else {
                                showHeart = true
                                showFlame = false
                            }
                        } else {
                            offsetY = value.translation.height
                            withAnimation {
                                showHeart = false
                                showFlame = false
                            }
                        }
                    }
                })
                .onEnded({ value in
                    if abs(value.translation.width) > abs(value.translation.height) {
                        if value.translation.width < 0 {
                            viewModel.increaseFlameCount()
                        }

                        if value.translation.width > 0 {
                            viewModel.increaseHeartCount()
                        }
                    } else {
                        if value.translation.height < 0 {
                            viewModel.incrementVideoId()
                        }

                        if value.translation.height > 0 {
                            viewModel.decrementVideoId()
                        }
                    }
                    withAnimation {
                        offsetX = 0
                        offsetY = 0
                        showHeart = true
                        showFlame = true
                    }
                }))

            VStack {
                Spacer()
                HStack {
                    IconView(systemIcon: "heart.fill", count: viewModel.currentVideoData?.heartReactions ?? 0)
                        .opacity(showHeart ? 1 : 0)
                        .onTapGesture {
                            viewModel.increaseHeartCount()
                        }
                    Spacer()
                    IconView(systemIcon: "flame.fill", count: viewModel.currentVideoData?.flameReactions ?? 0)
                        .opacity(showFlame ? 1 : 0)
                        .onTapGesture {
                            viewModel.increaseFlameCount()
                        }
                        .padding(.trailing)
                }
                Spacer()
            }
            .padding()

        }
        .background(.black)
    }
}

#Preview {
    ContentView()
}
