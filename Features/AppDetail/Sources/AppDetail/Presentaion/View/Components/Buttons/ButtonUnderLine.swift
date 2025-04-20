//
//  ButtonUnderLine.swift
//
//
//  Created by Yulian Hincapie on 19/04/25.
//

import SwiftUI
import AppCommons

public struct ButtonUnderLine: View {
    @Environment(\.openURL) var openURL
    
    let permalink: String
    
    public init(permalink: String) {
        self.permalink = permalink
    }
    
    public var body: some View {
        Button(action: {
            guard let url = URL(string: permalink) else { return }
            openURL(url)
        }, label: {
            HStack {
                Text("More information").specialGothic(14, colorText: AppColors.appBlue)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
                    .background(
                        AppColors.appBlue
                            .frame(height: 1)
                            .offset(y: 12)
                            .padding(EdgeInsets(top: 5, leading: 19, bottom: 0, trailing: -1))
                    )
                
                Spacer()
            }
            
        })
    }
}

