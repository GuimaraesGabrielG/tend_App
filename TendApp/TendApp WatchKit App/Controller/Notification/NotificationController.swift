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


/// Classe NotificationController.
public class NotificationController: WKUserNotificationInterfaceController {
    //Atributos para customizar o alert dinamico
    @IBOutlet var alertTitle: WKInterfaceLabel!
    @IBOutlet var body: WKInterfaceLabel!
    
    /// init
    override init() {
        super.init()
    }

    /// WillActivate.
    public override func willActivate() {
        super.willActivate()
    }

    /// DidActivate.
    public override func didDeactivate() {
        super.didDeactivate()
    }
 
    /// DidReceive.
    /// - Parameter notification: Chama a notificação.
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
