//
//  BranchTree.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/09.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public protocol BranchesAccessible {
    var branches: Branches { get }
    associatedtype Branches: Collection where Branches.Element: Branch
}
public protocol BranchesReplaceable: BranchesAccessible {
    var branches: Branches { get set }
}
public protocol RecursiveBranchesAccessible: BranchesAccessible where
Branches.Element.Branches == Branches {
}

/// A `Tree` with explicit `branches` support.
///
/// - Note:
///     As `Tree` has an implicit `branches` implementation,
///     `branches` property will be implemented implicitly
///     or you can provide your own implementation.
public protocol BranchTree: RandomAccessTree, RecursiveBranchesAccessible where
Branches.Index == SubSequence.Index,
Branches.Element.Value == SubSequence.Element {

}
public protocol BranchReplaceableTree: BranchTree, MutableTree, RangeReplaceableTree, BranchesReplaceable where
Branches.Element: Branch & MutableBranch & RangeReplaceableBranch {
}

