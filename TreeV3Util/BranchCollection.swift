//
//  BranchCollection.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/09.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

/// Provides a "super-useful" branches-by-path feature to a collection.
/// This couldn't be implemented without an explicit protocol
/// as Swift compiler fails on resolving recursive generic constraints.
public protocol BranchCollection: Collection {}
public extension BranchCollection where
Element: Branch,
Element.Branches == Self {
    /// Gets branches "branch collection" at path.
    subscript<P>(in p:P) -> Self where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return self
        case false: return self[p.first!].branches[in: p.dropFirst()]
        }
    }
}

public extension BranchCollection where
Element: Branch & MutableBranch & RangeReplaceableBranch,
Element.Branches == Self {
    /// Gets branches "branch collection" at path.
    subscript<P>(in p:P) -> Self where P:Collection, P.Element == Index {
        get {
            switch p.isEmpty {
            case true:  return self
            case false: return self[p.first!].branches[in: p.dropFirst()]
            }
        }
        set(x) {
            switch p.isEmpty {
            case true:  self = x
            case false: self[p.first!].branches[in: p.dropFirst()] = x
            }
        }
    }
}


/// This is same with above but compiler fails.

//extension Collection where
//Element: Branch,
//Element.Branches == Self {
//    subscript<P>(_ p:P) -> Self where P:Collection, P.Element == Index {
//        switch p.isEmpty {
//        case true:  return self
//        case false: return self[p.first!].branches[p.dropFirst()]
//        }
//    }
//}
