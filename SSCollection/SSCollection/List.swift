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
        Contents(appImage: "Disney", appName: "Disney+", appDescription: "Endless entertainment"),
        Contents(appImage: "Netflix", appName: "Netflix", appDescription: "Start Watching"),
        Contents(appImage: "WATCHA", appName: "왓챠 - WATCHA", appDescription: "영화, 드라마 정주행, 매주 5백 편 신작 업데이트"),
        Contents(appImage: "coupangplay", appName: "쿠팡플레이", appDescription: "와우회원을 위한 무제한 스트리밍 서비스"),
        Contents(appImage: "AppleTV", appName: "Apple TV", appDescription: "The home of Apple TV+"),
        Contents(appImage: "APV", appName: "Amazon Prime Video", appDescription: "Originals, movies, TV, sports"),
        Contents(appImage: "tving", appName: "티빙(tving)", appDescription: "Entertainment"),
        Contents(appImage: "wavve", appName: "wavve(웨이브)", appDescription: "Entertainment"),
        Contents(appImage: "laftel", appName: "라프텔", appDescription: "Entertainment"),
        Contents(appImage: "SERIESON", appName: "네이버 시리즈온 - SERIES ON", appDescription: "온 세상, 온 재미, 영화/방송은 시리즈on에서!"),
        Contents(appImage: "seezn", appName: "seezn(시즌)", appDescription: "오늘의 즐거운 습관!"),
        Contents(appImage: "YouTube", appName: "YouTube: Watch, Listen, Stream", appDescription: "Videos, Music and Live Streams"),
    ]
    
    static let productivity: [Contents] = [
        Contents(appImage: "Notion", appName: "Notion - notes, docs, tasks", appDescription: "The all-in-one workspace"),
        Contents(appImage: "Evernote", appName: "Evernote", appDescription: "Note pad, to-do list, planner"),
        Contents(appImage: "bear", appName: "Bear - Markdown notes", appDescription: "Create, Tag, Export, Encrypt"),
        Contents(appImage: "GitHub", appName: "GitHub", appDescription: "Projects, ideas, & code to go"),
//        Contents(appImage: "", appName: "", appDescription: ""),
//        Contents(appImage: "", appName: "", appDescription: ""),
    ]
    
    static let music: [Contents] = [
        Contents(appImage: "Melon", appName: "멜론(Melon)", appDescription: "Music"),
        Contents(appImage: "AppleMusic", appName: "Apple Music", appDescription: "90 million songs, All ad-free"),
        Contents(appImage: "YouTubeMusic", appName: "YouTube Music", appDescription: "Music world dedicated to you"),
        Contents(appImage: "Spotify", appName: "Spotify - Music and Podcasts", appDescription: "Listen to Songs and Playlists"),
        Contents(appImage: "FLO", appName: "FLO - 플로", appDescription: "Music"),
        Contents(appImage: "genie", appName: "지니뮤직 - genie", appDescription: "Music"),
        Contents(appImage: "VIBE", appName: "NAVER VIBE(바이브)", appDescription: "Music"),
        Contents(appImage: "Bugs", appName: "벅스 - Bugs", appDescription: "Music"),
    ]
    
    static let books: [Contents] = [
        Contents(appImage: "YES24", appName: "예스24 eBook", appDescription: "Books"),
        Contents(appImage: "mlly", appName: "밀리의 서재", appDescription: "Books"),
        Contents(appImage: "ridi", appName: "리디 - 웹툰, 웹소설, 전자책 모두 여기에!", appDescription: "이야기를 즐기는 나만의 공간"),
        Contents(appImage: "kakao", appName: "카카오페이지", appDescription: "Entertainment"),
        Contents(appImage: "SERIES", appName: "SERIES - 네이버 시리즈", appDescription: "네이버 시리즈에서 인생작을 만나다"),
        Contents(appImage: "joara", appName: "웹소설 조아라", appDescription: "Entertainment"),
    ]
    
    static let shopping: [Contents] = [
        Contents(appImage: "Coupang", appName: "쿠팡 - Coupang", appDescription: "Shopping"),
        Contents(appImage: "ShinsegaeMall", appName: "이마트몰", appDescription: "Shopping"),
        Contents(appImage: "SSG", appName: "SSG.COM", appDescription: "Shopping"),
        Contents(appImage: "traders", appName: "트레이더스", appDescription: "LifeStyle"),
        Contents(appImage: "kurly", appName: "마켓컬리", appDescription: "내일의 장보기"),
        Contents(appImage: "bucket", appName: "오늘의 집 - 라이프스타일 슈퍼앱", appDescription: "Shopping"),
    ]
}
