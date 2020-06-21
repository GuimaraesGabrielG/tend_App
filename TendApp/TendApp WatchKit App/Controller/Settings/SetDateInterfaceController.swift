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
    var days = [true,true,true,true,true,false,false]
    
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
    }

    /// Configuração para que as celulas da table view tenha as informações corretas
    override func willActivate() {
    
        //Verificar se e a primeira vez que o usuario entrou no App
        if(!UserDefaults.standard.bool(forKey: "initial")){
            UserDefaults.standard.set(true, forKey: "initial")
            PersistentData.persistentData.week.set(days, forKey: "week")
        }else{
            days = UserDefaults.standard.array(forKey: "week") as? [Bool] ?? []
        }
        
        //Numero de linhas
        tableDiaSemana.setNumberOfRows(arrayInfo.count, withRowType: "ItensSemana")
        //Preenchimento com as informações
        for (i,j) in arrayInfo.enumerated(){
            let cell = tableDiaSemana.rowController(at: i) as! TitleSemana
            cell.titleSemana.setText(j["title"])
            if(days[i] == true){
                cell.iconCheck.setHidden(false)
            }
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    /// Montra em qual celula está quando o usuário clica
    /// O usuário vai poder selecionar os dias da semana
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let cell = tableDiaSemana.rowController(at: rowIndex) as! TitleSemana
        arrayInfo[rowIndex]["ID"] = "Quick"
        days[rowIndex] = !days[rowIndex]
        cell.iconCheck.setHidden(!days[rowIndex])
        PersistentData.persistentData.week.set(days, forKey: "week")
    }
}
