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
        Contents(appImage: "https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/91/b8/1a/91b81ab9-bda4-5499-d162-fa92a02aadb7/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/246x0w.png", appName: "Disney+", appDescription: "Endless entertainment"),
        Contents(appImage: "https://is2-ssl.mzstatic.com/image/thumb/Purple112/v4/f1/07/54/f1075402-6015-53e8-f092-f03f1afc3847/AppIcon-1x_U007emarketing-0-10-0-0-85-220-0.png/246x0w.png", appName: "Netflix", appDescription: "Start Watching"),
        Contents(appImage: "https://is5-ssl.mzstatic.com/image/thumb/Purple112/v4/df/2b/53/df2b5300-48b6-d05b-37ad-d8a3bd217cf6/AppIcon-1x_U007emarketing-0-7-0-85-220.png/246x0w.png", appName: "왓챠 - WATCHA", appDescription: "영화, 드라마 정주행, 매주 5백 편 신작 업데이트"),
        Contents(appImage: "example", appName: "쿠팡플레이", appDescription: "와우회원을 위한 무제한 스트리밍 서비스"),
        Contents(appImage: "example", appName: "Apple TV", appDescription: "The home of Apple TV+"),
        Contents(appImage: "example", appName: "Amazon Prime Video", appDescription: "Originals, movies, TV, sports"),
        Contents(appImage: "example", appName: "티빙(tving)", appDescription: "Entertainment"),
        Contents(appImage: "example", appName: "wavve(웨이브)", appDescription: "Entertainment"),
        Contents(appImage: "example", appName: "라프텔", appDescription: "Entertainment"),
        Contents(appImage: "example", appName: "네이버 시리즈온 - SERIES ON", appDescription: "온 세상, 온 재미, 영화/방송은 시리즈on에서!"),
        Contents(appImage: "example", appName: "seezn(시즌)", appDescription: "오늘의 즐거운 습관!"),
        Contents(appImage: "example", appName: "YouTube", appDescription: ""),
    ]
    
    static let productivity: [Contents] = [
        Contents(appImage: "example", appName: "Notion - notes, docs, tasks", appDescription: "The all-in-one workspace"),
        Contents(appImage: "example", appName: "Evernote", appDescription: "Note pad, to-do list, planner"),
        Contents(appImage: "example", appName: "Bear - Markdown notes", appDescription: "Create, Tag, Export, Encrypt"),
        Contents(appImage: "example", appName: "GitHub", appDescription: "Projects, ideas, & code to go"),
//        Contents(appImage: "", appName: "", appDescription: ""),
//        Contents(appImage: "", appName: "", appDescription: ""),
    ]
    
    static let music: [Contents] = [
        Contents(appImage: "example", appName: "멜론(Melon)", appDescription: "Music"),
        Contents(appImage: "example", appName: "Apple Music", appDescription: "90 million songs, All ad-free"),
        Contents(appImage: "example", appName: "YouTube Music", appDescription: "Music world dedicated to you"),
        Contents(appImage: "example", appName: "Spotify - Music and Podcasts", appDescription: "Listen to Songs and Playlists"),
        Contents(appImage: "example", appName: "FLO - 플로", appDescription: "Music"),
        Contents(appImage: "example", appName: "지니뮤직 - genie", appDescription: "Music"),
        Contents(appImage: "example", appName: "NAVER VIBE(바이브)", appDescription: "Music"),
        Contents(appImage: "example", appName: "벅스 - Bugs", appDescription: "Music"),
    ]
    
    static let books: [Contents] = [
        Contents(appImage: "example", appName: "예스24 eBook", appDescription: "Books"),
        Contents(appImage: "example", appName: "밀리의 서재", appDescription: "Books"),
        Contents(appImage: "example", appName: "리디 - 웹툰, 웹소설, 전자책 모두 여기에!", appDescription: "이야기를 즐기는 나만의 공간"),
        Contents(appImage: "example", appName: "카카오페이지", appDescription: "Entertainment"),
        Contents(appImage: "example", appName: "SERIES - 네이버 시리즈", appDescription: "네이버 시리즈에서 인생작을 만나다"),
        Contents(appImage: "example", appName: "웹소설 조아라", appDescription: "Entertainment"),
    ]
    
    static let shopping: [Contents] = [
        Contents(appImage: "example", appName: "쿠팡 - Coupang", appDescription: "Shopping"),
        Contents(appImage: "example", appName: "이마트몰", appDescription: "Shopping"),
        Contents(appImage: "example", appName: "SSG.COM", appDescription: "Shopping"),
        Contents(appImage: "example", appName: "트레이더스", appDescription: "LifeStyle"),
        Contents(appImage: "example", appName: "마켓컬리", appDescription: "내일의 장보기"),
        Contents(appImage: "example", appName: "오늘의 집 - 라이프스타일 슈퍼앱", appDescription: "Shopping"),
    ]
}
