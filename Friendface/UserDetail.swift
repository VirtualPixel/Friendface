//
//  UserDetail.swift
//  Friendface
//
//  Created by Justin Wells on 10/29/22.
//

import SwiftUI

struct UserDetail: View {
    let user: User
    
    var body: some View {
        List {
            Section {
                Text("Age: \(user.age)")
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("About: \(user.about)")
                Text("Registered: \(user.registered)")
            } header: {
                Text("Facts")
                    .font(.title)
            }
            
            Section {
                ForEach(user.tags, id: \.self) { tag in
                    Text("\(tag)")
                }
            } header: {
                Text("Tags")
                    .font(.title)
            }
            
            Section {
                ForEach(user.friends, id: \.self) { friend in
                    HStack {
                        Text("\(friend.name)")
                    }
                }
            } header: {
                Text("Friends")
                    .font(.title)
            }
        }
        .padding()
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        UserDetail(user: User.example)
    }
}

