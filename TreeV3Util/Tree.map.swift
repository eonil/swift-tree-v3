//
//  Tree.map.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    func map<X>(_ mfx: (SubSequence.Element) -> X) -> ArrayTree<X> where
    Path == ArrayTree<X>.Path {
        var a = ArrayTree<X>()
        for p in paths.dfs {
            let s = contents(in: p).lazy.map(mfx)
            a.append(contentsOf: s, in: p)
        }
        return a
    }
}
