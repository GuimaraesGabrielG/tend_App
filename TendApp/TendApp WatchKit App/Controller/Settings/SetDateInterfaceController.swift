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
    var selectedRows: [Int] = []
    
    /// Array com todos os dias da semana
    var arrayInfo = {
        return [
            ["title": NSLocalizedString("Segunda-Feira", comment: "") , "ID": "nQuick"],
            ["title": NSLocalizedString("Terca-Feira", comment: "") , "ID": "nQuick"],
            ["title": NSLocalizedString("Quarta-Feira", comment: "") , "ID": "nQuick"],
            ["title": NSLocalizedString("Quinta-Feira", comment: "") , "ID": "nQuick"],
            ["title": NSLocalizedString("Sexta-Feira", comment: "") , "ID": "nQuick"],
            ["title": NSLocalizedString("Sabado", comment: "") , "ID": "nQuick"],
            ["title": NSLocalizedString("Domingo", comment: "") , "ID": "nQuick"],
        ]
    }()
    
    
    override init() {
        super.init()
        self.setTitle(NSLocalizedString("Dia", comment: ""))
        print(returnSelected())
    }
    
    
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
            self.selectedRows.append(rowIndex)
            UserDefaults.standard.set(selectedRows, forKey: "selectedRows")
        }else{
            let cell = tableDiaSemana.rowController(at: rowIndex) as! TitleSemana
            cell.iconCheck.setHidden(true)
            arrayInfo[rowIndex]["ID"] = "nQuick"
            print("Apareceu e Clicou aqui:",arrayInfo[rowIndex])
        }
    }
    
    func returnSelected(){
        if let fetchArray = UserDefaults.standard.array(forKey: "selectedRows") as? [Int] {
            print("Array: ",fetchArray)
        }
    }
}
