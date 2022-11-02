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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>
    
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
        guard users.isEmpty else { return }
        
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let users = try decoder.decode([User].self, from: data)
            
            await MainActor.run {
                updateCache(with: users)
            }
        } catch {
            print("Download failed")
        }
    }
    
    func updateCache(with downloadedUsers: [User]) {
        for user in downloadedUsers {
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
                cachedUser.addToFriends(cachedFriend)
            }
            
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
