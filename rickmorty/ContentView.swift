//
//  ContentView.swift
//  rickmorty
//
//  Created by duverney muriel on 10/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
        
    private var title: String = "El Titulo"
    var body: some View {
        
        VStack{
            Text(" RICK AND MORTY API").font(.subheadline)
            VStack{
                AsyncImage(url: viewModel.characterBasicInfo.image)
                Text("Name: \(viewModel.characterBasicInfo.name)")
                Text("first Episode: \(viewModel.characterBasicInfo.firstEpisodetitle)")
                Text("dimension \(viewModel.characterBasicInfo.diemnsion)")
            }.padding(.top, 32)
        }
        
        
        .onAppear{
            Task{
                await    viewModel.executeRequest()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
