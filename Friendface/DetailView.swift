//
//  DetailView.swift
//  Friendface
//
//  Created by Dmitry Sharabin on 10.12.2021.
//

import SwiftUI

struct DetailView: View {
    let user: CachedUser
    
    var formattedDateOfRegistration: String {
        user.wrappedRegistered.formatted(date: .numeric, time: .omitted)
    }
    
    var body: some View {
        List {
            Section {
                VStack {
                    Image(systemName: "person.crop.circle.badge")
                        .font(.system(size: 100, weight: .thin))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(user.isActive ? .green : .red, .secondary)
                    
                    
                    Text(user.wrappedName)
                        .font(.largeTitle)
                    
                    HStack {
                        Image(systemName: "building.2")
                        Text(user.wrappedCompany)
                    }
                    .foregroundColor(.secondary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(user.wrappedTags, id: \.self) {
                                Text("#\($0)")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                                    .padding(7)
                                    .background(
                                        RoundedRectangle(cornerRadius: 7)
                                            .fill(.gray.opacity(0.15))
                                    )
                            }
                        }
                    }
                    .padding(.top, 10)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .listRowBackground(Color.clear)
            
            Section {
                Text(user.wrappedAbout)
            } header: {
                Text("About")
            } footer: {
                Text("Registered on \(formattedDateOfRegistration)")
            }
            
            Section {
                HStack {
                    Image(systemName: "envelope")
                    Text(user.wrappedEmail)
                }
                
                HStack {
                    Image(systemName: "map")
                    Text(user.wrappedAddress)
                }
            }
            
            Section {
                ForEach(user.friendsArray) {
                    Text($0.wrappedName)
                }
            } header: {
                HStack {
                    Text("Friends")
                    
                    Spacer()
                    
                    Text("\(user.friendsArray.count)")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
