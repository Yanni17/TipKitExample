//
//  AddContactTip.swift
//  TipKitTutorial
//
//  Created by Ioannis Pechlivanis on 05.03.25.
//

import Foundation
import TipKit



struct AddContactTip: Tip {
    
    var title: Text {
        Text("Add a contact")
    }
    
    var message: Text? {
        Text("Press the button to add a contact")
    }
}
