
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function TESTE03()

    //Inicia var�aveis e acesso ao banco normalmente, ap�s:
    Begin Transaction

        MsgInfo("A descri��o ser� alterada", "Aten��o")

    //fazer IF trazendo o que ser� alterado por �ndice ou por consulta
        RecLock('SB1', .F.) //Trava o registro para altera��o, usar .T. para inser��o
        Replace B1_DESC With "Teste altera��o"

        SB1->(MsUnlock()) //Destrava a tabela
    //Fecha IF

    End Transaction
    //fecha Area        
         
RETURN
