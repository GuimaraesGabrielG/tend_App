//
//  PersistentData.swift
//  TendApp WatchKit Extension
//
//  Created by Mateus Augusto M Ferreira on 19/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import Foundation
import UIKit
import ClockKit
import WatchKit


/// Classe de que utiliza UserDefaults como persistência de dados.
public class PersistentData {
    
    //MARK: - Attributes
    static let persistentData = PersistentData()
    private var _days: [Bool] = []
    private var _daysPersistentData = UserDefaults.standard
    private var _periods: [Bool] = []
    private var _periodsPersistentData = UserDefaults.standard
    
    //MARK: - Getters and Setters
    var daysPersistentData: UserDefaults{
        get{
            return self._daysPersistentData
        }
        set(newValue){
            self._daysPersistentData = newValue
        }
    }
    
    var days: [Bool]{
        get{
            return self._days
        }
        
        set(newValue){
            
            self._days = newValue
        }
    }
    
    var periods: [Bool]{
        get{
            return self._periods
        }
        set(newValue){
            self._periods = newValue
        }
    }
    
    var periodsPersistentData: UserDefaults{
        get{
            return self._periodsPersistentData
        }
        set(newValue){
            self._periodsPersistentData = newValue
        }
    }
    
    
    
    /// Busca no UserDefaults, os dias da semana e retorna true se estiverem ativados, e false se estiverem desativados.
    /// - Returns: Retorna o array de booleans que informa os dias da semana ativados e desativados.
    func retrieveDays() -> [Bool] {
        return daysPersistentData.array(forKey: "daysPersistentData") as? [Bool] ?? []
    }
    
    /// Busca no UserDefaults, os períodos e retorna true se estiverem ativados, e false se estiverem desativados.
    /// - Returns: Retorna o array de booleans que informa os períodos ativados e desativados.
    func retrievePeriod() -> [Bool] {
        return periodsPersistentData.array(forKey: "periodPersistentData") as? [Bool] ?? []
    }
}
