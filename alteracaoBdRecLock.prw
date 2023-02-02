
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function TESTE03()

    //Inicia varíaveis e acesso ao banco normalmente, após:
    Begin Transaction

        MsgInfo("A descrição será alterada", "Atenção")

    //fazer IF trazendo o que será alterado por índice ou por consulta
        RecLock('SB1', .F.) //Trava o registro para alteração, usar .T. para inserção
        Replace B1_DESC With "Teste alteração"

        SB1->(MsUnlock()) //Destrava a tabela
    //Fecha IF

    End Transaction
    //fecha Area        
         
RETURN
