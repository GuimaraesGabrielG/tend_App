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
    private var _period: [Bool] = []
    private var _periodPersistentData = UserDefaults.standard
    
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
    
    var period: [Bool]{
        get{
            return self._period
        }
        set(newValue){
            self._period = newValue
        }
    }
    
    var periodPersistentData: UserDefaults{
        get{
            return self._periodPersistentData
        }
        set(newValue){
            self._periodPersistentData = newValue
        }
    }
    
    
    
    func retrieveDays() -> [Bool] {
        return daysPersistentData.array(forKey: "daysPersistentData") as? [Bool] ?? []
    }
    
    func daysSetTrue(){
        self.daysPersistentData.set(true, forKey: "daysPersistentData")
    }
    
    func daysSetFalse(){
        self.daysPersistentData.set(false, forKey: "daysPersistentData")
    }
    
    
    func retrievePeriod() -> [Bool] {
        return daysPersistentData.array(forKey: "periodPersistentData") as? [Bool] ?? []
    }
    
    func periodSetTrue(){
        self.daysPersistentData.set(true, forKey: "periodPersistentData")
    }
    
    func periodSetFalse(){
        self.daysPersistentData.set(false, forKey: "periodPersistentData")
    }
    
    
}
