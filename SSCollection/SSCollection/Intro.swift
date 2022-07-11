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
        Intro(title: "GET APP", name: "Disney+", description: "Endless entertainment", thumbnailImageName: "example3", appImage: "https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/91/b8/1a/91b81ab9-bda4-5499-d162-fa92a02aadb7/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/246x0w.png", appName: "Disney+", appDescription: "Endless entertainment"),
        Intro(title: "GET APP", name: "Apple TV", description: "The home of Apple TV+", thumbnailImageName: "example", appImage: "https://is1-ssl.mzstatic.com/image/thumb/Purple122/v4/9c/f7/8a/9cf78ad4-5443-acc0-3b36-f13d2ad7d64c/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.png", appName: "Apple TV", appDescription: "The home of Apple TV+"),
        Intro(title: "GET APP", name: "카카오페이지", description: "Entertainment", thumbnailImageName: "example2", appImage: "https://is1-ssl.mzstatic.com/image/thumb/Purple122/v4/52/38/80/52388060-f383-12c5-f11f-fe6a5c1c21f3/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.webp", appName: "카카오페이지", appDescription: "Entertainment"),
    ]
}
