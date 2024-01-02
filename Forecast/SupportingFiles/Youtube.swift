//
//  Youtube.swift
//  Forecast
//
//  Created by 李青芬 on 2023/12/23.
//
import Foundation

struct YouTubeModel: Codable {
    let items: [YouTubeItem]
}

struct YouTubeItem: Codable, Identifiable {
    let id: String
    let snippet: YouTubeSnippet
}

struct YouTubeSnippet: Codable {
    let title: String
    let description: String
    let thumbnails: YouTubeThumbnails
}

struct YouTubeThumbnails: Codable {
    let medium: YouTubeThumbnail
}

struct YouTubeThumbnail: Codable {
    let url: String
}
