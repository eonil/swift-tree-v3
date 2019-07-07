//
//  BranchTreeSlice.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public struct BranchTreeSlice<Base>: RandomAccessCollection where
Base: RandomAccessCollection,
Base.Element: Branch {
    let base: Base
    public typealias Index = Base.Index
    public typealias Element = Base.Element.Value
    public var startIndex: Index { return base.startIndex }
    public var endIndex: Index { return base.endIndex }
    public func index(after i: Index) -> Index { return base.index(after: i) }
    public func index(before i: Index) -> Index { return base.index(before: i) }
    public func index(_ i:Index, offsetBy d:Int) -> Index { return base.index(i, offsetBy: d) }
    public subscript(_ i:Index) -> Element { return base[i].value }
}
