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

/// Protocolo de triggers diferentes para mandar notificações.
protocol ComponentsType: class {
    func scheduleNotificationNormal(components: DateComponents) -> UNCalendarNotificationTrigger
    func scheduleNotificationDelay() -> UNCalendarNotificationTrigger
}

/// Classe de notificação local.
class LocalNotificationHandler: NSObject, UNUserNotificationCenterDelegate{
    static var shared = LocalNotificationHandler()
    let center = UNUserNotificationCenter.current()
    var arrayIntervalNotification:[Int] = []
    
    
    /// Função que cronograma a notificação.
    /// - Parameter trigger: Trigger da notificação.
    func scheduleNotification(trigger: UNCalendarNotificationTrigger) {
        let categoryIdentifier = "myCategory"
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("Realizar", comment: "")
        content.body =  NSLocalizedString("Recomendar", comment: "")
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = categoryIdentifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request) { (Error) in
            if((Error != nil)){
                print("Deu erro")
            }
        }
    }
    
    /// Função para responder o que o usuário clica nas actions.
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
    
    /// Função que converte o item selecionado na notificação em intervalos de tempo.
    /// - Parameter num: O periodo selecionado na tela de notificações.
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
    
    /// Função que manda a notificação nos periodos e datas estabelecidas.
    func sendNotification(){
        self.deletarNotificacoes()
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
    
    /// Função que ativa as notificações para o usuário.
    func ativarNotificacao(){
        LocalNotificationHandler.shared.center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("User gave permissions for local notifications")
            }else{
                
            }
        }
    }
    
    /// Função que remove as notificações.
    func deletarNotificacoes(){
        LocalNotificationHandler.shared.center.removeAllDeliveredNotifications()
        LocalNotificationHandler.shared.center.removeAllPendingNotificationRequests()
    }
}


extension LocalNotificationHandler: ComponentsType {
    
    /// Função que efetua o cronograma exato do período e dia da semana.
    /// - Parameter components: Composição da data para mandar na hora e no dia da semana exato.
    /// - Returns: Retorna o trigger.
    func scheduleNotificationNormal(components: DateComponents) -> UNCalendarNotificationTrigger {
        var information = DateComponents()
        information.hour = components.hour
        information.weekday = components.weekday
        return UNCalendarNotificationTrigger(dateMatching: information, repeats: true)
    }
    
    /// Função para adiar a notificação.
    /// - Returns: Retorna a trigger de adiamento da notificação.
    func scheduleNotificationDelay() -> UNCalendarNotificationTrigger {
        let newDate = Date(timeInterval: 20*60, since: Date())
        let information = Calendar(identifier: .gregorian).dateComponents(in: .current, from: newDate)
        var info = DateComponents()
        info.minute = information.minute
        return UNCalendarNotificationTrigger(dateMatching: info, repeats: false)
    }
}
