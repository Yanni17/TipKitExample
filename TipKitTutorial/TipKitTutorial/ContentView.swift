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



#Preview {
    ContentView()
        .task {
//            try? Tips.resetDatastore()
            try? Tips.configure()
        }
}
