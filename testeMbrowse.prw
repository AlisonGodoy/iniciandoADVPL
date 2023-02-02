
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function ATT02()

    Local cAlias  := "SB1"
    Private cTitulo := "Minha Tela de Cadastro MBrowse"
    Private aRotina := {}

    Aadd(aRotina,{"Pesquisar"       ,"AxPesqui"         ,0,1}) //Titulo, Funcao, sempre 0, cod da operação
    Aadd(aRotina,{"Visualizar"      ,"AxVisual"         ,0,2})
    Aadd(aRotina,{"Incluir"         ,"AxInclui"         ,0,3})
    Aadd(aRotina,{"Alterar"         ,"AxAltera"         ,0,4})
    Aadd(aRotina,{"Excluir"         ,"AxDeleta"         ,0,5})
    Aadd(aRotina,{"CRUD Teste"      ,"U_TCrud"          ,0,6})

    DbSelectArea(cAlias)
    DbSetOrder(1) // indice
    MBrowse(,,,,cAlias) // padrão
    //ou MBrowse(6,1,22,75,cAlias)

RETURN
