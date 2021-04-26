//
//  UserDetail.swift
//  FriendsList
//
//  Created by Santiago Pelaez Rua on 11/03/21.
//

import SwiftUI

struct InfoView: View {
    let key: String
    let value: String
    
    var body: some View {
        HStack {
            Text(key)
                .foregroundColor(.red)
            Spacer()
            Text(value)
                .fontWeight(.bold)
        }
    }
}

struct UserDetail: View {
    let user: UserStruct
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                InfoView(key: "Age", value: "\(user.age)")
                InfoView(key: "Company", value: user.company)
                InfoView(key: "Email", value: user.email)
                InfoView(key: "Address", value: user.address)
            }
            
            Section(header: Text("About")) {
                Text(user.about)
            }
            
            Section(header: Text("Tags")) {
                ForEach(user.tags, id: \.self) {
                    Text($0)
                }
            }
            
            Section(header: Text("Friends")) {
                ForEach(user.friends, id: \.id) { friend in
                    NavigationLink(destination: FriendDetail(friend: friend)) {
                        Text(friend.name)
                    }
                }
            }
            
        }.navigationBarTitle(user.name,
                             displayMode: .large)
    }
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetail(user: UserStruct(id: "",
                                  isActive: true,
                                  name: "Test",
                                  age: 20,
                                  company: "GL",
                                  email: "TestGL",
                                  address: "Test",
                                  about: "Lorem Ipsum Dolor",
                                  registered: "Test",
                                  tags: ["test", "testing"],
                                  friends: [FriendStruct(id: "testFriend",
                                                   name: "Friendy")]))
        }
    }
}
