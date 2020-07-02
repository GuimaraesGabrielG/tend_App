//
//  ExtensionDelegate.swift
//  TendApp WatchKit Extension
//
//  Created by Mateus Augusto M Ferreira on 16/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import WatchKit
import UserNotifications


/// Uma coleção de métodos que gerenciam o comportamento no nível do aplicativo de uma extensão do WatchKit.
class ExtensionDelegate: NSObject, WKExtensionDelegate, UNUserNotificationCenterDelegate {
    static let notificationCenter = UNUserNotificationCenter.current()
    
    
    func applicationDidFinishLaunching() {
        /// Função que gera permissão de envio de notificações
        LocalNotificationHandler.shared.center.delegate = self
        
    }
    
    /// Função que reinicia qualquer tarefa, após a interrupção da aplicação.
    func applicationDidBecomeActive() {
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    /// Função que envia quando a aplicação está prestes de mudar o estado de inativo para ativo.
    func applicationWillResignActive() {
        
        // manda a notificação
        if let _ = UserDefaults.standard.array(forKey: "horasNotificacao"){
            if let _ = UserDefaults.standard.array(forKey: "diasNotificacao"){
                LocalNotificationHandler.shared.sendNotification()
            }
        }
        
        if let not = UserDefaults.standard.array(forKey: "horasNotificacao"){
            if let not2 = UserDefaults.standard.array(forKey: "diasNotificacao"){
                if not.isEmpty && not2.isEmpty{
                    LocalNotificationHandler.shared.deletarNotificacoes()
                }
            }
        }
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
    
    
    /// Função que envia quando o sistema necessita iniciar a aplicação em segundo plano para processar tarefas.
    /// - Parameter backgroundTasks: Conjunto de tarefas.
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
    
    /// Função que pergunta ao delegate como lidar com uma notificação que chegou enquanto o aplicativo estava sendo executado em primeiro plano.
    /// - Parameters:
    ///   - center: O objeto do centro de notificação do usuário compartilhado que recebeu a notificação.
    ///   - notification: Utilizado para usar as informações para atualizar a interface do aplicativo.
    ///   - completionHandler: O bloco a ser executado com a opção de apresentação da notificação.
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([UNNotificationPresentationOptions.sound])
    }
    
    
    /// Solicita ao delegado que processe a resposta do usuário a uma notificação entregue.
    /// - Parameters:
    ///   - center: O objeto do centro de notificação do usuário compartilhado que recebeu a notificação.
    ///   - response: A resposta do usuário à notificação.
    ///   - completionHandler: O bloco a ser executado quando você terminar de processar a resposta do usuário.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        LocalNotificationHandler.shared.handleNotificationResponse(response: response)
        completionHandler()
        
        
    }
}
