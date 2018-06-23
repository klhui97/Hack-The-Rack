//
//  String+.swift
//  SmartPlant
//
//  Created by KL on 17/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

extension String {
    func sanitize() -> String {
        return self.replacingOccurrences(of: "\r", with: "")
    }
}
