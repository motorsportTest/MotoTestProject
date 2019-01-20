//
//  Story.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import Foundation

struct Story: Decodable {
    let id: Int
    
    var storyData: StoryData?
}

extension Story: Hashable{
    static func == (lhs: Story, rhs: Story) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct StoryData: Decodable{
    let id: Int
    let authorName: String?
    let commentCount: Int?
    let score: Int?
    let createdAt: Date?
    let title: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case authorName = "by"
        case commentCount = "descendants"
        case score
        case createdAt = "time"
        case title
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.authorName = try? container.decode(String.self, forKey: .authorName)
        self.commentCount = try? container.decode(Int.self, forKey: .commentCount)
        self.score = try? container.decode(Int.self, forKey: .score)
        self.createdAt = try? container.decode(Date.self, forKey: .createdAt)
        self.title = try? container.decode(String.self, forKey: .title)
        self.url = try? container.decode(String.self, forKey: .url)
    }
    
}

struct StoriesArray {
    
    let stories: [Story]
    
    init(ids: [Int]) {
        stories = ids.map{Story.init(id: $0, storyData: nil)}
    }
    
}
