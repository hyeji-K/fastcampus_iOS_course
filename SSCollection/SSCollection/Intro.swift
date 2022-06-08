//
//  Intro.swift
//  SSCollection
//
//  Created by heyji on 2022/06/07.
//

import Foundation

struct Intro: Hashable {
    let title: String
    let name: String
    let description: String
    let thumbnailImageName: String
    let appImage: String
    let appName: String
    let appDescription: String
}

extension Intro {
    static let list = [
        Intro(title: "GET APP", name: "Disney+", description: "Endless entertainment", thumbnailImageName: "example", appImage: "https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/91/b8/1a/91b81ab9-bda4-5499-d162-fa92a02aadb7/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/246x0w.png", appName: "Disney+", appDescription: "Endless entertainment"),
        Intro(title: "GET APP", name: "Disney+", description: "Endless entertainment", thumbnailImageName: "example", appImage: "", appName: "Disney+", appDescription: "Endless entertainment"),
        Intro(title: "GET APP", name: "Disney+", description: "Endless entertainment", thumbnailImageName: "", appImage: "", appName: "Disney+", appDescription: "Endless entertainment"),
//        Intro(title: "GET APP", name: "Disney+", description: "Endless entertainment", thumbnailImageName: "example", appImage: "https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/91/b8/1a/91b81ab9-bda4-5499-d162-fa92a02aadb7/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/246x0w.png", appName: "Disney+", appDescription: "Endless entertainment"),
//        Intro(title: "GET APP", name: "Disney+", description: "Endless entertainment", thumbnailImageName: "example", appImage: "https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/91/b8/1a/91b81ab9-bda4-5499-d162-fa92a02aadb7/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/246x0w.png", appName: "Disney+", appDescription: "Endless entertainment"),
    ]
}
