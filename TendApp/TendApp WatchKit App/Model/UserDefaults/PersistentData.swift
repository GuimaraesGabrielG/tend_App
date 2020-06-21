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
    private var _days: [Bool] = []
    private var _week = UserDefaults.standard
    
    //MARK: - Getters and Setters
    var week: UserDefaults{
        get{
            return self._week
        }
        set(newValue){
            self._week = newValue
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
}
