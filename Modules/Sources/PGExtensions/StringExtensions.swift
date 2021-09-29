//
//  StringExtensions.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 02/08/21.
//

import Foundation

public extension String {
    public func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
            return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
        }
}
