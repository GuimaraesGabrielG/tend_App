//
//  ComplicationController.swift
//  TendApp WatchKit Extension
//
//  Created by Mateus Augusto M Ferreira on 16/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import ClockKit


/// Classe ComplicationController.
class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    /// Função que determina se a sua complication pode fornecer entradas da linha do tempo para o futuro ou o passado.
    /// - Parameters:
    ///   - complication: Complication ligada ao pedido.
    ///   - handler: O manipulador para executar com as instruções de Viagem no tempo. Este bloco não tem valor de retorno e aceita o seguinte parâmetro:
    ///   direções
    ///   As instruções de viagem no tempo com suporte. Você pode combinar os valores do tipo CLKComplicationTimeTravelDirections ao especificar esse valor.
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    
    /// Função que recupera a data mais antiga para a qual sua complicação está preparada para fornecer dados.
    /// - Parameters:
    ///   - complication: Complication ligada ao pedido.
    ///   - handler: O manipulador para executar com a data de início. Este bloco não tem valor de retorno e aceita o seguinte parâmetro:
    /// direções
    /// date
    /// A data de início dos seus dados. Por períodos anteriores a essa data, o WatchKit escurece seus dados para indicar que a linha do tempo não continua. Se você especificar zero, o ClockKit não solicitará mais dados anteriores.
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    
    /// Função que recupera a última data dos dados que seu aplicativo pode fornecer.
    /// - Parameters:
    ///   - complication: Complication ligada ao pedido.
    ///   - handler: O manipulador para executar com a data final. Este bloco não tem valor de retorno e aceita o seguinte parâmetro:
    /// date
    /// A data final para seus dados. Se você especificar zero, o ClockKit não solicitará mais dados futuros.
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    
    /// Função que retorna o comportamento de privacidade para a complicação especificada.
    /// - Parameters:
    ///   - complication: Complication ligada ao pedido.
    ///   - handler: O manipulador para executar com a data final. Este bloco não tem valor de retorno e aceita o seguinte parâmetro:
    /// behavior
    /// O comportamento de privacidade a ser aplicado à complicação especificada. Você pode especificar diferentes comportamentos de privacidade para diferentes famílias de complicações.
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    /// Função que recupera a entrada da linha do tempo que você deseja exibir agora.
    /// - Parameters:
    ///   - complication: Complication ligada ao pedido.
    ///   - handler: O manipulador para executar com a data final. Este bloco não tem valor de retorno e aceita o seguinte parâmetro:
    /// updateInterval
    /// O objeto CLKComplicationTimelineEntry a ser exibido agora.
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        handler(nil)
    }
    
    /// Função que recupera entradas anteriores da linha do tempo para a complicação.
    /// - Parameters:
    ///   - complication: Complication ligada ao pedido.
    ///   - date: A data final para fornecer entradas passadas. As datas para as entradas da linha do tempo devem ocorrer antes dessa data e estar o mais próximo possível da data.
    ///   - limit: O número máximo de entradas a serem fornecidas.
    ///   - handler: O manipulador para executar com os dados futuros da linha do tempo. Este bloco não tem valor de retorno e aceita o seguinte parâmetro:
    ///   entries
    ///   Uma matriz de objetos CLKComplicationTimelineEntry que representam os dados passados. O número de entradas na matriz deve ser menor ou igual ao valor no parâmetro limit. Se você especificar zero, o ClockKit não tentará estender ainda mais a linha do tempo.
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    /// Função que recupera entradas futuras da linha do tempo para a complication.
    /// - Parameters:
    ///   - complication: Complication ligada ao pedido.
    ///   - date: A data de início para fornecer entradas futuras. As datas para as entradas da linha do tempo devem ocorrer após essa data e estar o mais próximo possível da data.
    ///   - limit: O número máximo de entradas a serem fornecidas.
    ///   - handler: O manipulador para executar com os dados futuros da linha do tempo. Este bloco não tem valor de retorno e aceita o seguinte parâmetro:
    ///   entries
    ///   Uma matriz de objetos CLKComplicationTimelineEntry que representam os dados futuros. O número de entradas na matriz deve ser menor ou igual ao valor no parâmetro limit. Se você especificar zero, o ClockKit não tentará estender ainda mais a linha do tempo.
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    /// Função que obtém um modelo localizável que mostra dados de exemplo para a complicação especificada.
    /// - Parameters:
    ///   - complication: A complication ligada ao pedido. Use as informações da família de complicações neste objeto para determinar qual conjunto de modelos é válido. Por exemplo, se a família de complicações for CLKComplicationFamily.utilitarianLarge, você instancia a classe CLKComplicationTemplateUtilitarianLargeFlat para o seu modelo.
    ///   - handler: O manipulador para executar com os dados futuros da linha do tempo. Este bloco não tem valor de retorno e aceita o seguinte parâmetro:
    ///   template
    /// O objeto de modelo que contém seus dados de espaço reservado. Os dados neste modelo são armazenados em cache e exibidos para sua complicação.
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
}
