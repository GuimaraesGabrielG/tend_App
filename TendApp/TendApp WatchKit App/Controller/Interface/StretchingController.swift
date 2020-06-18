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

    //MARK:-   Váriaveis
    //  Timer que faz a contagem antes de começar o alongamento
    public var timerBeforeStartStretching: Timer!
    //  Mostra o valor atual do timer.
    @IBOutlet weak var labelTimerBeforeStartStretching: WKInterfaceLabel!
    //  Utilizada para representar o timer, sempre a função do mesmo é chamada
    public var count = 3
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        WKInterfaceDevice.current().play(.start)
        labelTimerBeforeStartStretching.setText("\(count)")
        timerBeforeStartStretching = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: countTimerBeforeStretching(myTimer:))

        
        
        
    }
    
    override func willActivate() {
        
    }
    //  Essa função é chamada até que o timer que aparece antes da realização do exercício chegue a 0
    func countTimerBeforeStretching(myTimer: Timer) {
        if count > 0 {
            count-=1
            labelTimerBeforeStartStretching.setText("\(count)")
        } else {
            myTimer.invalidate()
            labelTimerBeforeStartStretching.setHidden(true)
        }
    }
    
    
}
