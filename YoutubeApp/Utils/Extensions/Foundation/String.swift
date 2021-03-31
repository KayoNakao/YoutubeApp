//
//  String.swift
//  YoutubeApp
//
//  Created by Raphael Souza on 2020-04-02.
//  Copyright © 2020 Guarana Technologies Inc. All rights reserved.
//

import Foundation

extension String {
    /// Return the string from Localizable.strings
    
    var localized: String {
        let langCode = Locale.current.languageCode
        
        guard let path = Bundle.main.path(forResource: langCode, ofType: "lproj"), let bundle = Bundle(path: path) else {
            // Fallback to English
            let basePath = Bundle.main.path(forResource: "en", ofType: "lproj")!
            return Bundle(path: basePath)!.localizedString(forKey: self, value: "", table: nil)
        }
        return  bundle.localizedString(forKey: self, value: "", table: nil)
    }
    
    func date(_ format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.value
        return dateFormatter.date(from: self)
    }
}
