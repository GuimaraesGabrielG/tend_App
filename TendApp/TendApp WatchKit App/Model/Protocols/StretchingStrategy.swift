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
 - note: Ao herdar esse protocolo voce obtém juntamente as funçoes de animaçao (configuradas na extensao)
*/
protocol StretchingStrategy{
    /**
     Método que executa a animaçao de alongamento
     - parameter stretchingController: Interface controller do alongamento
    */
    func performStretching (stretchingController: StretchingController)
}

/**
 Extensao com as funções de animação
 - note: Essa extensao contém as funçoes necessarias para criar animaçoes com completion
*/
extension StretchingStrategy {
    
    /**
     Método que executa um delay antes da próxima funçao
     - parameter duration: duraçao do delay
     - parameter closure: funçao a ser executada após o delay
    */
    func delay(duration: TimeInterval, closure: @escaping () -> Void){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: closure)
    }
    /**
     Método que executa uma animaçao com um completion
     - parameter duration: duraçao da animaçao
     - parameter animation: animaçao a ser executada
     - parameter completion: código a ser executado após a animaçao
     
    */
    func animateWithDuration(duration: TimeInterval, animations: @escaping () -> Void, completion: @escaping () -> Void){
            animations()
        delay(duration: duration) {
            completion()
        }
    }
    
    /**
     Método que cria uma array de imagens fora do cache
     - parameter total: total de imagens do array
     - parameter imagePrefix: nome da imagem sem os numeros
     - returns: array de imagens
     
    */
    func createImageArray(total: Int, imagePrefix: String) -> [UIImage]{
        var imageArray: [UIImage] = []
        for imageCount in 0..<total {
            let imageName = "\(imagePrefix)\(imageCount)"
            if let imagePath = Bundle.main.path(forResource: imageName,
                ofType: "png"),
              let image = UIImage(contentsOfFile: imagePath) {
                  imageArray.append(image)
            }
        }
        return imageArray
    }
}

/// Classe que controla qual alongamento será executado
class StretchingEnforcer {
    /**
     Método que que executa a estratégia de alongamento
     - parameter stretchingStrategy: classe com a estratégia de alongamento
     - parameter stretchingController: Interface controller do alongamento
    */
    func runStretching(stretchingStrategy: StretchingStrategy, stretchingController: StretchingController) {
        stretchingStrategy.performStretching(stretchingController: stretchingController)
    }
    
}

