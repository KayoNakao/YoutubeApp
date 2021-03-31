//
//  UITableViewCell.swift
//  YoutubeApp
//
//  Created by Raphael Souza on 2020-04-02.
//  Copyright © 2020 Guarana Technologies Inc. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    
    /** Return identifier with the same name of the subclass */
    static var defaultIdentifier: String {
        return String(describing: self)
    }
}
