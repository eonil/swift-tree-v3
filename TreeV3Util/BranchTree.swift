//
//  BranchTree.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

/// A `Tree` with `Branch` access.
///
/// Despite `Tree` is already providing default read-only
/// `branches` property, this protocol has been designed to provide
/// common and mutable interfaces. When you see a
/// concrete type named `-BranchTree`, it implies
/// providing direct mutable access to its branches.
///
/// - Note:
///     As `Tree` provides default `branches` implementation,
///     just denoting `: BranchTree` makes any `Tree`
///     to conform `BranchTree` automatically.
public protocol BranchTree: Tree where
//SubSequence.Element == Branches.Element.Value,
SubSequence == BranchTreeSlice<Branches.Element>,
Path: TreeV3Util.BranchPath,
Path.Element == SubSequence.Index {
    var branches: Branches { get }
    associatedtype Branches: Collection where
        Branches.Index == SubSequence.Index,
        Branches.Element: Branch,
//        Branches.Element.Branches.Index == SubSequence.Index,
        Branches.Element.Branches.SubSequence == Branches.SubSequence
}
public protocol RandomAccessBranchTree:
BranchTree,
RandomAccessTree where
Branches: RandomAccessCollection,
Branches.Element: RandomAccessBranch {
}
public protocol MutableBranchTree:
BranchTree,
MutableTree where
Branches: MutableCollection,
Branches.Element: MutableBranch {
}
public protocol RangeReplaceableBranchTree:
BranchTree,
RangeReplaceableTree where
Branches: RangeReplaceableCollection,
Branches.Element: RangeReplaceableBranch {
    var branches: Branches { get set }
}
