//
//  Tree.map.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    func map<X>(_ mfx: (SubSequence.Element) -> X) -> ArrayBranchTree<X> where
    Path == ArrayBranchTree<X>.Path {
        var a = ArrayBranchTree<X>()
        for p in paths.dfs {
            let s = sequence(in: p).lazy.map(mfx)
            a.append(contentsOf: s, in: p)
        }
        return a
    }
}
