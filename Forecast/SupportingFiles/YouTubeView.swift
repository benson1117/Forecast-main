//
//  YouTubeView.swift
//  Forecast
//
//  Created by 李青芬 on 2023/12/23.
//

import SwiftUI


struct YouTubeView: View {
    @ObservedObject var viewModel = YouTubeViewModel()
    @State private var selectedVideoId: String?
    let apiKey = "AIzaSyAJdN-ubIOs62NwJ9Kq5aJI9LFR1LJEJMw"  // 你的 YouTube Data API Key
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.videos.indices, id: \.self) { index in
                    let video = viewModel.videos[index]
                    
                    VStack {
                        NavigationLink(
                            destination: SafariView(url: URL(string: "https://www.youtube.com/watch?v=\(video.id)")!),
                            isActive: Binding(
                                get: { selectedVideoId == video.id },
                                set: { _ in selectedVideoId = nil }
                            )
                        ) {
                            Button(action: {
                                print("Opening URL: \(video.id)")
                                selectedVideoId = video.id
                            }) {
                                VStack {
                                    RemoteImage(url: video.snippet.thumbnails.medium.url)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 200)
                                    Text("Weather Report Number \(index + 1)") // 使用 index + 1 显示正确的季节编号
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchYouTubeVideos(videoIds: ["vJItfjchxKo", "JEImttY3mIY", "9V-41hlitsg", "2SnsabHViQI","J6EtjwPlL9w","0Z0piYKKLl8"], apiKey: apiKey)
            }
        }
    }
}

struct RemoteImage: View {
    let url: String
    @State private var imageData: Data?

    var body: some View {
        if let data = imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            Image(systemName: "photo")
                .resizable()
                .onAppear {
                    downloadImage()
                }
        }
    }

    private func downloadImage() {
        guard let imageUrl = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
            if let error = error {
                print("Error downloading image: \(error)")
            } else if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            }
        }.resume()
    }
}

struct YouTubeView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeView()
    }
}
