//
//  ContentView.swift
//  Friendface
//
//  Created by Justin Wells on 10/29/22.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(users) { user in
                        NavigationLink {
                            UserDetail(user: user)
                        } label: {
                            HStack {
                                Image(systemName: user.isActive ? "checkmark.seal.fill" : "xmark.seal.fill")
                                    .foregroundColor(user.isActive ? .green : .red)
                                Text(user.name)
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
                guard let theusers = try? decoder.decode([User].self, from: data) else {
                    print("Error: Couldn't decode into users array.")
                    return
                }
                
                guard users != theusers else {
                    print("No new data to set.")
                    return
                }
                
                users = theusers
                print("New data has been set.")
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
