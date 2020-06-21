//
//  StretchingHand.swift
//  TendApp WatchKit Extension
//
//  Created by Lucas Siqueira on 19/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import Foundation
import WatchKit

/// Classe que define a estratégia de alongamento da mão
public class StretchingHand: StretchingStrategy{
    
    func performStretching(stretchingController: StretchingController) {
        stretchingController.finalLabel.setText(NSLocalizedString("Outra", comment: ""))
        stretchingController.instructionLabel.setText(NSLocalizedString("Instrucao", comment: ""))
        stretchingController.stretchingImage.setHidden(false)
        stretchingController.stretchingImage.setImageNamed("alongamento_1")
        stretchingController.ringImage.setHidden(false)
        stretchingController.instructionLabel.setHidden(false)
        self.animateWithDuration(duration: 16, animations: {
            self.createAnimatedImages(image: stretchingController.ringImage, total: 200, imagePrefix: "single", count: 0, duration: 14.5)
        }, completion: {
            stretchingController.stretchingImage.setHidden(true)
            stretchingController.ringImage.setHidden(true)
            stretchingController.instructionLabel.setHidden(true)
            stretchingController.finalLabel.setHidden(false)
            self.animateWithDuration(duration: 3, animations: {
            }, completion: {
                stretchingController.stretchingImage.setHidden(false)
                stretchingController.ringImage.setHidden(false)
                stretchingController.instructionLabel.setHidden(false)
                stretchingController.finalLabel.setHidden(true)
                self.animateWithDuration(duration: 16, animations: {
                    stretchingController.stretchingImage.setImageNamed("alongamento_12")
                    self.createAnimatedImages(image: stretchingController.ringImage, total: 200, imagePrefix: "single", count: 0, duration: 14.5)
                }, completion: {
                    let finalAlertAction = WKAlertAction(title: "OK", style: .default) {
                        stretchingController.popToRootController()
                    }
                    stretchingController.presentAlert(withTitle: NSLocalizedString("TituloFinal", comment: ""), message: NSLocalizedString("MensagemFinal", comment: ""), preferredStyle: .alert, actions: [finalAlertAction])
                })
            })
        })
    }
    
    
}
