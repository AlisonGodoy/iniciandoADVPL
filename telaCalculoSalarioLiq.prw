
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function SalLiq()

    Local oBCalcula
    Local oGSalBruto
    Local oGDescontos
    Local oSay1
    Local oSay2
    Static oDlg
    Private nGSalBruto  := Space(15) 
    Private nGDescontos := Space(15)

    DEFINE MSDIALOG oDlg TITLE "Teste - Calculadora de Salário Líquido" FROM 000, 000  TO 500, 500 COLORS 0, 16777215 PIXEL

    //Definção dos nomes dos campos
    @ 020, 025 SAY oSay1 PROMPT "Digite seu Salário Bruto" OF oDlg COLORS 0, 16777215 PIXEL
    @ 020, 110 SAY oSay2 PROMPT "Digite seus Descontos Extras" OF oDlg COLORS 0, 16777215 PIXEL

    //Campos para digitação
    @ 030, 025 MSGET oGSalBruto VAR nGSalBruto SIZE 050, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 030, 110 MSGET oGDescontos VAR nGDescontos SIZE 050, 010 OF oDlg COLORS 0, 16777215 PIXEL

    //Botões
    @ 090, 085 BUTTON oBCalcula PROMPT "Calcular" SIZE 025, 011 PIXEL OF oDlg ACTION MsgRun('Calculando Salario','Calculando',{|| fCalc02(nGSalBruto,nGDescontos)}) 

    ACTIVATE MSDIALOG oDlg CENTERED

RETURN

Static Function fCalc02(nGSalBruto,nGDescontos)

    Local nSalLiquido       := 0
    Local nSalComDesconto   := 0
    Local nDescontoInss     := 0
    Local nDescontoRenda    := 0

    nGSalBruto  := M->nGSalBruto
    nGDescontos := M->nGDescontos

    nSalComDesconto := VAL(nGSalBruto)-VAL(nGDescontos)

    if nGSalBruto <= "1302.00"

        nDescontoInss := nSalComDesconto * 0.075
        nSalLiquido := nSalComDesconto - nDescontoInss
        MsgInfo(nSalLiquido, "Aviso")

    elseif nGSalBruto >= "1302.01" .AND. nGSalBruto <= "1903.98"    

        nDescontoInss := nSalComDesconto * 0.09
        nSalLiquido := nSalComDesconto - nDescontoInss
        MsgInfo(nSalLiquido, "Aviso")

    elseif nGSalBruto >= "1903.99" .AND. nGSalBruto <= "2427.35" //aplicar IR 7,5

        nDescontoInss := nSalComDesconto * 0.09
        nDescontoRenda := (nSalComDesconto - nDescontoInss)* 0.075
        nSalLiquido := nSalComDesconto - (nDescontoInss + nDescontoRenda)
        MsgInfo(nSalLiquido, "Aviso")

    elseif nGSalBruto >= "2427.36" .AND. nGSalBruto <= "2826.65" //aplicar IR 7,5

        nDescontoInss := nSalComDesconto * 0.12
        nDescontoRenda := (nSalComDesconto - nDescontoInss)* 0.075
        nSalLiquido := nSalComDesconto - (nDescontoInss + nDescontoRenda)
        MsgInfo(nSalLiquido, "Aviso")

    elseif nGSalBruto >= "2826.66" .AND. nGSalBruto <= "3641.03" //aplicar IR 15

        nDescontoInss := nSalComDesconto * 0.12
        nDescontoRenda := (nSalComDesconto - nDescontoInss)* 0.15
        nSalLiquido := nSalComDesconto - (nDescontoInss + nDescontoRenda)
        MsgInfo(nSalLiquido, "Aviso")

    elseif nGSalBruto >= "3641.04" .AND. nGSalBruto <= "3751.05" //aplicar IR 15

        nDescontoInss := nSalComDesconto * 0.14
        nDescontoRenda := (nSalComDesconto - nDescontoInss)* 0.15
        nSalLiquido := nSalComDesconto - (nDescontoInss + nDescontoRenda)
        MsgInfo(nSalLiquido, "Aviso")

    elseif nGSalBruto >= "3751.06" .AND. nGSalBruto <= "4664.68" //aplicar IR 22.5

        nDescontoInss := nSalComDesconto * 0.14
        nDescontoRenda := (nSalComDesconto - nDescontoInss)* 0.225
        nSalLiquido := nSalComDesconto - (nDescontoInss + nDescontoRenda)
        MsgInfo(nSalLiquido, "Aviso")

    else //aplicar ir 27.5

        nDescontoInss := nSalComDesconto * 0.14
        nDescontoRenda := (nSalComDesconto - nDescontoInss)* 0.275
        nSalLiquido := nSalComDesconto - (nDescontoInss + nDescontoRenda)
        MsgInfo(nSalLiquido, "Aviso")

    ENDIF   
        
RETURN
