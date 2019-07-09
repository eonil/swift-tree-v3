//
//  ArrayTree.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

/// A tree built with `Swift.Array`.
public struct ArrayTree<Element>:
Tree,
BranchTree,
BranchReplaceableTree,
RecursiveBranches,
ExpressibleByArrayLiteral {
    /// Branches of this tree.
    ///
    /// This effectively overrides default `branches` property.
    public var branches = [ArrayBranch<Element>]()
    public init() {}
    public init(arrayLiteral es:Element...) {
        branches = es.map({ ArrayBranch(value: $0, branches: []) })
    }
}
public extension ArrayTree {
    init<C>(_ es:C) where C:Collection, C.Element == Element {
        branches = es.map({ ArrayBranch(value: $0, branches: []) })
    }
    init(_ es:[Element]) {
        branches = es.map({ ArrayBranch(value: $0, branches: []) })
    }
    init(branches bs:[ArrayBranch<Element>]) {
        branches = bs
    }
    init<C>(branches bs:C) where C:Collection, C.Element == ArrayBranch<Element> {
        branches = Array(bs)
    }
    init<C>(converting bs:C) where C:Collection, C.Element: Branch, C.Element.Value == Element {
        branches = bs.map(ArrayBranch.init(converting:))
    }
}

extension Array: BranchCollection {}
