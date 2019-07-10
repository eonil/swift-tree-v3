//
//  Branch.map.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/09.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Branch {
    func map<X>(_ mfx: (Value) -> X) -> ArrayBranch<X> {
        return ArrayBranch(value: mfx(value), branches: branches.map({ $0.map(mfx) }))
    }
}
