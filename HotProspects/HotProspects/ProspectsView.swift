//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Santiago Pelaez Rua on 29/03/21.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum ProspectsOrder {
        case name, mostRecent
    }
    
    let filter: FilterType
    @State private var prospectsOrder: ProspectsOrder = .name
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        var result: [Prospect]
        
        switch filter {
        case .none:
            result = prospects.people
        case .contacted:
            result = prospects.people.filter { $0.isContacted }
        case .uncontacted:
            result = prospects.people.filter { !$0.isContacted }
        }
        
        switch prospectsOrder {
        case .name:
            return result.sorted { $0.name < $1.name }
        case .mostRecent:
            return result.sorted { $0.creationDate > $1.creationDate }
        }
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortSelection = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        
                        if filter == .none {
                            Spacer()
                            
                            if prospect.isContacted {
                                Image(systemName: "checkmark.circle.fill")
                                    .padding(.trailing)
                            } else {
                                Image(systemName: "circle.fill")
                                    .padding(.trailing)
                            }
                        }
                    }
                    .contextMenu(ContextMenu(menuItems: {
                        
                        Button(action: {
                            prospects.toggle(prospect)
                        }) {
                            if prospect.isContacted {
                                Text("Mark Uncontacted")
                            } else {
                                Text("Mark Contacted")
                            }
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind me") {
                                addNotification(for: prospect)
                            }
                        }
                    }))
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(trailing:
                                    HStack {
                                        Button(action: {
                                            isShowingScanner = true
                                        }) {
                                            Image(systemName: "qrcode.viewfinder")
                                            Text("Scan")
                                        }
                                        
                                        Button(action: {
                                            isShowingSortSelection = true
                                        }) {
                                            Image(systemName: "info.circle")
                                        }
                                    })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr],
                                simulatedData: "Santiago Pelaezz\nsantirua@gmail.coma",
                                completion: handleScan)
            }
            .actionSheet(isPresented: $isShowingSortSelection) {
                ActionSheet(title: Text("Order by:"),
                            buttons: [
                                .default(Text("name")) {
                                    prospectsOrder = .name
                                },
                                .default(Text("most recent")) {
                                    prospectsOrder = .mostRecent
                                }
                                ])
                            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner = false
        switch result {
        case let .success(code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            prospects.add(person)
        case let .failure(error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content,
                                                trigger: trigger)
            
            UNUserNotificationCenter.current().add(request,
                                                   withCompletionHandler: nil)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound])
                { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
