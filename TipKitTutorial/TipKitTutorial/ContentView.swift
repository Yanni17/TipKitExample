//
//  ContentView.swift
//  TipKitTutorial
//
//  Created by Ioannis Pechlivanis on 04.03.25.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    @State private var contacts = ["Nick", "Ioannis", "Chance"]
    
    let addContactTip: AddContactTip = .init()
    let onDelete: DeleteTip = .init()
    
    var body: some View {
        NavigationStack {
            List {
                TipView(onDelete)
                
                ForEach(contacts, id: \.self) { contact in
                    Text(contact)
                }
                .onDelete { indexSet in
                    contacts.remove(atOffsets: indexSet)
                    Task { await DeleteTip.onDeleteEvent.donate() }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        addContactTip.invalidate(reason: .actionPerformed)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .popoverTip(addContactTip)
                }
            }
            .onAppear {
                Task { await DeleteTip.contactViewVisitedEvent.donate() }
            }
        }
    }
}


struct AddContactTip: Tip {
    
    var title: Text {
        Text("Add a contact")
    }
    
    var message: Text? {
        Text("Press the button to add a contact")
    }
}



struct DeleteTip: Tip {
    
    static var onDeleteEvent = Event(id: "onDeleteEvent")
    static var contactViewVisitedEvent = Event(id: "contactViewVisitedEvent")
    
    var title: Text {
        Text("Swipe to delete")
    }
    
    var message: Text? {
        Text("swipe to the left to delete a contact")
    }
    
    var image: Image? {
        Image(systemName: "hand.point.up.left.fill")
    }
    
    var rules: [Rule] {
        #Rule(Self.onDeleteEvent) { event in
            event.donations.count == 0
        }
        
        #Rule(Self.contactViewVisitedEvent) { event in
            event.donations.count > 2
        }
    }
}



#Preview {
    ContentView()
        .task {
//            try? Tips.resetDatastore()
            try? Tips.configure()
        }
}
