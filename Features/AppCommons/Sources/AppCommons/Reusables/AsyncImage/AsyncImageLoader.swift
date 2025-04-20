//
//  AsyncImageLoader.swift
//
//
//  Created by Yulian Hincapie on 19/04/25.
//

import SwiftUI

//Implemented this way to support IOS versions below 15.0
public struct ViewImage: View {
    
    var url: String
    var contentMode: ContentMode?
    
    public init(url: String, contentMode: ContentMode? = nil) {
        self.url = url
        self.contentMode = contentMode
    }
    
    public var body: some View {
        AsyncImageLoader(url: URL(string: url), contentMode: contentMode)
    }
}

struct AsyncImageLoader: View {
    @State private var image: UIImage?

    let url: URL?
    var contentMode: ContentMode?

    var body: some View {
        if let image = image {
            if let contentMode = self.contentMode {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else {
                Image(uiImage: image)
                    .resizable()
            }
        } else {
            Color.clear
                .onAppear {
                    loadImage()
                }
        }
    }

    private func loadImage() {
        guard let url = self.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                }
            }
        }.resume()
    }
}
