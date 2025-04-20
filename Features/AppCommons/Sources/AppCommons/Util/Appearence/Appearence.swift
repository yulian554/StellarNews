//
//  Appearence.swift
//
//
//  Created by Yulian Hincapie on 19/04/25.
//

import SwiftUI

public struct AppFonts {
    public static let roboto = "Roboto"
    public static let specialGothic = "SpecialGothic"
}

public struct Appearance {
    
    public static  func registerPackageFonts() {
        loadPackageFonts()
    }
    
    static func loadPackageFonts() {
        
        let fontNames = [
            "Roboto.ttf",
            "SpecialGothic.ttf"
        ]
        
        fontNames.forEach{ registerFont(fileName: $0) }
    }
    
    static func registerFont(fileName: String) {
        guard let gFontRef = getFont(named: fileName) else {
            print("*** ERROR: ***")
            return
        }
    }
    
    static func getFont(named fileName: String) -> CGFont? {
        let url = Bundle.module.url(forResource: fileName, withExtension: nil)
        guard let gUrl = url,
              let gFontData = NSData(contentsOf: gUrl),
              let gDataProvider = CGDataProvider(data: gFontData),
              let gFontRef = CGFont(gDataProvider) else {
            print("*** ERROR: ***")
            return nil
        }
        
        return gFontRef
    }
}


public extension Text {
    
    func specialGothic(_ size: CGFloat, colorText: Color? = Color.black, textAligment: TextAlignment = .leading) -> some View {
        return self.font(Font.custom(AppFonts.specialGothic, fixedSize: size))
            .multilineTextAlignment(textAligment)
            .foregroundColor(colorText)
    }
    
    func roboto(_ size: CGFloat, colorText: Color? = Color.black, textAligment: TextAlignment = .leading) -> some View {
        return self.font(Font.custom(AppFonts.roboto, fixedSize: size))
            .multilineTextAlignment(textAligment)
            .foregroundColor(colorText)
    }
}
