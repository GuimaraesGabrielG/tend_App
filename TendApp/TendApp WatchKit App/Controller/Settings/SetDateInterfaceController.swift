//
//  SetDateInterfaceController.swift
//  TendApp WatchKit Extension
//
//  Created by Gabriel Gonçalves Guimarães on 19/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import WatchKit
import Foundation



public class SetDateInterfaceController: WKInterfaceController {
    @IBOutlet var tableDiaSemana: WKInterfaceTable!
    var days = [true,true,true,true,true,false,false]
    var notificationArraySemana:[String] = []
    
    /// Array com todos os dias da semana
    var arrayInfo = {
        return [
            ["title": NSLocalizedString("Segunda-Feira", comment: "") , "ID": "2"],
            ["title": NSLocalizedString("Terca-Feira", comment: "") , "ID": "3"],
            ["title": NSLocalizedString("Quarta-Feira", comment: "") , "ID": "4"],
            ["title": NSLocalizedString("Quinta-Feira", comment: "") , "ID": "5"],
            ["title": NSLocalizedString("Sexta-Feira", comment: "") , "ID": "6"],
            ["title": NSLocalizedString("Sabado", comment: "") , "ID": "7"],
            ["title": NSLocalizedString("Domingo", comment: "") , "ID": "1"],
        ]
    }()
    
    override init() {
        super.init()
        print("entrou???")
    //Verificar se e a primeira vez que o usuario entrou no App
            if(!UserDefaults.standard.bool(forKey: "initial")){
                UserDefaults.standard.set(true, forKey: "initial")
                PersistentData.persistentData.week.set(days, forKey: "week")
            }else{
    //            print(UserDefaults.standard.array(forKey: "week") as? [Bool] ?? [])
                days = UserDefaults.standard.array(forKey: "week") as? [Bool] ?? []
            }
//
            //Numero de linhas
            tableDiaSemana.setNumberOfRows(arrayInfo.count, withRowType: "ItensSemana")
            //Preenchimento com as informações
            for (i,j) in arrayInfo.enumerated(){
                let cell = tableDiaSemana.rowController(at: i) as! TitleSemana
                cell.titleSemana.setText(j["title"])
                if(days[i]){
                    cell.iconCheck.setHidden(false)
    //                print(arrayInfo[i]["ID"])
                    if let gravartificacao = (arrayInfo[i]["ID"]){
                        print(gravartificacao)
                        notificationArraySemana.append(gravartificacao)
//                        print(notificationArraySemana)
//                        notificationArraySemana.append(gravartificacao)
                    }

                }
            }
            
            UserDefaults.standard.set(notificationArraySemana, forKey: "diasNotificacao")
        print(UserDefaults.standard.array(forKey: "diasNotificacao")!)
    }

    /// Configuração para que as celulas da table view tenha as informações corretas
    public override func willActivate() {
        
    }
    
    public override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    /// Montra em qual celula está quando o usuário clica
    /// O usuário vai poder selecionar os dias da semana
    public override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let cell = tableDiaSemana.rowController(at: rowIndex) as! TitleSemana
        var existe = false
        let desabilitarNotificacao = arrayInfo[rowIndex]["ID"]!
            for (i,j) in notificationArraySemana.enumerated(){
            if(desabilitarNotificacao == j){
                notificationArraySemana.remove(at: i)
                existe = true
            }
        }
        
        if(!existe){
            notificationArraySemana.append(desabilitarNotificacao)
        }

        UserDefaults.standard.set(notificationArraySemana, forKey: "diasNotificacao")
//        notificationArraySemana.remove(at: <#T##Int#>)
        days[rowIndex] = !days[rowIndex]
        cell.iconCheck.setHidden(!days[rowIndex])
        PersistentData.persistentData.week.set(days, forKey: "week")
    }
}
