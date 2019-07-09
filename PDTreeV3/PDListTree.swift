//
//  PDListTree.swift
//  PDTreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation
import TreeV3Core
import TreeV3Util

/// A tree built with `PDList` (`BTree.List`).
public struct PDListTree<Element>:
BranchTree,
BranchReplaceableTree,
RecursiveBranches,
ExpressibleByArrayLiteral {
    /// Branches of this tree.
    ///
    /// This effectively overrides default `branches` property.
    public var branches = PDList<PDListBranch<Element>>()
    public init() {}
    public init(arrayLiteral es:Element...) {
        branches = PDList(es.lazy.map({ PDListBranch(value: $0, branches: []) }))
    }
}
public extension PDListTree {
    init<C>(_ es:C) where C:Collection, C.Element == Element {
        branches = PDList(es.lazy.map({ PDListBranch(value: $0, branches: []) }))
    }
    init(branches bs:PDList<PDListBranch<Element>>) {
        branches = bs
    }
    init<C>(branches bs:C) where C:Collection, C.Element == PDListBranch<Element> {
        branches = PDList(bs)
    }
    init<C>(converting bs:C) where C:Collection, C.Element: Branch, C.Element.Value == Element {
        branches = PDList(bs.lazy.map(PDListBranch.init(converting:)))
    }
}
