//
//  Subtree.swift
//  TreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

/// A utility to navigate `Tree` in more object-oriented interface.
struct Subtree<Base>: Branch where Base: Tree, Base.SubSequence: RandomAccessCollection {
    let base: Base
    let location: Base.Path
    let index: Base.SubSequence.Index

    var value: Base.SubSequence.Element {
        return base[index, in: location]
    }
    var branches: Branches {
        let p = base.path(at: index, in: location)
        let s = base.sequence(in: p)
        return Branches(base: base, location: p, sequence: s)
    }
    struct Branches: RandomAccessCollection {
        let base: Base
        let location: Base.Path
        let sequence: Base.SubSequence
        typealias Index = Base.SubSequence.Index
        typealias Element = Subtree
        var startIndex: Index { return sequence.startIndex }
        var endIndex: Index { return sequence.endIndex }
        func index(after i: Index) -> Index { return base.index(after: i, in: location) }
        func index(before i: Index) -> Index { return base.index(before: i, in: location) }
        func index(_ i:Index, offsetBy d:Int) -> Index { return base.index(i, offsetBy: d, in: location) }
        func distance(from a:Index, to b:Index) -> Int { return base.distance(from: a, to: b, in: location) }
        subscript(_ i:Index) -> Subtree {
            let p = location
            let n = Subtree(base: base, location: p, index: i)
            return n
        }
    }
}
