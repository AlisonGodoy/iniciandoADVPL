
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function TESTE02()

    Local  aArea 
    Local cQuery := ""
    Local aDados := {}
    Local nCount 
    
    PREPARE ENVIRONMENT EMPRESA "01" FILIAL "0101" MODULO "fat" //prepara o ambiente 
    aArea := SB1->(GetArea()) // informa ambiente/area que será trabalhado

    cQuery := " SELECT TOP (10) "
    cQuery += " B1_COD AS 'COD_PRODUTO', B1_DESC AS 'DESCRICAO' "
    cQuery += " FROM "
    cQuery += " "+ RetSQLName ("SB1")

    // Executa a consulta criada acima
    TCQuery cQuery New Alias "TMP" //cria tabela temporária chamada TMP com a consulta acima

    While ! TMP->(EOF()) // enquanto TMP for ! de final de arquivo (EOF)

        Aadd(aDados, COD_PRODUTO) // Adiciona ao array os campos até o final da consulta
        Aadd(aDados, DESCRICAO)
        TMP->(DBSKIP()) // sai da tabela TMP

    ENDDO

    //Alert(Len(aDados))

    For nCount := 1 TO Len(aDados)
        //MsgInfo(aDados[nCount], "Retornos BD")
        MSGALERT(aDados[nCount])
    Next nCount

    TMP->(DBCLOSEAREA()) // Fecha a tabela TMP criada
    RestArea(aArea) // Fecha a Area

RETURN
