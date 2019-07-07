//
//  ArrayBranch.swift
//  TreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public struct ArrayBranch<Element>: Branch, MutableBranch, RangeReplaceableBranch {
    public var value: Element
    public var branches: [ArrayBranch]
    public init(value v:Element, branches bs:[ArrayBranch] = []) {
        value = v
        branches = bs
    }
}
