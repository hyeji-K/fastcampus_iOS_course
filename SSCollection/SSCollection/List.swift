//
//  List.swift
//  SSCollection
//
//  Created by heyji on 2022/06/07.
//

import Foundation

struct Contents: Hashable {
    let appImage: String
    let appName: String
    let appDescription: String
}

extension Contents {
    static let ott: [Contents] = [
//        Contents(appImage: "https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/91/b8/1a/91b81ab9-bda4-5499-d162-fa92a02aadb7/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/246x0w.png", appName: "Disney+", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "A1", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "2B+", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "3C+", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "4D+", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "5E+", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "6F+", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "F", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "G", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "H", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "I", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "J", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "K", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "L", appDescription: "Endless entertainment"),
    ]
    
    static let productivity: [Contents] = [
        Contents(appImage: "example", appName: "A", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "B+", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "C+", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "D+", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "E+", appDescription: "Endless entertainment"),
        Contents(appImage: "example", appName: "F+", appDescription: "Endless entertainment"),
    ]
}
