//
//  ContentView.swift
//  Friendface
//
//  Created by Justin Wells on 10/29/22.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>
    @State private var downloadedUsers: [User] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(users) { user in
                        NavigationLink {
                            UserDetail(user: user)
                            //Text(user.wrappedName)
                        } label: {
                            HStack {
                                Image(systemName: user.wrappedIsActive ? "checkmark.seal.fill" : "xmark.seal.fill")
                                    .foregroundColor(user.wrappedIsActive ? .green : .red)
                                Text(user.wrappedName)
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Friendface")
            .task {
                await downloadUsers()
            }
        }
    }
    
    func downloadUsers() async {
        await MainActor.run {
            guard users.isEmpty else { return }
            
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                // ensure no error for the HTTP response
                guard error == nil else {
                    print("Error: \(error!)")
                    return
                }
                
                // ensure there is data returned from this HTTP response
                guard let data = data else {
                    print("No data")
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                
                // Parse JSON into array of User structs using JSONDecoder
                guard let downloadedUsers = try? decoder.decode([User].self, from: data) else {
                    print("Error: Couldn't decode into users array.")
                    return
                }
                
                // Check if changes need made
                /*guard users != theusers else {
                    print("No new data to set.")
                    return
                }*/
                
                // Set users to downloaded users
                self.downloadedUsers = downloadedUsers
                
                print("New data has been set.")
                
                var allUsers: [CachedUser] = []
                
                for entry in downloadedUsers {
                    let user = CachedUser(context: moc)
                    var friends: [CachedFriend] = []
                    
                    for friend in entry.friends {
                        let newFriend = CachedFriend(context: moc)
                        
                        newFriend.id = friend.id
                        newFriend.name = friend.name
                                                
                        friends.append(newFriend)
                    }
                    
                    user.id = entry.id
                    user.isActive = entry.isActive
                    user.name = entry.name
                    user.age = Int16(entry.age)
                    user.company = entry.company
                    user.email = entry.email
                    user.address = entry.address
                    user.about = entry.about
                    user.registered = entry.registered
                    user.tags = entry.tags
                    user.friends = friends
                    
                    for friend in user.wrappedFriends {
                        print("\(user.wrappedName) friend's name is \(friend.wrappedName)")
                    }
                    
                    allUsers.append(user)
                }
                
                try? moc.save()
                
            }
            
            task.resume()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
