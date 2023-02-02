#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function TESTE04()

    //Inicia varíaveis e acesso ao banco normalmente, após:

    Local aDados := {}
    Private lMsErroAuto := .F. //Varíavel padrão do MSExecAuto - sempre inicia como .F., caso haja erro na operação irá alimentar como .T.

    aDados := {;
              {"Aqui é inserido todos os dados que devem ser inseridos na tabela, separando por virgula"},;
              {"';' quebra linha", NIL};
              }      
    
    Begin Transaction

        MSExecAuto({|x,y|Mata010(x,y)},aDados,3) //Dentro dos pipes é passado os param x e y, é chamado o programa Mata010 (cadastro de produtos), após enviado o array
                                                 //e por ultimo o cod de operação, 3 = Insert, 4 = Update, 5 = Delete

        //Caso ocorra algum erro...
        if lMSErroAuto

            Alert("Ocorreu erro durante a operação")
            MostraErro() // função que irá abrir o log de erro
        
            DisarmTransaction() // função que desarma toda operação acima

        else
            MsgInfo("Operação Finalizada", "Aviso!")
        endif

    End Transaction
    
    // fecha area

RETURN
