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

public class PersistentData {
    //MARK: - Attributes
    static let persistentData = PersistentData()
    private var _days = UserDefaults.standard
    

    
    //MARK: - Getters and Setters
    var days: UserDefaults{
        get{
            return self._days
        }
        set(newValue){
            self._days = newValue
        }
    }
    
    func retrieveDays() -> Bool{
        return days.bool(forKey: "daysWeek")
    }
    
    func setDaysOn(){
        self.days.set(true, forKey: "daysWeek")
    }
    
    func setDaysOff(){
        self.days.set(false, forKey: "daysWeek")
    }
}
