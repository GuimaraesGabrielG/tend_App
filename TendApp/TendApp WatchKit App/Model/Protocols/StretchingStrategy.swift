//
//  StretchingStrategy.swift
//  TendApp WatchKit Extension
//
//  Created by Lucas Siqueira on 19/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import Foundation
import WatchKit

/**
 Protocolo com o método do alongamento, onde cada classe fica responsável por definir a estratégia de alongamento
 - note: Ao herdar essa classe recomendo herdar juntamente a classe 'Animation' para usar as funçoes de animaçao
*/
protocol StretchingStrategy{
    /**
     Método que executa a animaçao de alongamento
     - parameter finalLabel: label a ser mostrada após o exercício
     - parameter instructionLabel: label com a instruçao do alongamento
     - parameter ringImage: imagem do circulo
    */
    func performStretching (finalLabel: WKInterfaceLabel, instructionLabel: WKInterfaceLabel, ringImage: WKInterfaceImage)
}

/**
 Classe com as funções de animação
 - note: Essa classe contém as funçoes necessarias para criar animaçoes com completion
*/
class Animation: WKInterfaceController {
    
    /**
     Método que que executa um delay antes da próxima funçao
     - parameter duration: duraçao do delay
     - parameter closure: funçao a ser executada após o delay
    */
    func delay(duration: TimeInterval, closure: @escaping () -> Void){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: closure)
    }
    /**
     Método que que executa uma animaçao com um completion
     - parameter duration: duraçao da animaçao
     - parameter animation: animaçao a ser executada
     - parameter completion: código a ser executado após a animaçao
     
    */
    func animateWithDuration(duration: TimeInterval, animations: @escaping () -> Void, completion: @escaping () -> Void){
        animate(withDuration: duration) {
            animations()
        }
        delay(duration: duration) {
            completion()
        }
    }
}

/// Classe que controla qual alongamento será executado
class StretchingEnforcer {
    /**
     Método que que executa a estratégia de alongamento
     - parameter stretchingStrategy: classe com a estratégia de alongamento
     - parameter finalLabel: label a ser mostrada após o exercício
     - parameter instructionLabel: label com a instruçao do alongamento
     - parameter ringImage: imagem do circulo
    */
    func runStretching(stretchingStrategy: StretchingStrategy, finalLabel: WKInterfaceLabel, instructionLabel: WKInterfaceLabel, ringImage: WKInterfaceImage) {
        stretchingStrategy.performStretching(finalLabel: finalLabel, instructionLabel: instructionLabel, ringImage: ringImage)
    }
    
}

