//
//  FriendDetail.swift
//  FriendsList
//
//  Created by Santiago Pelaez Rua on 12/03/21.
//

import SwiftUI

struct FriendDetail: View {
    let friend: FriendStruct
    @State var friendData: UserStruct?
    
    var body: some View {
            Form {
                Section(header: Text("Friend Information")) {
                    InfoView(key: "Age", value: "\(friendData?.age ?? 0)")
                    InfoView(key: "Company", value: friendData?.company ?? "")
                    InfoView(key: "Email", value: friendData?.email ?? "")
                    InfoView(key: "Address", value: friendData?.address ?? "")
                }
                
                Section(header: Text("About")) {
                    Text(friendData?.about ?? "")
                }
                
                Section(header: Text("Tags")) {
                    ForEach(friendData?.tags ?? [], id: \.self) {
                        Text($0)
                    }
                }
            }.navigationBarTitle(friend.name,
                                 displayMode: .large)
            .onAppear(perform: {
                fetchData()
            })
    }
    
    func fetchData() {
        NetworkManager.shared.fetchUsers {
            self.friendData = $0.first(where: { $0.id == friend.id })
        }
    }
}

struct FriendDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FriendDetail(friend: FriendStruct(id: "", name: "Friendy"))
        }
    }
}
