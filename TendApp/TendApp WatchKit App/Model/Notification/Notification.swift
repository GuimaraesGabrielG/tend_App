//
//  Notification.swift
//  TendApp WatchKit Extension
//
//  Created by Gabriel Gonçalves Guimarães on 23/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

protocol ComponentsType: class {
    
    func scheduleNotificationNormal(components: DateComponents) -> UNCalendarNotificationTrigger
    func scheduleNotificationDelay() -> UNCalendarNotificationTrigger
}

class LocalNotificationHandler: NSObject, UNUserNotificationCenterDelegate{
    static var shared = LocalNotificationHandler()
    let center = UNUserNotificationCenter.current()

    
    //MARK: Schedule Notification
    func scheduleNotification(trigger: UNCalendarNotificationTrigger) {
        center.removeAllDeliveredNotifications()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        /// Remove Previous Displayed Notification in case if you need
//        center.removeAllPendingNotificationRequests()
        let categoryIdentifire = "myCategory"

        let content = UNMutableNotificationContent()
        //adding title, subtitle, body and badge
        content.title = NSLocalizedString("Realizar", comment: "")
        content.body =  NSLocalizedString("Recomendar", comment: "")
        content.sound = UNNotificationSound.default

        content.categoryIdentifier = categoryIdentifire

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        
        //adding the notification to notification center
        center.add(request) { (Error) in
            if((Error != nil)){
                print("deu certo")
            }
            
            print("deu certo")
        }

       

    }

  
     /// Método para responder o que o usuário clica nas action
     /// - Parameter response: notificação solicitada ao userNotificationCenter(didReceive)
    func handleNotificationResponse(response: UNNotificationResponse) {
          if response.notification.request.content.categoryIdentifier == "myCategory" {
              
              if response.actionIdentifier == "adiar" {
                print("Adiou")
                self.scheduleNotification(trigger: self.scheduleNotificationDelay())
              } else if response.actionIdentifier == "vamos" {
                  print("OK!")
               
              } else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
                  print("Não especificou a action")
              } else if response.actionIdentifier == UNNotificationDismissActionIdentifier {
                  print("Dismiss Action: Specify A Dismiss Action")
              } else {
                  
              }
          } else if response.notification.request.content.categoryIdentifier.isEmpty {
              print("Deu ruim")
              // Default Category
          }
      }
}

extension LocalNotificationHandler: ComponentsType {
     
    func scheduleNotificationNormal(components: DateComponents) -> UNCalendarNotificationTrigger {
       
        var information = DateComponents()
        
        information.hour = components.hour
        information.weekday = components.weekday

        return UNCalendarNotificationTrigger(dateMatching: information, repeats: true)
    }
    
    func scheduleNotificationDelay() -> UNCalendarNotificationTrigger {
       let newDate = Date(timeInterval: 20*60, since: Date())

        let information = Calendar(identifier: .gregorian).dateComponents(in: .current, from: newDate)

        var info = DateComponents()
        info.minute = information.minute
        
        return UNCalendarNotificationTrigger(dateMatching: info, repeats: false)
    }
    
    
}
