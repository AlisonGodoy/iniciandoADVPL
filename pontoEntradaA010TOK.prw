
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function A010TOK()

    Local lExecuta := .T. // vari�vel de retorno informada pela TOTVS
    Local cTipo := AllTrim(M->B1_TIPO) //AllTrim remove os espa�os em branco, M � espa�o em mem�ria onde � alocado o que o usuario selecionou/digitou naquele momento
    Local cUnidade := AllTrim(M->B1_UM)

    if (cTipo = "PA" .AND. cUnidade = "AR") 
        
        Alert("A unidade <b>"+ cUnidade + "</b> n�o pode estar "+;
              "associada ao tipo <b>"+ cTipo + "</b>")

        lExecuta = .F.

    endif

RETURN(lExecuta) // sempre deve retornar a vari�vel informada
