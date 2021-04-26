//
//  ContentView.swift
//  BucketList
//
//  Created by Santiago Pelaez Rua on 16/03/21.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var isShowingAlert = false
    
    var body: some View {
        if isUnlocked {
            MapPlacesView()
        } else {
            Button("Unlock places") {
                self.authenticate()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert(isPresented: $isShowingAlert, content: {
                Alert(title: Text("Authentication failed"),
                      message: Text("Please try again"),
                      dismissButton: .default(Text("Ok")))
            })
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        isShowingAlert = true
                    }
                }
            }
        } else {
            isShowingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
