
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function medCalc()

    Local oBCalcula
    Local oGNota01
    Local oGNota02
    Local oGNota03
    Local oSay1
    Static oDlg
    Private nGNota01 := Space(4) 
    Private nGNota02 := Space(4)
    Private nGNota03 := Space(4)


    DEFINE MSDIALOG oDlg TITLE "Teste - Média Alunos" FROM 000, 000  TO 500, 500 COLORS 0, 16777215 PIXEL

    //Definção dos nomes dos campos
    @ 020, 025 SAY oSay1 PROMPT "Notas Aluno" SIZE 050, 010 OF oDlg COLORS 0, 16777215 PIXEL

    //Campos para digitação
    @ 030, 025 MSGET oGNota01 VAR nGNota01 SIZE 050, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 045, 025 MSGET oGNota02 VAR nGNota02 SIZE 050, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 060, 025 MSGET oGNota03 VAR nGNota03 SIZE 050, 010 OF oDlg COLORS 0, 16777215 PIXEL

    //Botões
    @ 048, 191 BUTTON oBCalcula PROMPT "Calcular" SIZE 025, 011 PIXEL OF oDlg ACTION MsgRun('Calculando Notas','Calculando',{|| fCalc01(nGNota01,nGNota02,nGNota03)}) 

    ACTIVATE MSDIALOG oDlg CENTERED

RETURN

Static Function fCalc01(nGNota01,nGNota02,nGNota03)
    
    Local nMediaNotas
    //Local nDivid := 3

    nGNota01 := STRTRAN(AllTrim(M->nGNota01),",",".")
    nGNota02 := STRTRAN(AllTrim(M->nGNota02),",",".")
    nGNota03 := STRTRAN(AllTrim(M->nGNota03),",",".")

    nMediaNotas := ROUND((VAL(ngNota01) + VAL(ngNota02) + VAL(ngNota03)) / 3,2)

    if nMediaNotas >=6

        MsgInfo("Nota: "+ CValToChar(nMediaNotas) +" -> Aluno <b>Aprovado!</b>","Aviso!")
            
    else 
    
        MsgInfo("Nota: "+ CValToChar(nMediaNotas) +" -> Aluno <b>Reprovado!</b>","Aviso!")
  

    ENDIF
RETURN
