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
 Protocolo com o método do alongamento, onde cada classe fica responsável por definir a estratégia de alongamento.
 - note: Ao herdar esse protocolo voce obtém juntamente as funçoes de animaçao (configuradas na extensao).
*/

protocol StretchingStrategy{
    
    /// Método que executa a animação de alongamento.
    /// - Parameter stretchingController: Interface controller do alongamento.
    func performStretching (stretchingController: StretchingController)
}

/**
 Extensão com as funções de animação.
 - note: Essa extensao contém as funçoes necessarias para criar animaçoes com completion.
*/
extension StretchingStrategy {

    /// Método que que executa um delay antes da próxima função.
    /// - Parameters:
    ///   - duration: Valor da duração do delay.
    ///   - closure: Função a ser executada após o delay.
    func delay(duration: TimeInterval, closure: @escaping () -> Void){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: closure)
    }

    /// Método que que executa uma animaçao com um completion.
    /// - Parameters:
    ///   - duration: Valor da duração da animação.
    ///   - animations: Animação a ser executada.
    ///   - completion: Código a ser executado após a animação.
    func animateWithDuration(duration: TimeInterval, animations: @escaping () -> Void, completion: @escaping () -> Void){
            animations()
        delay(duration: duration) {
            completion()
        }
    }
}

/// Classe que controla qual alongamento será executado.
public class StretchingEnforcer {
    
    /// Método que que executa a estratégia de alongamento.
    /// - Parameters:
    ///   - stretchingStrategy: Objeto com a estratégia de alongamento.
    ///   - stretchingController: Interface controller de alongamento.
    func runStretching(stretchingStrategy: StretchingStrategy, stretchingController: StretchingController) {
        stretchingStrategy.performStretching(stretchingController: stretchingController)
    }
}
