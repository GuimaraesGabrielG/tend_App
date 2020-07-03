//
//  StretchingEnforcer.swift
//  TendApp WatchKit Extension
//
//  Created by Lucas Siqueira on 22/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import Foundation
import WatchKit

/// Classe que controla qual alongamento será executado.
public class StretchingEnforcer {
    /// Variável de alongamento atual.
    var currentStretchingStrategy: StretchingStrategy?
    /// Variável que controla se o alongamento deve continuar (ao se tornar true todas as animaçoes param).
    var stop: Bool = false{
        didSet{
            if stop{
                if var strategyAnimation = currentStretchingStrategy as? Animation {
                    strategyAnimation.stop = stop
                    currentStretchingStrategy = nil
                }
            }
        }
    }
    /// Função que que executa a estratégia de alongamento.
    /// - Parameters:
    ///   - stretchingStrategy: Objeto com a estratégia de alongamento.
    ///   - stretchingController: Interface controller de alongamento.
    func runStretching(stretchingStrategy: StretchingStrategy, stretchingController: StretchingController) {
        currentStretchingStrategy = stretchingStrategy
        currentStretchingStrategy?.performStretching(stretchingController: stretchingController)
    }
}
