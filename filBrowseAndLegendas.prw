
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function ATT03()

    Local cAlias        := "SA2"
    Local aCores        := {}
    Local cFiltra       := "A2_FILIAL == '"+xFilial('SA2')+"' .And. A2_TIPO == 'F'"
    Private cCadastro   := "Cadastro MBrowse"
    Private aRotina     := {}
    Private aIndexSA2   := {}
    Private bFiltraBrw  := {|| FilBrowse(cAlias, @aIndexSA2,@cFiltra)} //Filbrowse


    Aadd(aRotina,{"Pesquisar"       ,"AxPesqui"         ,0,1}) //Titulo, Funcao, sempre 0, cod da operação
    Aadd(aRotina,{"Visualizar"      ,"AxVisual"         ,0,2})
    Aadd(aRotina,{"Incluir"         ,"U_BInclui"        ,0,3})
    Aadd(aRotina,{"Alterar"         ,"U_BAltera"        ,0,4})
    Aadd(aRotina,{"Excluir"         ,"U_BDeleta"        ,0,5})
    Aadd(aRotina,{"Legenda"         ,"U_BLegenda"       ,0,6})

    Aadd(aCores, {"A2_TIPO == 'F'" ,"BR_VERDE"})
    Aadd(aCores, {"A2_TIPO == 'J'" ,"BR_AMARELO"})
    Aadd(aCores, {"A2_TIPO == 'X'" ,"BR_LARANJA"})
    Aadd(aCores, {"A2_TIPO == 'R'" ,"BR_MARROM"})
    Aadd(aCores, {"Empty(A2_TIPO)" ,"BR_PRETO"})

    DbSelectArea(cAlias)
    DbSetOrder(1) // indice

    EVAL(bFiltraBrw) //Executa o FilBrowse

    DBGOTOP()
    MBrowse(6,1,22,75,cAlias,,,,,,aCores)

    EndFilBrw(cAlias,aIndexSA2) //Fecha o FilBrowse

RETURN

//--- Criando as funções Utilizadas na ATT03 ---//

User Function BInclui(cAlias,nReg,nOpc) //tabela,registro protheus, opção 1,2,3...

    Local nOpcao := 0
    nOpcao := AxInclui(cAlias,nReg,nOpc)

    IF nOpcao == 1

        MsgInfo("Inserção Cancelada", "Atenção!")

    ELSE

        MsgAlert("Inserção efetuada com sucesso", "Aviso")

    ENDIF

RETURN NIL

User Function BAltera(cAlias,nReg,nOpc)

    Local nOpcao := 0
    nOpcao := AxAltera(cAlias,nReg,nOpc)

    IF nOpcao == 1

        MsgInfo("Alteração Cancelada", "Atenção!")

    ELSE

        MsgAlert("Alteração efetuada com sucesso", "Aviso")

    ENDIF

RETURN NIL

User Function BDeleta(cAlias,nReg,nOpc)

    Local nOpcao := 0
    nOpcao := AxDeleta(cAlias,nReg,nOpc)

    IF nOpcao == 1

        MsgInfo("Exclusão Cancelada", "Atenção!")

    ELSE

        MsgAlert("Exclusão efetuada com sucesso", "Aviso")

    ENDIF

RETURN NIL

User Function BLegenda()

    Local aLegenda := {}

    Aadd(aLegenda,{"BR_VERDE", "Pessoa Fisica"})
    Aadd(aLegenda,{"BR_AMARELO", "Pessoa Juridica"})
    Aadd(aLegenda,{"BR_LARANJA", "Exportacao"})
    Aadd(aLegenda,{"BR_MARROM", "Forn. Rural"})
    Aadd(aLegenda,{"BR_PRETO", "Não Classificado"})

    BrwLegenda(cCadastro, "Legenda", aLegenda)

RETURN
