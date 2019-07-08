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

/// A `Tree` that can replace their elements without modifying topology.
public protocol MutableTree: Tree {
    subscript(_ i:SubSequence.Index, in p:Path) -> SubSequence.Element { get set }
//    subscript(_ r:Range<SubSequence.Index>, in p:Path) -> SubSequence { get set }
}

/// A `Tree` that can modify collction at a node.
public protocol RangeReplaceableTree: Tree {
    init()
    /// Replaces elements in specific range.
    ///
    /// This DO NOT remove descendants. If any element in the range has any child,
    /// call fails and program crashes. You need to ensure no child in all elements
    /// in supplied range.
    ///
    mutating func replaceSubrange<C>(_ r:Range<SubSequence.Index>, with es:C, in p:Path) where
    C:Collection,
    C.Element == SubSequence.Element

}

///// A `Tree` that can modify topology.
//public protocol RangeReplaceableTree: Tree {
//    /// Replace subtrees in range with subtrees in another tree.
//    ///
//    /// This replaces topology. All descendants in the range will be removed
//    /// and new elements will be added with empty children.
//    ///
//    /// Take care that this affects to all descendants.
//    /// If you want to replace only elements without replacing descendants,
//    /// you have to use `subscript[,in:]` instead of.
//    ///
//    /// - Parameter tr: Target range to replace.
//    /// - Parameter sr: Source range in source branch in source tree.
//    /// - Parameter sp: Source path to source branch in source tree.
//    /// - Parameter s:  Source tree.
//    /// - Parameter tp: Target path to target range to be replaced.
//    ///
//    /// - Note:
//    ///     This assumes range-replacement in single node is
//    ///     most efficient way to deal with multiple elements.
//    ///     This is result of following `Swift.Collection` idiom.
//    ///
//    ///     If you have another more efficient design,
//    ///     you need another abstraction and interface to provide it.
//    ///
//    /// - Note:
//    ///     This is quite complicated, but needed to provide minimal
//    ///     interface.
//    mutating func replaceSubrange<T>(_ tr:Range<SubSequence.Index>, with sr:Range<SubSequence.Index>, in sp:Path, of s:T, in tp:Path) where
//    T:Tree,
//    T.SubSequence.Element == SubSequence.Element
//}
