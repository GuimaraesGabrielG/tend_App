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


class NotificationController: WKUserNotificationInterfaceController {

    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    /// Antes de chamar essa função ele chama o notification center wiilreceive, no app delegate
    /// - Parameters:
    ///   - notification: chama a função PushNotificationPayload.anp
    ///   - completionHandler: Diz se a notificação é estática ou dinâmica -> custom = dinamica
//    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
//              performNotificationDefaultAction()
//
//                print(notification)
//
//        completionHandler(.custom)
//
//
//    }
    
    override func didReceive(_ notification: UNNotification) {
        
        print(notification)
         
         let IKonw = UNNotificationAction(identifier: "KonwID", title: "I Konw", options: [.foreground])
         let DontCare = UNNotificationAction(identifier: "NotCareID", title: "Don't Care", options: [])
         let DontPush = UNNotificationAction(identifier: "NotPushID", title: "Don't Push", options: [])

         notificationActions = [IKonw, DontCare, DontPush]
    }

//    override func didReceive(_ notification: UNNotification) {
//        performNotificationDefaultAction()
//
//        print("notification: \(notification)")
//           lbAlert.setText(notification.request.content.title)
//           lbBody.setText(notification.request.content.body)
//
//        completionHandler(.custom)
//    }
}
