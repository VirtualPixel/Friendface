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
        ScrollView {
            VStack {
                Group {
                    Text("Name: \(user.name)")
                    Image(systemName: user.isActive ? "checkmark.seal.fill" : "xmark.seal.fill")
                    Text("Age: \(user.age)")
                    Text("Company: \(user.company)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                    Text("About: \(user.about)")
                    Text("Registered: \(user.registered)")
                }
                Spacer()
                
                Text("Tags")
                    .font(.title)
                
                ForEach(user.tags, id: \.self) { tag in
                    Text("Sum \(tag)")
                }
                
                Spacer()
                Text("Friends")
                    .font(.title)
                
                ForEach(user.friends, id: \.self) { friend in
                    HStack {
                        Text("ID: \(friend.id)")
                        Text("\(friend.name)")
                    }
                }
            }
            .padding()
        }
    }
}

/*struct UserDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        UserDetail()
    }
}
*/
