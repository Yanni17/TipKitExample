//
//  DeleteTip.swift
//  TipKitTutorial
//
//  Created by Ioannis Pechlivanis on 05.03.25.
//

import Foundation
import TipKit


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
