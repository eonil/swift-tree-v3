//
//  Tree.convert.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree where Self: MutableTree & RangeReplaceableTree {
    init<X>(converting x:X) where
    X:Tree,
    X.SubSequence.Element == SubSequence.Element {
        self = Self()
        append(contentsOf: x, from: x.path, into: path)
    }
    private mutating func append<X>(contentsOf x:X, from p1:X.Path, into p2:Path) where
    X:Tree,
    X.SubSequence.Element == SubSequence.Element {
        let s1 = x.sequence(in: p1)
        let s2 = sequence(in: p2)
        let r2 = s2.startIndex..<s2.endIndex
        replaceSubrange(r2, with: s1, in: p2)
        let s2a = sequence(in: p2)
        let z = zip(s1.indices, s2a.indices)
        for (i1,i2) in z {
            let cp1 = x.path(at: i1, in: p1)
            let cp2 = path(at: i2, in: p2)
            append(contentsOf: x, from: cp1, into: cp2)
        }
    }
}
