//
//  UserProfile.swift
//  GithubSearch
//
//  Created by heyji on 2022/06/30.
//

import Foundation

struct UserProfile: Decodable, Hashable, Identifiable {
    let id: Int64
    let login: String
    let avatarUrl: URL
    let name: String
    let bio: String?
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case name
        case bio
        case followers
        case following
    }
}


/*
 "login": "hyeji-K",
     "id": 81549929,
     "node_id": "MDQ6VXNlcjgxNTQ5OTI5",
     "avatar_url": "https://avatars.githubusercontent.com/u/81549929?v=4",
     "gravatar_id": "",
     "url": "https://api.github.com/users/hyeji-K",
     "html_url": "https://github.com/hyeji-K",
     "followers_url": "https://api.github.com/users/hyeji-K/followers",
     "following_url": "https://api.github.com/users/hyeji-K/following{/other_user}",
     "gists_url": "https://api.github.com/users/hyeji-K/gists{/gist_id}",
     "starred_url": "https://api.github.com/users/hyeji-K/starred{/owner}{/repo}",
     "subscriptions_url": "https://api.github.com/users/hyeji-K/subscriptions",
     "organizations_url": "https://api.github.com/users/hyeji-K/orgs",
     "repos_url": "https://api.github.com/users/hyeji-K/repos",
     "events_url": "https://api.github.com/users/hyeji-K/events{/privacy}",
     "received_events_url": "https://api.github.com/users/hyeji-K/received_events",
     "type": "User",
     "site_admin": false,
     "name": "Khyeji",
     "company": null,
     "blog": "",
     "location": null,
     "email": null,
     "hireable": null,
     "bio": "iOS developer ",
     "twitter_username": null,
     "public_repos": 14,
     "public_gists": 0,
     "followers": 2,
     "following": 6,
     "created_at": "2021-03-29T05:42:32Z",
     "updated_at": "2022-06-26T09:41:22Z"
 }
 */
