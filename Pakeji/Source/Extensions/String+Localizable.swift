//
//  String+Localizable.swift
//  Pakeji
//
//  Created by Scott Takahashi on 02/05/21.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
