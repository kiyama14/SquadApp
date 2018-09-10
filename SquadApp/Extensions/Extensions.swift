//
//  Extensions.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/12/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//


import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

let supaYellow = UIColor(rgb: 0xFFFA37)
let supaDarkYellow = UIColor(rgb: 0xD9D40F)
let supaRed = UIColor(rgb: 0xFC3758)
let supaBlue = UIColor(rgb: 0x33A1FD)
let supaGreen = UIColor(rgb: 0xA4E516)
let supaGray = UIColor(rgb: 0x707070)
let supaDarkerGray = UIColor(rgb: 0x4E4D4D)
let supaWhite = UIColor(rgb: 0xF8F9FB)
let supaBlack = UIColor(rgb: 0x030305)
let supaNewBlack = UIColor(rgb: 0x262634)
let supaPurple = UIColor(rgb: 0xC733FD)

// Font for each option in settings
let settingsFont = UIFont.systemFont(ofSize: 17, weight: .medium)


extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
    }
    
}
