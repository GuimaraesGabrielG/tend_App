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

/// Triggers diferentes para mandar notificação
protocol ComponentsType: class {
    
    func scheduleNotificationNormal(components: DateComponents) -> UNCalendarNotificationTrigger
    func scheduleNotificationDelay() -> UNCalendarNotificationTrigger
}

class LocalNotificationHandler: NSObject, UNUserNotificationCenterDelegate{
    static var shared = LocalNotificationHandler()
    let center = UNUserNotificationCenter.current()
    var arrayIntervalNotification:[Int] = []
    
    //MARK: Schedule Notification
    func scheduleNotification(trigger: UNCalendarNotificationTrigger) {
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
            }
            
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
    
    
    /// Converter o item selecionado na notificação em intervalos de tempo
    /// - Parameter num: O periodo selecionado na tela de notificações
    func converterHorasforInterval(num:[Int]){
        self.arrayIntervalNotification = []
        for i in num{
            switch i {
            case 1:
                for multipleOfTwo in stride(from: 6, through: 12, by: 2) {
                    arrayIntervalNotification.append(multipleOfTwo)
                }
            case 2:
                for multipleOfTwo in stride(from: 12, through: 18, by: 2) {
                    
                    arrayIntervalNotification.append(multipleOfTwo)
                }
            case 3:
                for multipleOfTwo in stride(from: 18, through: 24, by: 2) {
                    
                    arrayIntervalNotification.append(multipleOfTwo)
                }
            case 4:
                for multipleOfTwo in stride(from: 0, through: 6, by: 2) {
                    
                    arrayIntervalNotification.append(multipleOfTwo)
                }
            default:
                print("Default")
            }
        }
        
        
        let orderedSet : NSOrderedSet = NSOrderedSet(array: self.arrayIntervalNotification)
        
        arrayIntervalNotification = (orderedSet.array as NSArray) as! [Int]
        
    }
    
    /// Manda a notificação nos periodos e datas estabelecidas
    func sendNotification(){
        self.converterHorasforInterval(num: UserDefaults.standard.array(forKey: "horasNotificacao") as! [Int])
        let dias = UserDefaults.standard.array(forKey: "diasNotificacao")! as! [Int]
        let horas = self.arrayIntervalNotification
        
        for i in dias{
            let dicPartitionPrepareArray = Dictionary(uniqueKeysWithValues: zip( Array(arrayLiteral: i), Array(arrayLiteral: horas)))
            
            let key = Array(dicPartitionPrepareArray)[0].key
            let value = Array(dicPartitionPrepareArray)[0].value
            for i in value{
                self.scheduleNotification(trigger: LocalNotificationHandler.shared.scheduleNotificationNormal(components: DateComponents(calendar: Calendar.current, hour: i,weekday: key)))
            }
            
        }
    }
}

extension LocalNotificationHandler: ComponentsType {
    
    ///
    /// - Parameter components: é a composição da data para mandar na hora e no dia da semana exato
    /// - Returns: retorna o trigger
    func scheduleNotificationNormal(components: DateComponents) -> UNCalendarNotificationTrigger {
        
        var information = DateComponents()
        
        information.hour = components.hour
        information.weekday = components.weekday
        
        return UNCalendarNotificationTrigger(dateMatching: information, repeats: true)
    }
    
    /// Método para adiar a notificação
    /// - Returns: retorna a trigger de adiamento da notificação
    func scheduleNotificationDelay() -> UNCalendarNotificationTrigger {
        let newDate = Date(timeInterval: 20*60, since: Date())
        
        let information = Calendar(identifier: .gregorian).dateComponents(in: .current, from: newDate)
        
        var info = DateComponents()
        info.minute = information.minute
        
        return UNCalendarNotificationTrigger(dateMatching: info, repeats: false)
    }
}
