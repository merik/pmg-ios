//
//  PMGColors.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

extension PMG {
    enum Colors: UInt64, CaseIterable {
        case base = 0x012a35ff
        case white = 0xffffffff
        case black = 0x000000ff
        case quiet = 0x9fbbc2ff
        case quietSemidark = 0x778c92ff
        case quietDark = 0x505e61ff
        case quietDarker = 0x30383aff
        case quietDarkest = 0x101313ff
        case quietLight = 0xcfdde1ff
        case quietLighter = 0xe7eef0ff
        case quietLightest = 0xf5f8f9ff
        case primary = 0x222831ff
        case primaryLighter = 0x222731ff
        case primaryDark = 0x0a5465ff
        case primaryDarker = 0x06323dff
        case primaryLight = 0x8ad4e5ff
        case primaryLightest = 0xe8f6faff
        case success = 0x00ca7cff
        case successDark = 0x00653eff
        case successDarker = 0x003d25ff
        case successLight = 0x80e5beff
        case successLighter = 0xbff2deff
        case successLightest = 0xe6faf2ff
        case warning = 0xffcc4bff
        case warningDarker = 0x4d3d17ff
        case danger = 0xf7503eff
        case dangerDark = 0x7c281fff
        case dangerDarker = 0x4a1813ff
        case dangerLight = 0xfba89fff
        case dangerLighter = 0xfdd3cfff
        case dangerLightest = 0xfeeeecff
        case ash = 0x434343ff
        case ashDark = 0x222222ff
        case shadow = 0x00000080
        case shadowDarker = 0x000000b3
        case shadowDarkest = 0x000000e6
        case shadowLight = 0x0000004d
        case shadowLighter = 0x00000026
        case shadowLightest = 0x00000012
        
        func description() -> String {
            return "\(self) \(String(format: "%8x", self.rawValue))"

        }
    }
}

public enum DarkProperty: UInt64 {
    case shadow          = 128
    case shadowDarker    = 179
    case shadowLight     = 77
    case shadowLighter   = 38
    case shadowLightest  = 18

    var float: CGFloat {
        return CGFloat(self.rawValue)/255.0
    }
}
