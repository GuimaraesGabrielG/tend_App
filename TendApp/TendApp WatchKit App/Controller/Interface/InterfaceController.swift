//
//  InterfaceController.swift
//  TendApp WatchKit Extension
//
//  Created by Mateus Augusto M Ferreira on 16/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications

var Noticar = false
public class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var message: WKInterfaceLabel!
    @IBOutlet weak var startButton: WKInterfaceButton!
    
    override init() {
        super.init()
        self.setTitle(NSLocalizedString("TEND", comment: ""))
        self.message.setText(NSLocalizedString("Mensagem", comment: ""))
        self.startButton.setTitle(NSLocalizedString("Comecar", comment: ""))
        
    }
    
    public override func awake(withContext context: Any?) {
        // Configure interface objects here.
        super.awake(withContext: context)
        
    }
    
    public override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
       
    }

    public override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}

