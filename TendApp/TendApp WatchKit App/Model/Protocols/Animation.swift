//
//  Animation.swift
//  TendApp WatchKit Extension
//
//  Created by Lucas Siqueira on 22/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import Foundation
import WatchKit

protocol Animation {
    /// variavel que controla se a animaçao deve continuar (ao se tornar true todas as animaçoes param)
    var stop: Bool {get set}
}

/**
 Extensão com as funções de animação.
 - note: Essa extensao contém as funçoes necessarias para criar animaçoes com completion.
*/
extension Animation{
    
    /// Método que que executa um delay antes da próxima função.
    /// - Parameters:
    ///   - duration: Valor da duração do delay.
    ///   - closure: Função a ser executada após o delay.
    private func delay(duration: TimeInterval, closure: @escaping () -> Void){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: closure)
    }

    /// Método que que executa uma animaçao com um completion.
    /// - Parameters:
    ///   - duration: Valor da duração da animação.
    ///   - animations: Animação a ser executada.
    ///   - completion: Código a ser executado após a animação.
    func animateWithDuration(duration: TimeInterval, animations: @escaping () -> Void, completion: @escaping () -> Void){
        if !stop{
           animations()
        }
        if !stop{
            delay(duration: duration) {
                if !self.stop{
                   completion()
                }
            }
        }
    }
    
    /**
     Método que cria uma animaçao de imagens em sequencia sem aumentar o consumo de memória
     - parameter image: imagem a ser animada
     - parameter total: total de imagens
     - parameter imagePrefix: nome da imagem sem os numeros
     - parameter count: numero da primeira imagem
     - parameter duration: suraçao da animaçao
    */
    func createAnimatedImages(image: WKInterfaceImage, total: Int, imagePrefix: String, count: Int, duration: TimeInterval, repeatCount: Int){
        animateWithDuration(duration: duration/Double(total), animations: {
            let imageName = count<10 ? "\(imagePrefix)000\(count)" : "\(imagePrefix)00\(count)"
            self.setImage(image: image, nameImage: imageName)
        }, completion: {
            if count < total{
                self.createAnimatedImages(image: image, total: total, imagePrefix: imagePrefix, count: count+1, duration: duration, repeatCount: repeatCount)
            }else if repeatCount != 0{
                self.createAnimatedImages(image: image, total: total, imagePrefix: imagePrefix, count: 1, duration: duration, repeatCount: repeatCount-1)
            }
        })

    }
    
    func setImage(image: WKInterfaceImage, nameImage: String){
        image.setImage(nil)
        if let imagePath = Bundle.main.path(forResource: nameImage,
            ofType: "png"){
            image.setImage(UIImage(contentsOfFile: imagePath))
        }
    }
    
}
