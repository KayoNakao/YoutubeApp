//
//  YTError.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-04-02.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import Foundation

enum YTError: Error {
    case unknown
    case noAuthentication


}

extension YTError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown: return Localizable.Error.unknown
        case .noAuthentication: return Localizable.Error.noAuthentication
        }
    }
}

extension Localizable {
    struct Error {
        static let title = "error_title".localized
        static let unknown = "error_unknown".localized
        static let noAuthentication = "error_no_authentication".localized

    }
}
