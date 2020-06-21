//
//  NotificationController.swift
//  TendApp WatchKit Extension
//
//  Created by Mateus Augusto M Ferreira on 16/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


public class NotificationController: WKUserNotificationInterfaceController {
    //Atributos para customizar o alert dinamico
    @IBOutlet var alertTitle: WKInterfaceLabel!
    @IBOutlet var body: WKInterfaceLabel!
    
    override init() {
        super.init()
        
    }

    public override func willActivate() {
        super.willActivate()
    }

    public override func didDeactivate() {
        super.didDeactivate()
    }
 
    /// - Parameter notification: chama a notificação
    public override func didReceive(_ notification: UNNotification) {
        
        //Customizando as labels da notificação dinamica
        self.alertTitle.setText(notification.request.content.title)
        
        self.body.setText(notification.request.content.body)
        
         //Criação das actions
        let adiar = UNNotificationAction(identifier: "adiar", title: NSLocalizedString("Adiar", comment: ""), options: [])
         let vamos = UNNotificationAction(identifier: "vamos", title: NSLocalizedString("Executar", comment: ""), options: [.foreground])
         notificationActions = [adiar, vamos]
    }
}
