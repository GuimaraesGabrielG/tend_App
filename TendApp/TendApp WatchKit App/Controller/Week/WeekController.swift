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
    var arrayDaysNotification:[Int] = []
    var arrayTimeNotification:[Int] = []
    
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
    
    
    /// Labels
    @IBOutlet weak var daysWeekLabel: WKInterfaceLabel!
    @IBOutlet weak var periodsLabel: WKInterfaceLabel!
    
    //MARK: - Init
    /// init
    override init() {
        super.init()
        self.setTitle(NSLocalizedString("Cronograma", comment: ""))
        self.daysWeekLabel.setText(NSLocalizedString("DiaDaSemana", comment: ""))
        self.periodsLabel.setText(NSLocalizedString("Periodos", comment: ""))
        self.activateArrays()
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
    
    
     /// Called when Controller is active.
     public override func willActivate() {
         self.activateArrays()
        print("entrou da tela")

        // manda a notificação
            if let _ = UserDefaults.standard.array(forKey: "horasNotificacao"){
                if let _ = UserDefaults.standard.array(forKey: "diasNotificacao"){
                    LocalNotificationHandler.shared.sendNotification()
                }
            }
        
     }
     
    deinit {
        print("saiu")
    }
     /// Called when Controller is offscreen.
     public override func willDisappear() {
        self.clear()
        print("Saiu da tela")
        // manda a notificação
            if let _ = UserDefaults.standard.array(forKey: "horasNotificacao"){
                if let _ = UserDefaults.standard.array(forKey: "diasNotificacao"){
                    LocalNotificationHandler.shared.sendNotification()
                }
            }
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
        activateArrays()
        if(PersistentData.persistentData.retrieveDays()[day]==false){
            collectionDays[day].setAlpha(1)
            days[day] = true
            self.arrayDaysNotification.append(day+1)
            PersistentData.persistentData.daysPersistentData.set(days, forKey: "daysPersistentData")
            UserDefaults.standard.set(self.arrayDaysNotification, forKey: "diasNotificacao")

        }else{
            for (i,j) in self.arrayDaysNotification.enumerated(){
                if(j == day+1){
                    self.arrayDaysNotification.remove(at: i)
                    break
                }
            }
            collectionDays[day].setAlpha(0.3)
            days[day] = false
            UserDefaults.standard.set(self.arrayDaysNotification, forKey: "diasNotificacao")
            PersistentData.persistentData.daysPersistentData.set(days, forKey: "daysPersistentData")
        }
    }
    
    /// Set Periods
    /// - Parameter period: Period of Day
    func setPeriods(period: Int){
        activateArrays()
        if(PersistentData.persistentData.retrievePeriod()[period]==false){
            collectionPeriods[period].setAlpha(1)
            periods[period] = true
            PersistentData.persistentData.periodsPersistentData.set(periods, forKey: "periodPersistentData")
            self.arrayTimeNotification.append(period+1)

            UserDefaults.standard.set(self.arrayTimeNotification, forKey: "horasNotificacao")

        }else{
            for (i,j) in self.arrayTimeNotification.enumerated(){
                if(j == period+1){
                    self.arrayTimeNotification.remove(at: i)
                    break
                }
            }
            UserDefaults.standard.set(self.arrayTimeNotification, forKey: "horasNotificacao")

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
        self.periods = []
        self.days = []
        self.collectionPeriods = []
        self.collectionDays = []
    }
    
    func activateArrays(){
        if(!PersistentData.persistentData.retrieveDays().isEmpty){
            self.days = PersistentData.persistentData.retrieveDays()
        }
        if(!PersistentData.persistentData.retrievePeriod().isEmpty){
            self.periods = PersistentData.persistentData.retrievePeriod()
        }
        
        if let arrayNoticacao = UserDefaults.standard.array(forKey: "diasNotificacao"){
            self.arrayDaysNotification = arrayNoticacao as! [Int]
        }
        
        if let arrayNoticacao = UserDefaults.standard.array(forKey: "horasNotificacao"){
            self.arrayTimeNotification = arrayNoticacao as! [Int]
        }
      
        self.collectionDays = [sundayButton,mondayButton,tuesdayButton,wednesdayButton,thursdayButton,fridayButton,saturdayButton]
        self.collectionPeriods = [morningButton,afternoonButton,nightButton,dawnButton]
    }
}
