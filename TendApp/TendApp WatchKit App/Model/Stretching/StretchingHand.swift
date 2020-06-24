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
    
    var stop: Bool = false
    
    func performStretching(stretchingController: StretchingController) {
        stretchingController.finalLabel.setText(NSLocalizedString("Outra", comment: ""))
        stretchingController.instructionLabel.setText(NSLocalizedString("Instrucao", comment: ""))
        self.exchangeObjects(ringHidden: true, imageName: "alongamento_1", stretchingController: stretchingController)
        self.animateWithDuration(duration: 16, animations: {
            self.createAnimatedImages(image: stretchingController.ringImage, total: 200, imagePrefix: "single", count: 0, duration: 14.5)
        }, completion: {
            self.exchangeObjects(ringHidden: false, imageName: "none", stretchingController: stretchingController)
            self.animateWithDuration(duration: 3, animations: {
            }, completion: {
                self.exchangeObjects(ringHidden: true, imageName: "alongamento_12", stretchingController: stretchingController)
                self.animateWithDuration(duration: 16, animations: {
                    stretchingController.ringImage.setImage(nil)
                    stretchingController.ringImage.setHidden(true)
                    self.createAnimatedImages(image: stretchingController.ringImage2, total: 200, imagePrefix: "single", count: 0, duration: 14.5)
                }, completion: {
                    self.showAllert(stretchingController: stretchingController)
                })
            })
        })
    }
}
