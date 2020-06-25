//
//  WeekController.swift
//  TendApp WatchKit Extension
//
//  Created by Mateus Augusto M Ferreira on 24/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import Foundation
import WatchKit


/// WeekController Class
public class WeekController: WKInterfaceController{
    
    /// Attributes
    var days = [false,false,false,false,false,false,false]
    var period = [false,false,false,false]
    
    //Groups
    @IBOutlet weak var groupDays: WKInterfaceGroup!
    @IBOutlet weak var groupFirstPeriod: WKInterfaceGroup!
    @IBOutlet weak var groupSecondPeriod: WKInterfaceGroup!
    
    // Week Buttons
    @IBOutlet weak var sundayButton: WKInterfaceButton!
    @IBOutlet weak var mondayButton: WKInterfaceButton!
    @IBOutlet weak var tuesdayButton: WKInterfaceButton!
    @IBOutlet weak var wednesdayButton: WKInterfaceButton!
    @IBOutlet weak var thursdayButton: WKInterfaceButton!
    @IBOutlet weak var fridayButton: WKInterfaceButton!
    @IBOutlet weak var saturdayButton: WKInterfaceButton!
    
    //Period Buttons
    @IBOutlet weak var morningButton: WKInterfaceButton!
    @IBOutlet weak var afternoonButton: WKInterfaceButton!
    @IBOutlet weak var nightButton: WKInterfaceButton!
    @IBOutlet weak var dawnButton: WKInterfaceButton!
    
    var collectionDays = [WKInterfaceButton]()
    var collectionPeriods = [WKInterfaceButton]()
    
    /// init
    override init() {
        super.init()
        self.groupDays.setWidth(self.contentFrame.width)
        
        self.collectionDays = [sundayButton,mondayButton,tuesdayButton,wednesdayButton,thursdayButton,fridayButton,saturdayButton]
        self.collectionPeriods = [morningButton,afternoonButton,nightButton,dawnButton]
        

        //Verify if First Time in App and save in UserDefaults.
        if(!UserDefaults.standard.bool(forKey: "firstTime")){
            UserDefaults.standard.set(true, forKey: "firstTime")
            PersistentData.persistentData.daysPersistentData.set(days, forKey: "daysPersistentData")
            PersistentData.persistentData.periodPersistentData.set(period, forKey: "periodPersistentData")
        }else{
            days = PersistentData.persistentData.retrieveDays()
            period = PersistentData.persistentData.retrievePeriod()
            
            for i in 0...6{
                if(days[i]==true){
                    self.collectionDays[i].setAlpha(1)
                }
            }
        }
    }
    
    /// deinit
    deinit {
        self.collectionDays = [sundayButton,mondayButton,tuesdayButton,wednesdayButton,thursdayButton,fridayButton,saturdayButton]
        self.collectionPeriods = [morningButton,afternoonButton,nightButton,dawnButton]
    }
}


