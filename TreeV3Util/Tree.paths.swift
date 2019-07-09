//
//  Tree.paths.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    /// Provides iteration over "paths to collections" in tree.
    var paths: TreePaths<Self> {
        return TreePaths<Self>(base: self)
    }
}

public struct TreePaths<Base> where Base: Tree {
    let base: Base
}



// MARK: DFS
public extension TreePaths {
    var dfs: AnySequence<Base.Path> {
        let x = base
        let a = AnySequence(CollectionOfOne(base.path))
        let b = AnySequence(base.branches.dfs.map({ x.path(at: $0.index, in: $0.path) }))
        let c = AnySequence([a,b].joined())
        return c
    }
    func dfs(at i:Base.SubSequence.Index, in p:Base.Path) -> AnySequence<Base.Path> {
        let x = base
        let a = AnySequence(CollectionOfOne(base.path))
        let b = AnySequence(base.branch(at: i, in: p).branches.dfs.map({ x.path(at: $0.index, in: $0.path) }))
        let c = AnySequence([a,b].joined())
        return c
    }
}
