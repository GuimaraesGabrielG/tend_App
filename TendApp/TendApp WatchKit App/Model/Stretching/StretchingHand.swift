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
class StretchingHand: StretchingStrategy{
    
    func performStretching(stretchingController: StretchingController) {
        stretchingController.finalLabel.setText(NSLocalizedString("Outra", comment: ""))
        stretchingController.instructionLabel.setText(NSLocalizedString("Instrucao", comment: ""))
        stretchingController.ringImage.setHidden(false)
        stretchingController.instructionLabel.setHidden(false)
        stretchingController.ringImage.setImageNamed("single")
        self.animateWithDuration(duration: 15, animations: {
            stretchingController.ringImage.startAnimatingWithImages(in: NSRange(location: 0, length: 200), duration: 14, repeatCount: 1)
        }, completion: {
            stretchingController.ringImage.setHidden(true)
            stretchingController.instructionLabel.setHidden(true)
            stretchingController.finalLabel.setHidden(false)
            self.animateWithDuration(duration: 3, animations: {
            }, completion: {
                stretchingController.ringImage.setHidden(false)
                stretchingController.instructionLabel.setHidden(false)
                stretchingController.finalLabel.setHidden(true)
                self.animateWithDuration(duration: 15, animations: {
                    stretchingController.ringImage.startAnimatingWithImages(in: NSRange(location: 0, length: 200), duration: 14, repeatCount: 1)
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
