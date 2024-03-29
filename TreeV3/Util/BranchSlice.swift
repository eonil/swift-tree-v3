//
//  BranchSlice.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public struct BranchSlice<Base>: Collection where
Base: Branch,
Base.Branches.SubSequence.Element.Value == Base.Value {
    let base: Base.Branches.SubSequence
    public typealias Index = Base.Branches.SubSequence.Index
//    public typealias Element = Base.Branches.SubSequence.Element.Value
    public typealias Element = Base.Value
    public typealias SubSequence = BranchSlice
    public var startIndex: Index { return base.startIndex }
    public var endIndex: Index { return base.endIndex }
    public func index(after i: Index) -> Index { return base.index(after: i) }

    public subscript(_ i:Index) -> Element { return base[i].value }
    public subscript(_ r:Range<Index>) -> BranchSlice<Base> { return BranchSlice(base: base[r]) }
}
public extension BranchSlice where Base.Branches: RandomAccessCollection {
    func index(before i: Index) -> Index { return base.index(before: i) }
    func index(_ i:Index, offsetBy d:Int) -> Index { return base.index(i, offsetBy: d) }
}
extension BranchSlice: BidirectionalCollection where
Base: RandomAccessBranch {
}
extension BranchSlice: RandomAccessCollection where
Base: RandomAccessBranch {
}
