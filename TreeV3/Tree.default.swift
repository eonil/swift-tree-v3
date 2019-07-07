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
    func startIndex(in p:Path) -> SubSequence.Index {
        return sequence(in: p).startIndex
    }
    func endIndex(in p:Path) -> SubSequence.Index {
        return sequence(in: p).endIndex
    }
    func index(after i:SubSequence.Index, in p:Path) -> SubSequence.Index {
        return sequence(in: p).index(after: i)
    }

    subscript(_ i:SubSequence.Index, in p:Path) -> SubSequence.Element {
        return sequence(in: p)[i]
    }
    func subsequence(_ r:Range<SubSequence.Index>, in p:Path) -> SubSequence.SubSequence {
        return sequence(in: p)[r]
    }
}
public extension Tree where SubSequence: BidirectionalCollection {
    func index(before i:SubSequence.Index, in p:Path) -> SubSequence.Index {
        return sequence(in: p).index(before: i)
    }
}
public extension Tree where SubSequence: RandomAccessCollection {
    func count(in p:Path) -> Int {
        return distance(from: startIndex(in: p), to: endIndex(in: p), in: p)
    }
    func index(_ i:SubSequence.Index, offsetBy d:Int, in p:Path) -> SubSequence.Index {
        return sequence(in: p).index(i, offsetBy: d)
    }
    func distance(from a:SubSequence.Index, to b:SubSequence.Index, in p:Path) -> Int {
        return sequence(in: p).distance(from: a, to: b)
    }
}
public extension RangeReplaceableTree {
    mutating func insert<C>(contentsOf es:C, at i:SubSequence.Index, in p:Path) where C:Collection, C.Element == SubSequence.Element {
        replaceSubrange(i..<i, with: es, in: p)
    }
    mutating func insert(_ e:SubSequence.Element, at i:SubSequence.Index, in p:Path) {
        replaceSubrange(i..<i, with: CollectionOfOne(e), in: p)
    }
    mutating func append<C>(contentsOf es:C, in p:Path) where C:Collection, C.Element == SubSequence.Element {
        let i = endIndex(in: p)
        replaceSubrange(i..<i, with: es, in: p)
    }
    mutating func append(_ e:SubSequence.Element, in p:Path) {
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










