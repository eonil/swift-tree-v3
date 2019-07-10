//
//  ArrayBranch.swift
//  TreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public struct ArrayBranch<Element>:
Branch,
RandomAccessBranch,
MutableBranch,
RangeReplaceableBranch {
    public var value: Element
    public var branches: [ArrayBranch]
    public init(value v:Element, branches bs:[ArrayBranch] = []) {
        value = v
        branches = bs
    }
}
public extension ArrayBranch {
    init(converting x:ArrayBranch) {
        self = x
    }
}
public extension ArrayBranch {
    typealias Path = IndexPath
    subscript(_ p:Path) -> ArrayBranch {
        get {
            switch p.isEmpty {
            case true:  return self
            case false: return branches[p.first!][p.dropFirst()]
            }
        }
        set(x) {
            switch p.isEmpty {
            case true:  self = x
            case false: branches[p.first!][p.dropFirst()] = x
            }
        }
    }
}

