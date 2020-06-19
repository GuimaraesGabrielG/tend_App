//
//  ExtensionDelegate.swift
//  TendApp WatchKit Extension
//
//  Created by Mateus Augusto M Ferreira on 16/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import WatchKit
import UserNotifications
class ExtensionDelegate: NSObject, WKExtensionDelegate, UNUserNotificationCenterDelegate {

    
    func applicationDidFinishLaunching() {
           print("Inicia o APP")
           UNUserNotificationCenter.current().delegate = self
           UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert]) { (granted, error) in
               if granted {
                   print("User gave permissions for local notifications")
               }
           }
           
       }
    

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
               // Update the app interface directly.
              
            print("willPresentNotification")
    //////
    //        var categories = Set<UNNotificationCategory>()
    //        let IKonw = UNNotificationAction(identifier: "KonwID", title: "I Konw", options: [.foreground])
    //        let DontCare = UNNotificationAction(identifier: "NotCareID", title: "Don't Care", options: [.foreground])
    //
    //        let myCategory = UNNotificationCategory(identifier: "myCategory", actions: [IKonw, DontCare], intentIdentifiers: [], options: []) //set up the actions here
    //        categories.insert(myCategory)
    ////        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
    //
    //        let ola = UNNotificationRequest(identifier: "myCategory", content: notification.request.content, trigger: trigger)
    //
    //        center.add(ola) { (error) in
    //            if error != nil {
    //                print("Error = \(error?.localizedDescription ?? "error local notification")")
    //            }
    //////        }
    //        center.setNotificationCategories(categories)
               // Play a sound.
            completionHandler([UNNotificationPresentationOptions.sound])
            
            
    //        func setCategories(){
    //            let snoozeAction = UNNotificationAction(identifier: "snooze", title: "Snooze 5 Sec", options: [])
    //             let commentAction = UNTextInputNotificationAction(identifier: "comment", title: "Add Comment", options: [], textInputButtonTitle: "Add", textInputPlaceholder: "Add Comment Here")
    //            let alarmCategory = UNNotificationCategory(identifier: "alarm.category",actions: [snoozeAction,commentAction],intentIdentifiers: [], options: [])
    //            UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    //        }
             
           }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Entrou aqui??")
        handleNotificationResponse(response: response)
        completionHandler()

    }
    
    func handleNotificationResponse(response: UNNotificationResponse) {
        // CustomCategory
        if response.notification.request.content.categoryIdentifier == "myCategory" {
            // 根据Action的ID区分
            if response.actionIdentifier == "KonwID" {
                print("Konw Action")
                print("PQ???????")
            } else if response.actionIdentifier == "NotCareID" {
                print("Don't Care Action")
            } else if response.actionIdentifier == "NotPushID" {
                print("Don't Push Action")
            } else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
                print("Default Action: Did Not Specify Custom ActionID")
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
