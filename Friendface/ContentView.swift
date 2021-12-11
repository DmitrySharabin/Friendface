//
//  ContentView.swift
//  Friendface
//
//  Created by Dmitry Sharabin on 10.12.2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
        SortDescriptor(\.company)
    ]) var users: FetchedResults<CachedUser>
    
    @State private var dataFetched = false
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.wrappedName)
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
            let fetchedUsers = await loadData()
            
            await MainActor.run {
                if let fetchedUsers = fetchedUsers {
                    for user in fetchedUsers {
                        let cachedUser = CachedUser(context: moc)
                        
                        cachedUser.id = user.id
                        cachedUser.isActive = user.isActive
                        cachedUser.name = user.name
                        cachedUser.age = Int16(user.age)
                        cachedUser.company = user.company
                        cachedUser.email = user.email
                        cachedUser.address = user.address
                        cachedUser.about = user.about
                        cachedUser.registered = user.registered
                        cachedUser.tags = user.tags.joined(separator: ",")
                        
                        for friend in user.friends {
                            let cachedFriend = CachedFriend(context: moc)
                            
                            cachedFriend.id = friend.id
                            cachedFriend.name = friend.name
                            cachedFriend.addToUser(cachedUser)
                            
                            cachedUser.addToFriends(cachedFriend)
                        }
                    }
                    
                    if moc.hasChanges {
                        try? moc.save()
                    }
                }
            }
        }
    }
    
    func loadData() async -> [User]? {
        if dataFetched { return nil }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL.")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedData = try? decoder.decode([User].self, from: data) {
                dataFetched = true
                return decodedData
            }
        } catch {
            print("Invalid data.")
            return nil
        }
        
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
