
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function ATT01()

    Local cAlias  := "SB1"
    Local cTitulo := "Minha Tela de Cadastro AxCadastro"
    Local lVldExc := ".T." //permite exclusão
    Local lVldAlt := ".T." //permite alteração 

    AxCadastro (cAlias, cTitulo, lVldExc, lVldAlt)

RETURN
