//
//  TreeCollection.default.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    func isEmpty(in p:Path) -> Bool {
        let a = startIndex(in: p)
        let b = endIndex(in: p)
        assert(a <= b)
        return a == b
    }
    func count(in p:Path) -> Int {
        return distance(from: startIndex(in: p), to: endIndex(in: p), in: p)
    }
}
public extension RangeReplaceableTree {
    mutating func insert<C>(contentsOf es:C, at i:SubSequence.Index, in p:Path) where C:Collection, C.Element == Element {
        replaceSubrange(i..<i, with: es, in: p)
    }
    mutating func insert(_ e:Element, at i:SubSequence.Index, in p:Path) {
        replaceSubrange(i..<i, with: CollectionOfOne(e), in: p)
    }
    mutating func append<C>(contentsOf es:C, in p:Path) where C:Collection, C.Element == Element {
        let i = endIndex(in: p)
        replaceSubrange(i..<i, with: es, in: p)
    }
    mutating func append(_ e:Element, in p:Path) {
        let i = endIndex(in: p)
        replaceSubrange(i..<i, with: CollectionOfOne(e), in: p)
    }
    mutating func removeSubrange(_ r:Range<SubSequence.Index>, in p:Path) {
        replaceSubrange(r, with: EmptyCollection(), in: p)
    }
    mutating func remove(at i:SubSequence.Index, in p:Path) {
        let i1 = index(after: i, in: p)
        replaceSubrange(i..<i1, with: EmptyCollection(), in: p)
    }
    mutating func removeAll(in p:Path) {
        let r = startIndex(in: p)..<endIndex(in: p)
        replaceSubrange(r, with: EmptyCollection(), in: p)
    }
}










