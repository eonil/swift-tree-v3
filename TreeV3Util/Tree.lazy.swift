//
//  Tree.lazy.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    var lazy: LazyTree<Self> {
        return LazyTree<Self>(base: self)
    }
}
public struct LazyTree<Base> where Base: Tree {
    let base: Base
}

// MARK: Map
public extension LazyTree {
    func map<X>(_ transform: @escaping (Base.SubSequence.Element) -> X) -> LazyMapTree<Base,X> {
        return LazyMapTree<Base,X>(base: base, transform: transform)
    }
}
public struct LazyMapTree<Base,X>: Tree where Base: Tree {
    let base: Base
    let transform: (Base.SubSequence.Element) -> X
    public var path: Base.Path {
        return base.path
    }
    public func path(at i:Base.SubSequence.Index, in p:Base.Path) -> Base.Path {
        return base.path(at: i, in: p)
    }
    public func contents(in p:Base.Path) -> LazyMapCollection<Base.SubSequence,X> {
        return base.contents(in: p).lazy.map(transform)
    }
    public subscript(_ r:Range<Base.SubSequence.Index>, in p:Base.Path) -> LazyMapSequence<Base.SubSequence.SubSequence,X> {
        return base.contents(in: p)[r].lazy.map(transform)
    }
}
extension LazyMapTree: RandomAccessTree where Base: RandomAccessTree {}

//// MARK: Filter
//public extension LazyTree {
//    /// This is lazy per-node filtering keeping topology.
//    func topologyKeepingPerNodeFilter(_ isIncluded: @escaping (Base.SubSequence.Element) -> Bool) -> LazyFilterTree<Base> {
//        return LazyFilterTree<Base>(base: base, isIncluded: isIncluded)
//    }
//}
//public struct LazyFilterTree<Base>: Tree where Base: Tree {
//    let base: Base
//    let isIncluded: (Base.SubSequence.Element) -> Bool
//    public var path: Base.Path {
//        return base.path
//    }
//    public func path(at i:Base.SubSequence.Index, in p:Base.Path) -> Base.Path {
//        return base.path(at: i, in: p)
//    }
//    public func sequence(in p:Base.Path) -> LazyFilterCollection<Base.SubSequence> {
//        return base.sequence(in: p).lazy.filter(isIncluded)
//    }
//}
