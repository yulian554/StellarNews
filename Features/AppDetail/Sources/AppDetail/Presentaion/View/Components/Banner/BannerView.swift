//
//  BannerView.swift
//
//
//  Created by Yulian Hincapie on 19/04/25.
//

import SwiftUI
import AppCommons

public struct BannerView: View {
    
    let image: String
    
    public init(image: String) {
        self.image = image
    }
    
    public var body: some View {
        VStack {
            ViewImage(url: image)
                .scaledToFit()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 320)
    }
}
