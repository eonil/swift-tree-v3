//
//  Tree.paths.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    /// Iterates paths to all nodes in tree.
    ///
    /// Sequence Iteration
    /// ------------------
    /// **PATHS DO NOT POINT ELEMENTS**.
    ///
    /// Please note that "node" means collection as this tree
    /// is tree of collections. Therefore, it starts with `[]` that
    /// means root collection which contains some children.
    ///
    /// Element Iteration
    /// -----------------
    /// You can get elements at paths easily like this.
    ///
    ///     let e = a[p.last!, in: p.dropLast()]
    ///
    /// Don't forget dropping first element in iteration which is `[]`,
    /// that has no element.
    ///
    var paths: TreePaths<Self> {
        return TreePaths<Self>(base: self)
    }
}

public struct TreePaths<Base> where Base: Tree {
    let base: Base
}


// MARK: DFS
public extension TreePaths {
    var dfs: TreePathDFSSequence<Base> {
        return TreePathDFSSequence<Base>(base: base)
    }
}
