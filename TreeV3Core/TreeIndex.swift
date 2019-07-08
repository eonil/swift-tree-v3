//
//  TreeRange.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/09.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

//protocol TreeIndex {
//    associatedtype Path
//    associatedtype Bound
//    var path: Path { get }
//    var position: Bound { get }
//}
//protocol TreeRange {
//    associatedtype Bound: TreeIndex
//    var lowerBound: Bound { get }
//    var upperBound: Bound { get }
//}

///// Represents an index in a `Tree`.
/////
///// `TreeIndex` cannot provide default `Strideable` implementation
///// because there's no generic way to stride paths and indices together.
///// Implementation can provide strideability if possible.
/////
///// `Path` can be an opaque type to provide freedom to implementations.
//public struct TreeIndex<Path,Bound> where Bound: Comparable {
//    public var path: Path
//    public var position: Bound
//}
//extension TreeIndex: Equatable where Path: Equatable, Bound: Equatable {}
//extension TreeIndex: Comparable where Path: Comparable, Bound: Comparable {
//    public static func < (lhs: TreeIndex<Path, Bound>, rhs: TreeIndex<Path, Bound>) -> Bool {
//        if lhs.path < rhs.path { return true }
//        return lhs.position < rhs.position
//    }
//}
//extension TreeIndex: Hashable where Path: Hashable, Bound: Hashable {}
//
//extension Range: TreeRange where Bound == TreeIndex

///// This can be defined only if `Path: Comparable`.
///// If it is not, you can try `TreeBranchRange`.
//typealias TreeRange<Path,Bound> = Range<TreeIndex<Path,Bound>> where Path: Comparable, Bound: Comparable
//
///// Locate specific elements in a branch in a `Tree`.
/////
///// This is something like `Range` in `Collection` for `Tree`.
/////
//public struct TreeBranchRange<Path,Bound> where Bound: Comparable {
//    public var path: Path
//    public var range: Range<Bound>
//}
//extension TreeBranchRange: Equatable where Path: Equatable, Bound: Equatable {}
//extension TreeBranchRange: Hashable where Path: Hashable, Bound: Hashable {}
//extension TreeRange:
//Sequence,
//Collection,
//BidirectionalCollection,
//RandomAccessCollection where
//Bound: Strideable,
//Bound.Stride: SignedInteger {
//    public typealias Element = TreeIndex<Path,Bound>
//    public typealias Index = Bound
//    public typealias Iterator = TreeRangeIterator<Path,Bound>
//    public func makeIterator() -> Iterator {
//        return TreeRangeIterator(p: path, it: range.makeIterator())
//    }
//    public var startIndex: Index { range.startIndex }
//    public var endIndex: Index { range.endIndex }
//    public func index(before i:Index) -> Index { range.index(before: i) }
//    public func index(after i:Index) -> Index { range.index(after: i) }
//    public subscript(_ i:Index) -> Element {
//        let p = range[i]
//        return TreeIndex(path: path, position: p)
//    }
//}
//public struct TreeRangeIterator<Path,Bound>: IteratorProtocol where Bound: Strideable, Bound.Stride: SignedInteger {
//    fileprivate private(set) var p: Path
//    fileprivate private(set) var it: Range<Bound>.Iterator
//    public typealias Element = TreeIndex<Path,Bound>
//    public mutating func next() -> Element? {
//        guard let i = it.next() else { return nil }
//        return TreeIndex(path: p, position: i)
//    }
//}
