//
//  ViewModel.swift
//  rickmorty
//
//  Created by duverney muriel on 10/08/23.
//

import Foundation


final class ViewModel: ObservableObject{
    @Published var characterBasicInfo: CharacterBasicInfo = .empty

    func executeRequest() async {
        let characterURL = URL(string: "https://rickandmortyapi.com/api/character/1")!
        
        let (data, _) = try! await URLSession.shared.data(from: characterURL)
        let characterModel = try! JSONDecoder().decode(CharacterModel.self, from: data)
        print("Character Model \(characterModel)")
        
        let firstEpisodeURL = URL(string: characterModel.episode.first!)!
        let (dataFirstEpisode, _) = try! await URLSession.shared.data(from: firstEpisodeURL)
        let episodeModel = try! JSONDecoder().decode(EpisodeModel.self, from: dataFirstEpisode)
        print("Episode MOdel \(episodeModel)")
        
        let characterLocationURL = URL(string: characterModel.locationURL)!
        let (dataLocation, _) = try! await URLSession.shared.data(from: characterLocationURL)
        let locationModel = try! JSONDecoder().decode(LocationModel.self, from: dataLocation)
        print("location Model \(locationModel)")
        
        DispatchQueue.main.async {
            self.characterBasicInfo = .init(name: characterModel.name, image: URL(string: characterModel.image), firstEpisodetitle: episodeModel.name, diemnsion: locationModel.dimension)
        }
        }
        
    }

