//
//  Tree.branches.swift
//  TreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    /// Gets arbitrary branch in this tree.
    func branch(at i:SubSequence.Index, in p:Path) -> Subtree<Self> {
        return Subtree(base: self, path: p, index: i)
    }
    /// Gets top-level branches of ths tree.
    var branches: Subtree<Self>.Branches {
        let p = path
        let s = contents(in: p)
        return Subtree<Self>.Branches(base: self, location: p, sequence: s)
    }
}

/// A default implementation of element in `Tree.branches`.
/// This let you navigate `Tree` in more object-oriented interface.
/// - Note:
///     Consider renaming to `Node`.
public struct Subtree<Base>: Branch where Base: Tree {
    let base: Base
    public let path: Base.Path
    public let index: Base.SubSequence.Index
//    public var location: Base.Path {
//        return base.path(at: index, in: location)
//    }
    public var value: Base.SubSequence.Element {
        return base[index, in: path]
    }
    public var branches: Branches {
        let p = base.path(at: index, in: path)
        let s = base.contents(in: p)
        return Branches(base: base, location: p, sequence: s)
    }
    public struct Branches: Collection, BranchCollection {
        let base: Base
        // Names as `location` as this is a pre-composited path.
        let location: Base.Path
        let sequence: Base.SubSequence
        public typealias Index = Base.SubSequence.Index
        public typealias Element = Subtree
        public var startIndex: Index { return sequence.startIndex }
        public var endIndex: Index { return sequence.endIndex }
        public func index(after i: Index) -> Index { return base.index(after: i, in: location) }
        public subscript(_ i:Index) -> Subtree {
            let p = location
            let n = Subtree(base: base, path: p, index: i)
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
