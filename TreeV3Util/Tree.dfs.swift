//
//  Tree.dfs.swift
//  TreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree where SubSequence: RandomAccessCollection {
    /// Provide "element" access in DFS order.
    ///
    /// As `Tree` is tree of collections, this sequence is specially designed
    /// to provide "element-based" DFS order.
    ///
    /// You can iterate `Path` to each collections using `paths.dfs` instead of.
    /// As ordering of `paths.dfs` is based on "collection tree", iterating result
    /// can be different from expected.
    var dfs: AnySequence<SubSequence.Element> {
        return AnySequence(branches.dfs.map({ $0.value }))
    }
}

