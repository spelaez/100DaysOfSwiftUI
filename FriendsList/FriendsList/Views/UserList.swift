//
//  UserList.swift
//  FriendsList
//
//  Created by Santiago Pelaez Rua on 11/03/21.
//

import SwiftUI
import Combine

struct UserCell: View {
    let user: UserStruct
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(user.name)
                Spacer()
                Text("\(user.age)").foregroundColor(.red)
            }
            Spacer(minLength: 8.0)
            Text(user.company)
                .fontWeight(.medium)
            Text(user.email)
                .fontWeight(.bold)
        }
    }
}

struct UserList: View {
    @State var users: [UserStruct] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink(destination: UserDetail(user: user)) {
                        UserCell(user: user)
                    }.cornerRadius(8.0)
                }
            }.onAppear(perform: {
                fetchUsers()
            })
            .navigationBarTitle("Users",
                                displayMode: .large)
        }
    }
    
    func fetchUsers() {
        NetworkManager.shared.fetchUsers {
            self.users = $0
        }
    }
}

struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList(users: [])
    }
}
