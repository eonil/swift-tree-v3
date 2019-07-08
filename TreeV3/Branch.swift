//
//  Branch.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

/// A device to implement pointer-based tree structures quickly.
///
/// - Note:
///     Branches have dedicated collection for children.
///     This is intentional as the alternative design (attached value on a collection)
///     cannot satisfy `RangeReplaceableCollection`.
public protocol Branch {
    var value: Value { get }
    associatedtype Value
    
    var branches: Branches { get }
    associatedtype Branches: Collection where
        Branches.Element == Self
}
public protocol RandomAccessBranch: Branch where
Branches: RandomAccessCollection {
}
public protocol MutableBranch: Branch where
Branches: MutableCollection {
    var value: Value { get set }
}
public protocol RangeReplaceableBranch: Branch where
Branches: RangeReplaceableCollection {
    init(value: Value, branches: Branches)
    var branches: Branches { get set }
}
