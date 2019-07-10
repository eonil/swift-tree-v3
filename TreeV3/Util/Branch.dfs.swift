//
//  Branch.dfs.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Branch {
    /// Iterates all branches in DFS order.
    var dfs: BranchDFSSequence<Self> {
        return BranchDFSSequence<Self>(base: self)
    }
}
public struct BranchDFSSequence<Base>: Sequence where Base: Branch {
    let base: Base
    public func makeIterator() -> Iterator {
        return Iterator(reversedStack: [base])
    }
    public struct Iterator: IteratorProtocol {
        private(set) var reversedStack = [Base]()
        public mutating func next() -> Base? {
            guard !reversedStack.isEmpty else { return nil }
            let x = reversedStack.removeLast()
            reversedStack.append(contentsOf: x.branches.lazy.reversed())
            return x
        }
    }
}
