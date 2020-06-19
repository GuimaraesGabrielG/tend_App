//
//  StretchingController.swift
//  TendApp WatchKit Extension
//
//  Created by Jose Deyvid on 17/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import UIKit
import WatchKit
class StretchingController: WKInterfaceController {

    /// label que aparecera ao final de cada parte do alongamento
    @IBOutlet weak var finalLabel: WKInterfaceLabel!
    /// label com a instruçao do alongamento
    @IBOutlet weak var instructionLabel: WKInterfaceLabel!
    /// imagem do anel animado
    @IBOutlet weak var ringImage: WKInterfaceImage!
    /// imagem do alongamento
    @IBOutlet weak var stretchingImage: WKInterfaceImage!
    //MARK:-   Váriaveis
    //  Timer que faz a contagem antes de começar o alongamento
    public var timerBeforeStartStretching: Timer!
    //  Mostra o valor atual do timer.
    @IBOutlet weak var labelTimerBeforeStartStretching: WKInterfaceLabel!
    //  Utilizada para representar o timer, sempre a função do mesmo é chamada
    public var count = 3
    /// Classe que controla qual alongamento será executado
    let stretchingEnforcer = StretchingEnforcer()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        labelTimerBeforeStartStretching.setText("\(count)")
        timerBeforeStartStretching = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: countTimerBeforeStretching(myTimer:))

        
        self.stretchingEnforcer.runStretching(stretchingStrategy: StretchingHand(), finalLabel: self.finalLabel, instructionLabel: self.instructionLabel, ringImage: self.ringImage)
        
        
    }
    
    override func willActivate() {
        
    }
    //  Essa função é chamada até que o timer que aparece antes da realização do exercício chegue a 0
    func countTimerBeforeStretching(myTimer: Timer) {
        if count > 0 {
            count-=1
            labelTimerBeforeStartStretching.setText("\(count)")
        } else {
            WKInterfaceDevice.current().play(.start)
            myTimer.invalidate()
            labelTimerBeforeStartStretching.setHidden(true)
        }
    }
    
    
}
