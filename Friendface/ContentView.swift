//
//  ContentView.swift
//  Friendface
//
//  Created by Dmitry Sharabin on 10.12.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        
                        Text(user.isActive ? "online" : "offline")
                            .font(.subheadline)
                            .foregroundColor(user.isActive ? .green : .secondary)
                    }
                }
            }
            .navigationTitle("Friendface")
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard users.isEmpty else { return }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL.")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedData = try? decoder.decode([User].self, from: data) {
                users = decodedData
            }
        } catch {
            print("Invalid data.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
