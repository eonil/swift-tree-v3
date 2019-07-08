//
//  Path.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public protocol BranchPath: BidirectionalCollection, ExpressibleByArrayLiteral where
Index == Int,
Element: Comparable,
SubSequence == Self {
    func appending(_ e:Element) -> Self
}

extension IndexPath: BranchPath {}
extension ArraySlice: BranchPath where Element: Comparable {
    public func appending(_ e: Element) -> ArraySlice<Element> {
        var a = self
        a.append(e)
        return a
    }
}
