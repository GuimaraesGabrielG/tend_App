//
//  ConfiguracaoInterfaceController.swift
//  TendApp WatchKit Extension
//
//  Created by Gabriel Gonçalves Guimarães on 19/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import WatchKit
import Foundation


class ConfiguracaoInterfaceController: WKInterfaceController {
    
    
    @IBOutlet var configHoraDia: WKInterfaceTable!
    
    
    /// Nome da das colunas da table view e o nome das classes para onde o usuário vai
    /// quando clicar na celula
     let arrayInfo = {
           return [
               
               ["title": "Dia" , "ID": "setDia"],
               ["title": "Hora" , "ID": "setHora"],
              

             ]
       }()
    
    /// Configuração da tableview colocando o nome na celulas e a quantidade de celulas
    override func willActivate() {
                configHoraDia.setNumberOfRows(arrayInfo.count, withRowType: "ItensTitle")
        
        for (i,j) in arrayInfo.enumerated(){
            let cell = configHoraDia.rowController(at: i) as! TitleItens
            cell.titleName.setText(j["title"])
        }

    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
      
    }
    
    /// O Usuário vai para tela quando clicar na celula correspondente

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
                pushController(withName: arrayInfo[rowIndex]["ID"]!, context: arrayInfo[rowIndex])

    }

    
}
