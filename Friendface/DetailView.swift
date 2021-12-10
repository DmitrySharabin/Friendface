//
//  DetailView.swift
//  Friendface
//
//  Created by Dmitry Sharabin on 10.12.2021.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        List {
            Section {
                VStack {
                    Image(systemName: "person.crop.circle.badge")
                        .font(.system(size: 100, weight: .thin))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(user.isActive ? .green : .red, .secondary)
                    
                    
                    Text(user.name)
                        .font(.largeTitle)
                    
                    HStack {
                        Image(systemName: "building.2")
                        Text(user.company)
                    }
                    .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .listRowBackground(Color.clear)
            
            Section("About") {
                Text(user.about)
            }
            
            Section {
                HStack {
                    Image(systemName: "envelope")
                    Text(user.email)
                }
                
                HStack {
                    Image(systemName: "map")
                    Text(user.address)
                }
            }
            
            Section {
                ForEach(user.friends) {
                    Text($0.name)
                }
            } header: {
                HStack {
                    Text("Friends")
                    
                    Spacer()
                    
                    Text("\(user.friends.count)")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(user:
                        User(id: UUID(), isActive: true, name: "John Doe", age: 42,
                             company: "Apple", email: "johndoe@apple.com", address: "12345 New Land",
                             about: "Dummy user for testing purposes", registered: Date.now,
                             tags: ["cillum", "consequat", "deserunt"],
                             friends: [Friend(id: UUID(), name: "Hawkins Patel"), Friend(id: UUID(), name: "Jewel Sexton"), Friend(id: UUID(), name: "Berger Robertson")])
            )
        }
    }
}
