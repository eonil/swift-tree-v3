//
//  ICPathTree.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

/// A `Tree` uses collection of indices as its path.
///
/// Point of `ICPathTree` is using `ICPath` as its path.
/// This provides more freedom to navigate trees. This enables
/// a lot of convenience to navigate branches.
///
public protocol ICPathTree: Tree where
//SubSequence.Element == Branches.Element.Value,
SubSequence == ICPathTreeSlice<Branches.Element>,
Path: ICPath,
Path.Element == SubSequence.Index {
    var branches: Branches { get }
    associatedtype Branches: Collection where
        Branches.Index == SubSequence.Index,
        Branches.Element: Branch,
//        Branches.Element.Branches.Index == SubSequence.Index,
        Branches.Element.Branches.SubSequence == Branches.SubSequence
}

public protocol RandomAccessICPathTree:
ICPathTree,
RandomAccessTree where
Branches: RandomAccessCollection,
Branches.Element: RandomAccessBranch {
}
public protocol MutableICPathTree:
ICPathTree,
MutableTree where
Branches: MutableCollection,
Branches.Element: MutableBranch {
}
public protocol RangeReplaceableICPathTree:
ICPathTree,
RangeReplaceableTree where
Branches: RangeReplaceableCollection,
Branches.Element: RangeReplaceableBranch {
    var branches: Branches { get set }
}
