#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function TESTE04()

    //Inicia var�aveis e acesso ao banco normalmente, ap�s:

    Local aDados := {}
    Private lMsErroAuto := .F. //Var�avel padr�o do MSExecAuto - sempre inicia como .F., caso haja erro na opera��o ir� alimentar como .T.

    aDados := {;
              {"Aqui � inserido todos os dados que devem ser inseridos na tabela, separando por virgula"},;
              {"';' quebra linha", NIL};
              }      
    
    Begin Transaction

        MSExecAuto({|x,y|Mata010(x,y)},aDados,3) //Dentro dos pipes � passado os param x e y, � chamado o programa Mata010 (cadastro de produtos), ap�s enviado o array
                                                 //e por ultimo o cod de opera��o, 3 = Insert, 4 = Update, 5 = Delete

        //Caso ocorra algum erro...
        if lMSErroAuto

            Alert("Ocorreu erro durante a opera��o")
            MostraErro() // fun��o que ir� abrir o log de erro
        
            DisarmTransaction() // fun��o que desarma toda opera��o acima

        else
            MsgInfo("Opera��o Finalizada", "Aviso!")
        endif

    End Transaction
    
    // fecha area

RETURN
