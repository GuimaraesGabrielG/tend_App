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
    
    func performStretching(finalLabel: WKInterfaceLabel, instructionLabel: WKInterfaceLabel, ringImage: WKInterfaceImage, stretchingImage: WKInterfaceImage) {
        ringImage.setHidden(false)
        instructionLabel.setHidden(false)
        ringImage.setImageNamed("single")
        self.animateWithDuration(duration: 15, animations: {
            ringImage.startAnimatingWithImages(in: NSRange(location: 0, length: 200), duration: 14, repeatCount: 1)
        }, completion: {
            ringImage.setHidden(true)
            instructionLabel.setHidden(true)
            finalLabel.setHidden(false)
            self.animateWithDuration(duration: 3, animations: {
            }, completion: {
                ringImage.setHidden(false)
                instructionLabel.setHidden(false)
                finalLabel.setHidden(true)
                self.animateWithDuration(duration: 15, animations: {
                    ringImage.startAnimatingWithImages(in: NSRange(location: 0, length: 200), duration: 14, repeatCount: 1)
                }, completion: {
                    ringImage.setHidden(true)
                    instructionLabel.setHidden(true)
                    finalLabel.setText("Exercício finalizado!😃 \n\n Nós avisaremos quando um novo exercício estiver disponível")
                    finalLabel.setHidden(false)
                })
            })
        })
    }
    
    
}
