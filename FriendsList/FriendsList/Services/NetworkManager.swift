//
//  NetworkManager.swift
//  FriendsList
//
//  Created by Santiago Pelaez Rua on 11/03/21.
//

import Foundation
import Combine

class NetworkManager {
    static var shared = NetworkManager()
    
    private static let endpoint = "https://www.hackingwithswift.com/samples/friendface.json"
    private var cancellables: [AnyCancellable] = []
    private var cachedUsers: [UserStruct] = []
    
    func fetchUsers(completion: @escaping ([UserStruct]) -> Void){
        if !cachedUsers.isEmpty {
            completion(cachedUsers)
        }
        
        guard let url = URL(string: Self.endpoint) else {
            return
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [UserStruct].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
        
        cancellables.append(publisher.sink { [weak self] in self?.cachedUsers = $0 })
        cancellables.append(publisher.sink(receiveValue: completion))
    }
    
    func cancelFetch() {
        cancellables = []
    }
}
