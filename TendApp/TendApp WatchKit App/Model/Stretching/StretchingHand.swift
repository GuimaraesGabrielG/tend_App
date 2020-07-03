//
//  StretchingHand.swift
//  TendApp WatchKit Extension
//
//  Created by Lucas Siqueira on 19/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import Foundation
import WatchKit



///Classe que define a estratégia de alongamento da mão.
public class StretchingHand: StretchingStrategy, Animation{
    
    //MARK: -Attributes
    var stop: Bool = false
    
    
    /// Funcão que efetua o alongamento da mão.
    /// - Parameter stretchingController: Objeto do tipo Stretching Controller.
    func performStretching(stretchingController: StretchingController) {
        
        stretchingController.ringImage.setHidden(false)
        self.createAnimatedImages(image: stretchingController.ringImage, total: 26, imagePrefix: "single", count: 0, duration: 1, repeatCount: -1)
        stretchingController.finalLabel.setText(NSLocalizedString("Outra", comment: ""))
        stretchingController.instructionLabel.setText(NSLocalizedString("Instrucao", comment: ""))
        
        animateWithDuration(duration: 3, animations: {
            stretchingController.instructionLabel.setHidden(false)
        }, completion: {
            self.animateWithDuration(duration: 16, animations: {
                WKInterfaceDevice.current().play(.start)
                self.setImage(image: stretchingController.stretchingImage, nameImage: "alongamento_1")
                stretchingController.stretchingImage.setHidden(false)
                stretchingController.instructionLabel.setHidden(true)
            }, completion: {
                WKInterfaceDevice.current().play(.stop)
                stretchingController.finalLabel.setHidden(false)
                stretchingController.stretchingImage.setHidden(true)
                self.animateWithDuration(duration: 3, animations: {
                }, completion: {
                    WKInterfaceDevice.current().play(.start)
                    self.setImage(image: stretchingController.stretchingImage, nameImage: "alongamento_12")
                    stretchingController.stretchingImage.setHidden(false)
                    stretchingController.finalLabel.setHidden(true)
                    self.animateWithDuration(duration: 16, animations: {
                    }, completion: {
                        WKInterfaceDevice.current().play(.success)
                        self.showAllert(stretchingController: stretchingController)
                    })
                })
            })
        })
    }
}
