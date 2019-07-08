//
//  TreeCollection.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

/// An interface to access elements in a tree.
///
/// - Note:
///     This is designed as a flat interface to access tree structure.
///     Therefore different with `Branch` that is designed to
///     build free-form, pointer-based tree datastructures quickly.
///     Combination of two protocols produces `BranchTree`.
///
/// - Note:
///     `Path` is intentionally an opaque type. You can configure
///     how paths would work. One possible usage is implementing
///     path look-up as key look-up in table that can be used if you
///     want to vut down tree navigational look-up cost.
///
/// No Subtree Level Operation
/// --------------------------
/// In `Tree`s, every operations must be done at element level.
/// There's no way to insert/remove "subtree" at once.
/// Anyway, implementations are free to provide "extra" ways to deal
/// with such situations.
///
/// Conform to `Tree` Protocol
/// --------------------------
/// The simplest way to conform `Tree` protocol is
/// implementing these members.
/// - `path`
/// - `path(at:,in:)`
/// - `contents(in:)`
/// There're default implementations based on these members,
/// and you don't need to override them unless you need some
/// optimization.
///
/// If you want to make trees modiftable, conform `MutableTree`
/// and `RangeReplaceableTree` too.
///
public protocol Tree {
    associatedtype SubSequence: Collection
    associatedtype Path

//    func startIndex(in p:Path) -> SubSequence.Index
//    func endIndex(in p:Path) -> SubSequence.Index
//    func index(after i:SubSequence.Index, in p:Path) -> SubSequence.Index
//    func index(before i:SubSequence.Index, in p:Path) -> SubSequence.Index
//    func index(_ i:SubSequence.Index, offsetBy d:Int, in p:Path) -> SubSequence.Index
//    func distance(from a:SubSequence.Index, to b:SubSequence.Index, in p:Path) -> Int
//    subscript(_ i:SubSequence.Index, in p:Path) -> SubSequence.Element { get }

    /// Gets root path.
    var path: Path { get }
    /// Gets path at location.
    func path(at i:SubSequence.Index, in p:Path) -> Path
    /// Gets all elements at location.
    func contents(in p:Path) -> SubSequence
//    subscript(_ r:Range<SubSequence.Index>, in p:Path) -> SubSequence.SubSequence { get }
}
public protocol RandomAccessTree: Tree where SubSequence: RandomAccessCollection {
}
public protocol MutableTree: Tree {
    subscript(_ i:SubSequence.Index, in p:Path) -> SubSequence.Element { get set }
//    subscript(_ r:Range<SubSequence.Index>, in p:Path) -> SubSequence { get set }
}
public protocol RangeReplaceableTree: Tree {
    init()
    mutating func replaceSubrange<C>(_ r:Range<SubSequence.Index>, with es:C, in p:Path) where
    C:Collection,
    C.Element == SubSequence.Element
}
