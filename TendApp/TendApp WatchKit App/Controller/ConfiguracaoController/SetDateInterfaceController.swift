//
//  SetDateInterfaceController.swift
//  TendApp WatchKit Extension
//
//  Created by Gabriel Gonçalves Guimarães on 19/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import WatchKit
import Foundation


class SetDateInterfaceController: WKInterfaceController {
    @IBOutlet var tableDiaSemana: WKInterfaceTable!
       
       /// Array com todos os dias da semana
       var arrayInfo = {
           return [
               
               ["title": "Toda segunda-feira" , "ID": "nQuick"],
               ["title": "Toda terça-feira" , "ID": "nQuick"],
               ["title": "Toda quarta-feira" , "ID": "nQuick"],
               ["title": "Toda quinta-feira" , "ID": "nQuick"],
               ["title": "Toda sexta-feira" , "ID": "nQuick"],
               ["title": "Todo sabado" , "ID": "nQuick"],
               ["title": "Todo domingo" , "ID": "nQuick"],

             ]
       }()
       
       /// Configuração para que as celulas da table view tenha as informações corretas
       override func willActivate() {
           //Numero de linhas
           tableDiaSemana.setNumberOfRows(arrayInfo.count, withRowType: "ItensSemana")

           //Preenchimento com as informações
           for (i,j) in arrayInfo.enumerated(){
               let cell = tableDiaSemana.rowController(at: i) as! TitleSemana
               cell.titleSemana.setText(j["title"])
           }
       }
    
       override func awake(withContext context: Any?) {
           super.awake(withContext: context)
           
       }
       
    /// Montra em qual celula está quando o usuário clica
    /// O usuário vai poder selecionar os dias da semana
       override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {

           if(arrayInfo[rowIndex]["ID"] == "nQuick"){
               let cell = tableDiaSemana.rowController(at: rowIndex) as! TitleSemana
               cell.iconCheck.setHidden(false)
               arrayInfo[rowIndex]["ID"] = "Quick"
               print(arrayInfo[rowIndex])
              
           }else{
               let cell = tableDiaSemana.rowController(at: rowIndex) as! TitleSemana
               cell.iconCheck.setHidden(true)
               arrayInfo[rowIndex]["ID"] = "nQuick"
               print(arrayInfo[rowIndex])
           }

       }
       
}
