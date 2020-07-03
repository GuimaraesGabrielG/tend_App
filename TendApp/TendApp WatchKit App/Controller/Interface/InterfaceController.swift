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
    
    
    /// init
    override init() {
        super.init()
        self.setTitle(NSLocalizedString("TEND", comment: ""))
        self.message.setText(NSLocalizedString("Mensagem", comment: ""))
        self.startButton.setTitle(NSLocalizedString("Comecar", comment: ""))
        
    }
    
    /// Inicializa o controlador de interface com os dados de contexto especificados.
    /// - Parameter context: O objeto de contexto (se houver) fornecido pelo controlador de interface anterior. Este parâmetro pode ser nulo. Se não for nulo, você será responsável por salvar uma referência ao objeto fornecido e usá-lo para configurar seu controlador de interface.
    public override func awake(withContext context: Any?) {
        // Configure interface objects here.
        super.awake(withContext: context)
        
    }
    
    
    /// WillActivate.
    public override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }
    
    /// DidDeactivate.
    public override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}

