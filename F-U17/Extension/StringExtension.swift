//
//  StringExtension.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/16.
//

import Foundation

extension String {
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex ..< self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
}
