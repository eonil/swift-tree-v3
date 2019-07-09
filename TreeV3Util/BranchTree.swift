//
//  BranchTree.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/09.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

/// A `Tree` with explicit `branches` support.
///
/// - Note:
///     As `Tree` has an implicit `branches` implementation,
///     `branches` property will be implemented implicitly
///     or you can provide your own implementation.
public protocol BranchTree: Tree {
    var branches: Branches { get }
    associatedtype Branches: Collection where
        Branches.Index == SubSequence.Index,
        Branches.Element: Branch,
        Branches.Element.Value == SubSequence.Element,
        Branches.Element.Branches.SubSequence == Branches.SubSequence
}

public protocol BranchReplaceableTree: BranchTree, MutableTree, RangeReplaceableTree where
Branches: MutableCollection & RangeReplaceableCollection,
Branches.Element: MutableBranch & RangeReplaceableBranch {
    var branches: Branches { get set }
}

/// A constraint to make `Tree.Branches == Tree.Branches.Element.Branches`.
/// This can make many things simple.
/// - Note:
///     Please suggest any better name...
public protocol RecursiveBranches: BranchTree where Branches.Element.Branches == Branches {
}
