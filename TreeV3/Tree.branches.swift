//
//  Tree.branches.swift
//  TreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    /// A default read-only view of tree in more object-oriented way.
    ///
    /// This effectively makes `Tree` to be compatible with `BranchTree`.
    var branches: Subtree<Self>.Branches {
        let p = path
        let s = sequence(in: p)
        return Subtree<Self>.Branches(base: self, location: p, sequence: s)
    }
}

/// A default implementation of element in `Tree.branches`.
/// This let you navigate `Tree` in more object-oriented interface.
public struct Subtree<Base>: Branch where Base: Tree {
    let base: Base
    let location: Base.Path
    let index: Base.SubSequence.Index

    public var value: Base.SubSequence.Element {
        return base[index, in: location]
    }
    public var branches: Branches {
        let p = base.path(at: index, in: location)
        let s = base.sequence(in: p)
        return Branches(base: base, location: p, sequence: s)
    }
    public struct Branches: Collection {
        let base: Base
        let location: Base.Path
        let sequence: Base.SubSequence
        public typealias Index = Base.SubSequence.Index
        public typealias Element = Subtree
        public var startIndex: Index { return sequence.startIndex }
        public var endIndex: Index { return sequence.endIndex }
        public func index(after i: Index) -> Index { return base.index(after: i, in: location) }
        public subscript(_ i:Index) -> Subtree {
            let p = location
            let n = Subtree(base: base, location: p, index: i)
            return n
        }
    }
}
extension Subtree.Branches: BidirectionalCollection where Base: RandomAccessTree {
    public func index(before i: Index) -> Index { return base.index(before: i, in: location) }
}
extension Subtree.Branches: RandomAccessCollection where Base: RandomAccessTree {
    public func index(_ i:Index, offsetBy d:Int) -> Index { return base.index(i, offsetBy: d, in: location) }
    public func distance(from a:Index, to b:Index) -> Int { return base.distance(from: a, to: b, in: location) }
}
