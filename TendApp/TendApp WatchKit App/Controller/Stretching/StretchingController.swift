//
//  StretchingController.swift
//  TendApp WatchKit Extension
//
//  Created by Jose Deyvid on 17/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import UIKit
import WatchKit
public class StretchingController: WKInterfaceController, WKExtendedRuntimeSessionDelegate {
    
    /// label que aparecera ao final de cada parte do alongamento
    @IBOutlet weak var finalLabel: WKInterfaceLabel!
    /// label com a instruçao do alongamento
    @IBOutlet weak var instructionLabel: WKInterfaceLabel!
    /// imagem do anel animado
    @IBOutlet weak var ringImage: WKInterfaceImage!
    /// imagem do alongamento
    @IBOutlet weak var stretchingImage: WKInterfaceImage!
    //MARK:-   Váriaveis
    //  Timer que faz a contagem antes de começar o alongamento
    public var timerBeforeStartStretching: Timer!
    //  Mostra o valor atual do timer.
    @IBOutlet weak var labelTimerBeforeStartStretching: WKInterfaceLabel!
    //  Utilizada para representar o timer, sempre a função do mesmo é chamada
    private var countTimerBeforeStretching = Int()
    //  Utilizada para identificar quando a animação de alongamento terminou.
    private var countAnimationDuration = Int()
    //  Mostra a animação que ensina o usuário a fazer o alongamento.
    @IBOutlet weak var animatedImage: WKInterfaceImage!
    
    public var timerShowAnimation: Timer!
    /// Classe que controla qual alongamento será executado
    var stretchingEnforcer: StretchingEnforcer?
    
    /// Objeto de sessao (serve para continuar executando o app mesmo quando a tela entrar em descanso)
    let session = WKExtendedRuntimeSession()
    
    public override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Assign the delegate.
        session.delegate = self
        //  Chama a função que mostra a animação de como fazer o alongamento
        startAnimationStretching()
        stretchingEnforcer = StretchingEnforcer()
        // começa a sessao extendida
        session.start()

    }
    
    public override func willDisappear() {
        stretchingEnforcer?.stop = true
        stretchingEnforcer = nil
        timerBeforeStartStretching?.invalidate()
        timerShowAnimation?.invalidate()
        finalLabel.setText(nil)
        instructionLabel.setText(nil)
        ringImage.setImage(nil)
        stretchingImage.setImage(nil)
        labelTimerBeforeStartStretching.setText(nil)
        animatedImage.setImage(nil)
        session.invalidate()
    }
    
    public override func willActivate() {
        
    }
    //  Chamada para mostrar um timer que da um intervalo entre a animação do alongamento e o momento do usuário fazer esse mesmo alongamento.
    func startTimerBeforeStretching() {
        
        countTimerBeforeStretching = 3
        labelTimerBeforeStartStretching.setHidden(false)
        labelTimerBeforeStartStretching.setText("\(countTimerBeforeStretching)")
        timerBeforeStartStretching = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: checkTimerBeforeStretchingFinished(myTimer:))
        
    }
    //  Essa função é chamada até que o timer que aparece antes da realização do exercício chegue a 0
    func checkTimerBeforeStretchingFinished(myTimer: Timer) {
        countTimerBeforeStretching-=1
        labelTimerBeforeStartStretching.setText("\(countTimerBeforeStretching)")
        //  Verifica se o timer chegou a 0, e caso tenha chegado, ele some para que o usuário possa começar o seu alongamento.
        if countTimerBeforeStretching <= 0 {
            // animaçao alongamento (na pasta model em StrenchingStrategy)
            self.stretchingEnforcer?.runStretching(stretchingStrategy: StretchingHand(), stretchingController: self)
            //
            myTimer.invalidate()
            labelTimerBeforeStartStretching.setHidden(true)
        }
    }
    
    //  Inicializa a animação do alongamento
    func startAnimationStretching() {
        //  Busca todas as imagens que possuem o nome passado nos Assets(O número inteiro no nome dos assets é ignorado e adicionado de acordo com o range da função seguinte).
        if let imagePath = Bundle.main.path(forResource: "alongamento_1",
            ofType: "png"){
            animatedImage.setImage(UIImage(contentsOfFile: imagePath))
        }
        //  Traz as imagens em sequência, que estiverem dentro do Range passado com o nome dado anteriormente.
        //  location define qual imagem será buscada primeiro(0 = primeira imagem, 1 = segunda imagem...) e o length é a quantidade de imagens.
//        animatedImage.startAnimatingWithImages(in: NSRange(location: 0, length: 1), duration: 2, repeatCount: 2)
        countAnimationDuration = 3
        
        timerShowAnimation = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: checkAnimationStretchingFinished(myTimer:))
    }
   //   Verifica se a animação de alongamento acabou, e chama startTimerBeforeStretching() caso a animação tenha terminado.
    func checkAnimationStretchingFinished(myTimer: Timer) {
        countAnimationDuration-=1
        if countAnimationDuration <= 0 {
            myTimer.invalidate()
            animatedImage.setImage(nil)
            animatedImage.setHidden(true)
            startTimerBeforeStretching()
        }
    }
    
    public func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
    }
    
    public func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
    }
    
    public func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
    }
}
