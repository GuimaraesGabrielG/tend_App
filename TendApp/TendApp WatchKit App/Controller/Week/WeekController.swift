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
    
    //MARK: - Attributes
    
    /// Periods
    var days = [false,false,false,false,false,false,false]
    var periods = [false,false,false,false]
    
    /// Groups
    @IBOutlet weak var groupDays: WKInterfaceGroup!
    @IBOutlet weak var groupFirstPeriod: WKInterfaceGroup!
    @IBOutlet weak var groupSecondPeriod: WKInterfaceGroup!
    
    /// Week Buttons
    @IBOutlet weak var sundayButton: WKInterfaceButton!
    @IBOutlet weak var mondayButton: WKInterfaceButton!
    @IBOutlet weak var tuesdayButton: WKInterfaceButton!
    @IBOutlet weak var wednesdayButton: WKInterfaceButton!
    @IBOutlet weak var thursdayButton: WKInterfaceButton!
    @IBOutlet weak var fridayButton: WKInterfaceButton!
    @IBOutlet weak var saturdayButton: WKInterfaceButton!
    
    /// Period Buttons
    @IBOutlet weak var morningButton: WKInterfaceButton!
    @IBOutlet weak var afternoonButton: WKInterfaceButton!
    @IBOutlet weak var nightButton: WKInterfaceButton!
    @IBOutlet weak var dawnButton: WKInterfaceButton!
    
    
    /// Collections
    var collectionDays = [WKInterfaceButton]()
    var collectionPeriods = [WKInterfaceButton]()
    
    var toggled = false
    
    /// init
    override init() {
        super.init()
        
        self.collectionDays = [sundayButton,mondayButton,tuesdayButton,wednesdayButton,thursdayButton,fridayButton,saturdayButton]
        self.collectionPeriods = [morningButton,afternoonButton,nightButton,dawnButton]
        
        //Verify if First Time in App and save in UserDefaults.
        if(!UserDefaults.standard.bool(forKey: "firstTime")){
            UserDefaults.standard.set(true, forKey: "firstTime")
            PersistentData.persistentData.daysPersistentData.set(days, forKey: "daysPersistentData")
            PersistentData.persistentData.periodsPersistentData.set(periods, forKey: "periodPersistentData")
        }else{
            self.verificationDays()
            self.verificationPeriods()
        }
    }
    
    /// deinit()
    deinit {
        self.clear()
    }
    
    
    /// willDisappear()
    public override func willDisappear() {
        self.clear()
    }
    
    
    // Validation Days
    func verificationDays(){
        for i in 0...6{
            if(PersistentData.persistentData.retrieveDays()[i]==true){
                self.collectionDays[i].setAlpha(1)
            }else{
                self.collectionDays[i].setAlpha(0.3)
            }
        }
    }
    
    
    /// Verifcation Periods
    func verificationPeriods(){
        for i in 0...3{
            if(PersistentData.persistentData.retrievePeriod()[i]==true){
                self.collectionPeriods[i].setAlpha(1)
            }else{
                self.collectionPeriods[i].setAlpha(0.3)
            }
        }
    }
    
    
    /// Set Days
    /// - Parameter day: Day of Week
    func setDays(day:Int){
        if(PersistentData.persistentData.retrieveDays()[day]==false){
            collectionDays[day].setAlpha(1)
            days[day] = true
            PersistentData.persistentData.daysPersistentData.set(days, forKey: "daysPersistentData")
        }else{
            collectionDays[day].setAlpha(0.3)
            days[day] = false
            PersistentData.persistentData.daysPersistentData.set(days, forKey: "daysPersistentData")
        }
    }
    
    /// Set Periods
    /// - Parameter period: Period of Day
    func setPeriods(period: Int){
        if(PersistentData.persistentData.retrievePeriod()[period]==false){
            collectionPeriods[period].setAlpha(1)
            periods[period] = true
            PersistentData.persistentData.periodsPersistentData.set(periods, forKey: "periodPersistentData")
        }else{
            collectionPeriods[period].setAlpha(0.3)
            periods[period] = false
            PersistentData.persistentData.periodsPersistentData.set(periods, forKey: "periodPersistentData")
        }
    }
    
    
    //MARK: - Days Button
    @IBAction func activateSunday() {
        setDays(day: 0)
    }
    
    @IBAction func activateMonday() {
        setDays(day: 1)
    }
    @IBAction func activateTuesday() {
        setDays(day: 2)
    }
    @IBAction func activateWednesday() {
        setDays(day: 3)
    }
    @IBAction func activateThursday() {
        setDays(day: 4)
    }
    @IBAction func activateFriday() {
        setDays(day: 5)
    }
    @IBAction func activateSaturday() {
        setDays(day: 6)
    }
    
    //MARK: - Periods Button
    @IBAction func activateMorning() {
        setPeriods(period: 0)
    }
    @IBAction func activateAfternoon() {
        setPeriods(period: 1)
    }
    @IBAction func activateNight() {
        setPeriods(period: 2)
    }
    @IBAction func activateDawn() {
        setPeriods(period: 3)
    }
    
    
    
    /// Clear Memory
    func clear(){
        self.collectionDays = [sundayButton,mondayButton,tuesdayButton,wednesdayButton,thursdayButton,fridayButton,saturdayButton]
        self.collectionPeriods = [morningButton,afternoonButton,nightButton,dawnButton]
        
        self.groupDays = nil
        self.groupFirstPeriod = nil
        self.groupSecondPeriod = nil
        
        self.morningButton = nil
        self.afternoonButton = nil
        self.nightButton = nil
        self.dawnButton = nil
        
        self.mondayButton.setBackgroundColor(nil)
        self.afternoonButton.setBackgroundColor(nil)
        self.nightButton.setBackgroundColor(nil)
        self.dawnButton.setBackgroundColor(nil)
        
        self.sundayButton = nil
        self.mondayButton = nil
        self.tuesdayButton = nil
        self.wednesdayButton = nil
        self.thursdayButton = nil
        self.fridayButton = nil
        self.saturdayButton = nil
        
        self.sundayButton.setBackgroundColor(nil)
        self.mondayButton.setBackgroundColor(nil)
        self.tuesdayButton.setBackgroundColor(nil)
        self.wednesdayButton.setBackgroundColor(nil)
        self.thursdayButton.setBackgroundColor(nil)
        self.fridayButton.setBackgroundColor(nil)
        self.saturdayButton.setBackgroundColor(nil)
        
        self.collectionPeriods = []
        self.collectionDays = []
    }
}


