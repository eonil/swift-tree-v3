//
//  BranchTree.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

/// A `Tree` of `Branch`es.
///
/// `BranchTree` is random-accessible by default.
///
public protocol BranchTree: Tree where
SubSequence.Element == Branches.Element.Value,
SubSequence == BranchTreeSlice<Branches.Element>,
Path: TreeV3.Path,
Path.Element == SubSequence.Index {
    var branches: Branches { get }
    associatedtype Branches: RandomAccessCollection where
        Branches.Index == SubSequence.Index,
        Branches.Element: Branch,
//        Branches.Element.Branches.Index == SubSequence.Index,
        Branches.Element.Branches.SubSequence == Branches.SubSequence
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

