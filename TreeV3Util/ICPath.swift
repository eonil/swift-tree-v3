//
//  ICPath.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

/// A path that is consist of indices of each level.
///
/// `IC-` stands for "Index Collection".
/// 
public protocol ICPath: BidirectionalCollection, ExpressibleByArrayLiteral where
Index == Int,
Element: Comparable,
SubSequence == Self {
    func appending(_ e:Element) -> Self
}

extension IndexPath: ICPath {}
extension ArraySlice: ICPath where Element: Comparable {
    public func appending(_ e: Element) -> ArraySlice<Element> {
        var a = self
        a.append(e)
        return a
    }
}
