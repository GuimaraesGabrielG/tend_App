//
//  StretchingStrategy.swift
//  TendApp WatchKit Extension
//
//  Created by Lucas Siqueira on 19/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import Foundation
import WatchKit


/// Protocolo com o método do alongamento, onde cada classe fica responsável por definir a estratégia de alongamento.
protocol StretchingStrategy{
    
    /// Função que executa a açao de alongamento.
    /// - Parameter stretchingController: Interface controller do alongamento.
    func performStretching (stretchingController: StretchingController)
}

/// Extensão que adiciona algumas funçoes de à estrategia de alongamento
extension StretchingStrategy{

    /// Função que mostra um alerta ao final do exercicio.
    /// - Parameter stretchingController: Objeto da tela de alongamento.
    func showAllert(stretchingController: StretchingController){
        let finalAlertAction = WKAlertAction(title: "OK", style: .default) {
            LocalNotificationHandler.shared.ativarNotificacao()
            stretchingController.popToRootController()
        }
        stretchingController.presentAlert(withTitle: NSLocalizedString("TituloFinal", comment: ""), message: NSLocalizedString("MensagemFinal", comment: ""), preferredStyle: .alert, actions: [finalAlertAction])
    }
}
