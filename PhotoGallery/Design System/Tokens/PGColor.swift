//
//  PGColor.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import UIKit

public struct PGColor: Equatable {
    public let uiColor: UIColor
    public let cgColor: CGColor
    
    private init(uiColor: UIColor) {
        self.uiColor = uiColor
        self.cgColor = uiColor.cgColor
    }

    public static var white64: PGColor = PGColor(uiColor: UIColor(red: 255, green: 255, blue: 255, alpha: 0.64))
    public static var dark80: PGColor = PGColor(uiColor: UIColor(red: 50, green: 50, blue: 50, alpha: 1))
    public static var primary: PGColor = PGColor(uiColor: UIColor(red: 204, green: 32, blue: 37, alpha: 1))
    
    public static func == (lhs: PGColor, rhs: UIColor) -> Bool {
        var lr: CGFloat = 0, lg: CGFloat = 0, lb: CGFloat = 0, la: CGFloat = 0
        lhs.uiColor.getRed(&lr, green:&lg, blue:&lb, alpha:&la)
        var rr: CGFloat = 0, rg: CGFloat = 0, rb: CGFloat = 0, ra: CGFloat = 0
        rhs.getRed(&rr, green: &rg, blue: &rb, alpha: &ra)
        return lr == rr && lg == rg && lb == rb && la == ra
    }
}
