//
//  PDListBranch.swift
//  PDTreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation
import TreeV3Core
import TreeV3Util

public struct PDListBranch<Element>: Branch, RandomAccessBranch, MutableBranch, RangeReplaceableBranch {
    public var value: Element
    public var branches: PDList<PDListBranch>
    public init(value v:Element, branches bs:PDList<PDListBranch> = []) {
        value = v
        branches = bs
    }
}
public extension PDListBranch {
    init<X>(converting x:X) where X:Branch, X.Value == Element {
        value = x.value
        branches = PDList(x.branches.lazy.map(PDListBranch.init(converting:)))
    }
}
