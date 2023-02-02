
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function ADIVINHA ()

    Local nNum       := RANDOMIZE(1, 100)
    Local nChute     := 0
    Local nTentativa := 0

    While nChute != nNum
        nChute := Val(FWInputBox("Escolha um numero [1 - 100]", ""))
        
        if nChute == nNum
            MsgInfo("Parabéns, você acertou! - <b>" + CValToChar(nChute) + "</b><br>ERROS: " + cValToChar(nTentativa), "Fim de jogo")

        elseif nChute > nNum
            msgAlert("Chute mais baixo!")
            nTentativa += 1
        else
            msgAlert("Chute mais alto!")
            nTentativa += 1

        endif
    End            

RETURN
