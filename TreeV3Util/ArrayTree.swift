//
//  ArrayTree.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public struct ArrayTree<Element>:
Sequence,
ICPathTree,
RandomAccessICPathTree,
MutableICPathTree,
RangeReplaceableICPathTree,
ExpressibleByArrayLiteral {
    public typealias Path = IndexPath
    /// Branches of this tree.
    ///
    /// This effectively overrides default `branches` property.
    public var branches = [ArrayBranch<Element>]()
    public init() {}
    public init<C>(_ es:C) where C:Collection, C.Element == Element {
        branches = es.map({ ArrayBranch(value: $0, branches: []) })
    }
    public init(_ es:[Element]) {
        branches = es.map({ ArrayBranch(value: $0, branches: []) })
    }
    public init(arrayLiteral es:Element...) {
        branches = es.map({ ArrayBranch(value: $0, branches: []) })
    }
    public init(branches bs:[ArrayBranch<Element>]) {
        branches = bs
    }
    public init<C>(branches bs:C) where C:Collection, C.Element == ArrayBranch<Element> {
        branches = Array(bs)
    }
    public init<C>(converting bs:C) where C:Collection, C.Element: Branch, C.Element.Value == Element {
        branches = bs.map(ArrayBranch.init(converting:))
    }
    public subscript(_ i:Int, in p:IndexPath) -> Element {
        get { return branches[i, in: p].value }
        set(x) { branches[i, in: p].value = x }
    }
    public subscript(_ r:Range<Int>, in p:Path) -> ICPathTreeSlice<ArrayBranch<Element>> {
        return contents(in: p)[r]
    }
    public func makeIterator() -> AnyIterator<Element> {
        return dfs.makeIterator()
    }
}

/// These are possible because `Path.Element == SubSequence.Index`.
public extension ArrayTree {
    subscript(_ p:Path) -> Element {
        get {
            precondition(!path.isEmpty)
            return branches[path.first!][path.dropFirst()].value
        }
        set(x) {
            precondition(!path.isEmpty)
            branches[path.first!][path.dropFirst()].value = x
        }
    }
}
