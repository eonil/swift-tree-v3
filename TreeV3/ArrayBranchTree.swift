//
//  ArrayBranchTree.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public struct ArrayBranchTree<Element>:
BranchTree,
MutableBranchTree,
RangeReplaceableBranchTree,
ExpressibleByArrayLiteral {
    public typealias Path = IndexPath
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
    public subscript(_ i:Int, in p:IndexPath) -> Element {
        get { return branches[i, in: p].value }
        set(x) { branches[i, in: p].value = x }
    }
}
