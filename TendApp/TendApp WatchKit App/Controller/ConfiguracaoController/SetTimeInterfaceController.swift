//
//  SetTimeInterfaceController.swift
//  TendApp WatchKit Extension
//
//  Created by Gabriel Gonçalves Guimarães on 19/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import WatchKit
import Foundation


class SetTimeInterfaceController: WKInterfaceController {
    @IBOutlet var horas: WKInterfacePicker!
       @IBOutlet var min: WKInterfacePicker!
    
    override init() {
        super.init()
        self.setTitle(NSLocalizedString("Horario", comment: ""))
    }
       
       /// Preenche o numeros das horas
       lazy var numhoras: [WKPickerItem] = {
           var numArray = [WKPickerItem]()
           
           for i in 0...24{
               let num = WKPickerItem()
               num.title = String(format: "%02d", i)
               num.caption = NSString.localizedUserNotificationString(forKey: "Horas", arguments: [])
               numArray.append(num)
           
           }
           
           return numArray
       }()
    
       /// Preenche o numeros do min
       lazy var numMin: [WKPickerItem] = {
           var numArray = [WKPickerItem]()
           
           for i in 0...24{
               let num = WKPickerItem()
               num.title = String(format: "%02d", i)
               num.caption = NSString.localizedUserNotificationString(forKey: "Horas", arguments: [])
               numArray.append(num)
           
           }
           
           return numArray
       }()

       /// Configuração das horas e minutos no pickerView
       override func awake(withContext context: Any?) {
           super.awake(withContext: context)
           horas.setItems(numhoras)
           min.setItems(numMin)
           
       }
       
       /// - Parameter value: Mostra em qual celula o usuário parou
       @IBAction func valueMin(_ value: Int) {
           print(numMin[value].title!)

       }
    
       /// - Parameter value: Mostra em qual celula o usuário parou
       @IBAction func valueHoras(_ value: Int) {
           print(numhoras[value].title!)
       }

}
