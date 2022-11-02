//
//  UserDetail.swift
//  Friendface
//
//  Created by Justin Wells on 10/29/22.
//

import SwiftUI

struct UserDetail: View {
    let user: CachedUser
    
    var body: some View {
        List {
            Section {
                Text("Age: \(user.wrappedAge)")
                Text("Company: \(user.wrappedCompany)")
                Text("Email: \(user.wrappedEmail)")
                Text("Address: \(user.wrappedAddress)")
                Text("About: \(user.wrappedAbout)")
                Text("Registered: \(user.wrappedRegistered)")
            } header: {
                Text("Facts")
                    .font(.title)
            }
            
            Section {
                ForEach(user.friendsArray, id: \.self) { friend in
                    HStack {
                        Text("\(friend.wrappedName)")
                    }
                }
            } header: {
                Text("Friends")
                    .font(.title)
            }
        }
        .padding()
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
