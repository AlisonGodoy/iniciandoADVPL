
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function ATT02()

    Local cAlias        := "ZZ1"
    Local aCores        := {}
    Local cFiltra       := "ZZ1_FILIAL == '"+xFilial('ZZ1')+"'
    Private cCadastro   := "Cadastro MBrowse"
    Private aRotina     := {}
    Private aIndexZZ1   := {}
    Private bFiltraBrw  := {|| FilBrowse(cAlias, @aIndexZZ1,@cFiltra)} //Filbrowse


    Aadd(aRotina,{"Pesquisar"       ,"AxPesqui"         ,0,1}) //Titulo, Funcao, sempre 0, cod da operação
    Aadd(aRotina,{"Visualizar"      ,"AxVisual"         ,0,2})
    Aadd(aRotina,{"Incluir"         ,"AxInclui"         ,0,3})
    Aadd(aRotina,{"Alterar"         ,"AxAltera"         ,0,4})
    Aadd(aRotina,{"Excluir"         ,"AxDeleta"         ,0,5})
    Aadd(aRotina,{"Legenda"         ,"U_BLegenda"       ,0,6})

    Aadd(aCores, {"ZZ1_TEAM2 == 'G'" ,"BR_AZUL"})
    Aadd(aCores, {"ZZ1_TEAM2 == 'I'" ,"BR_VERMELHO"})


    DbSelectArea(cAlias)
    DbSetOrder(1) // indice

    EVAL(bFiltraBrw) //Executa o FilBrowse

    DBGOTOP()
    MBrowse(6,1,22,75,cAlias,,,,,,aCores)

    EndFilBrw(cAlias,aIndexZZ1) //Fecha o FilBrowse

RETURN

User Function BLegenda()

    Local aLegenda := {}

    Aadd(aLegenda,{"BR_AZUL", "Gremista"})
    Aadd(aLegenda,{"BR_VERMELHO", "Colorado"})

    BrwLegenda(cCadastro, "Legenda", aLegenda)

RETURN
