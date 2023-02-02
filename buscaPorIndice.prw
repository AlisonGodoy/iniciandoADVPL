
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function TESTE01()

    lOCAL  aArea 
    
    PREPARE ENVIRONMENT EMPRESA "01" FILIAL "0101" MODULO "fat" //prepara o ambiente 


    aArea := SB1->(GetArea()) // informa ambiente/area que será trabalhado

    DbSelectArea("SB1") // seleciona a área que será feita as instruções abaixo
    SB1->(DbSetOrder(1)) // Define o indice = 1
    SB1->(DbGoTop()) // Confirma que a leitura será iniciada no topo da tabela

    // posiciona o produto de código 015516
    if SB1->(dbSeek(XFilial("SB1")+ "015516")) // localiza um registro com o que for indicado
        Alert(SB1->B1_DESC)
    ENDIF

    RestArea(aArea) // "fecha" o ambiente preparado

    RESET ENVIRONMENT
     
RETURN
