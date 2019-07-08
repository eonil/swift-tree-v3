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
//        let s = TreePathDFSSequence(base: base)
//        return AnySequence(s)
//        return AnySequence(base.branches.dfs.map({ $0.path }))

        let a = AnySequence(CollectionOfOne(base.path))
        let b = AnySequence(base.branches.dfs.map({ $0.path }))
        let c = AnySequence([a,b].joined())
        return c
    }
    func dfs(at i:Base.SubSequence.Index, in p:Base.Path) -> AnySequence<Base.Path> {
        let a = AnySequence(CollectionOfOne(base.path))
        let b = AnySequence(base.branch(at: i, in: p).branches.dfs.map({ $0.path }))
        let c = AnySequence([a,b].joined())
        return c
    }
}

//private struct TreePathDFSSequence<Base>: Sequence where Base: Tree {
//    let base: Base
//    public func makeIterator() -> TreePathDFSIterator<Base> {
//        /// Root is a collection. Therefore, no value at root.
//        let s = base.contents(in: base.path)
//        let n = TreeNode<Base>(
//            base: base,
//            location: base.path,
//            sequence: s)
//        return TreePathDFSIterator<Base>(base: base, reversedStack: [n])
//    }
//}
//
//private struct TreePathDFSIterator<Base>: IteratorProtocol where Base: Tree {
//    typealias Index = Base.SubSequence.Index
//    typealias Path = Base.Path
//    let base: Base
//    fileprivate private(set) var reversedStack = [TreeNode<Base>]()
//    public mutating func next() -> Base.Path? {
//        guard !reversedStack.isEmpty else { return nil }
//        let x = reversedStack.removeLast()
//        reversedStack.append(contentsOf: x.lazy.reversed())
//        return x.location
//    }
//}
//
//private struct TreeNode<Base>: Collection where Base: Tree {
//    let base: Base
//    let location: Base.Path
//    let sequence: Base.SubSequence
//    var startIndex: Base.SubSequence.Index { return sequence.startIndex }
//    var endIndex: Base.SubSequence.Index { return sequence.endIndex }
//    func index(after i: Base.SubSequence.Index) -> Base.SubSequence.Index {
//        return base.index(after: i, in: location)
//    }
//    subscript(_ i:Base.SubSequence.Index) -> TreeNode {
//        let p = base.path(at: i, in: location)
//        let s = base.contents(in: p)
//        let n = TreeNode(
//            base: base,
//            location: p,
//            sequence: s)
//        return n
//    }
//}
