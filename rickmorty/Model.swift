//
//  Model.swift
//  rickmorty
//
//  Created by duverney muriel on 13/08/23.
//

import Foundation

struct CharacterModel: Decodable{
    let id: Int
    let name: String
    let image: String
    let episode: [String]
    let locationURL: String
    let locationName: String
    
    enum CodingKeys: String,CodingKey {
        case id
        case name
        case image
        case episode
        case locationURL = "url"
        case location
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CharacterModel.CodingKeys> = try decoder.container(keyedBy: CharacterModel.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: CharacterModel.CodingKeys.id)
        self.name = try container.decode(String.self, forKey: CharacterModel.CodingKeys.name)
        self.image = try container.decode(String.self, forKey: CharacterModel.CodingKeys.image)
        self.episode = try container.decode([String].self, forKey: CharacterModel.CodingKeys.episode)
        
        let locationContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        self.locationName = try locationContainer.decode(String.self, forKey: .name)
        self.locationURL = try locationContainer.decode(String.self, forKey: .locationURL)
    }
}


struct EpisodeModel: Decodable{
    let id: Int
    let name: String
}

struct LocationModel:Decodable{
    let id:Int
    let name: String
    let dimension: String
}

struct CharacterBasicInfo{
    let name: String
    let image: URL?
    let firstEpisodetitle: String
    let diemnsion: String
    static var empty: Self{
        .init(name: "",image: nil, firstEpisodetitle: "", diemnsion: "")
    }
}
