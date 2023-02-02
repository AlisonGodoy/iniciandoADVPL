
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function ATT02()

    Local oBInclui
    Local oBTShow
    Local oBShowOne
    Local oBAltera
    Local oBDeleta
    Local oGCod
    Local oGEnd
    Local oGNome
    Local oSay1
    Local oSay2
    Local oSay3
    Static oDlg
    Private aDados := {}
    Private cGCod := Space(5) //define o tamanho do campo
    Private cGEnd := Space(20)
    Private cGNome := Space(10)

    DEFINE MSDIALOG oDlg TITLE "Teste - Tela CRUD" FROM 000, 000  TO 500, 500 COLORS 0, 16777215 PIXEL

    //Campos para digitação
    @ 031, 025 MSGET oGCod VAR cGCod SIZE 050, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 031, 090 MSGET oGNome VAR cGNome SIZE 050, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 031, 159 MSGET oGEnd VAR cGEnd SIZE 065, 010 OF oDlg COLORS 0, 16777215 PIXEL

    //Definção dos nomes dos campos
    @ 022, 025 SAY oSay1 PROMPT "Código" SIZE 018, 008 OF oDlg COLORS 0, 16777215 PIXEL
    @ 022, 090 SAY oSay2 PROMPT "Nome" SIZE 016, 006 OF oDlg COLORS 0, 16777215 PIXEL
    @ 022, 159 SAY oSay3 PROMPT "Endereço" SIZE 025, 008 OF oDlg COLORS 0, 16777215 PIXEL

    //Botões
    @ 048, 191 BUTTON oBInclui PROMPT "Incluir" SIZE 018, 011 PIXEL OF oDlg ACTION MsgRun('Validando dados','Carregando',{|| fInclui(cGCod,cGNome,cGEnd),;
                                                                                              cGCod := Space(5),cGEnd := Space(20),cGNome := Space(10)})
    @ 061, 019 BUTTON oBTShow PROMPT "Mostrar Todos" SIZE 047, 011 PIXEL OF oDlg ACTION MsgRun('Recuperando dados','Carregando',{|| fShowAll()})
    @ 078, 019 BUTTON oBShowOne PROMPT "Pesquisar" SIZE 047, 011 PIXEL OF oDlg ACTION MsgRun('Recuperando dados','Carregando',{|| fShowOne(cGCod)})
    @ 096, 019 BUTTON oBAltera PROMPT "Alterar" SIZE 047, 011 PIXEL OF oDlg ACTION MsgRun('Recuperando dados','Carregando',{|| fAltera(cGCod)})
    @ 114, 019 BUTTON oBDeleta PROMPT "Deletar" SIZE 047, 011 PIXEL OF oDlg ACTION MsgRun('Deletando dados','Deletando',{|| fDeleta(cGCod)})

    ACTIVATE MSDIALOG oDlg CENTERED
Return

//Função do botão Incluir//
Static Function fInclui(cGCod,cGNome,cGEnd)

    DbSelectArea("ZZ1")
    ZZ1->(DBGOTOP())

    if (DBSEEK(xFilial("ZZ1010")+cGCod))
        
        MsgAlert("Já possui um registro cadastrado com este código", "Atenção!")
        DBCLOSEAREA()

    else
        if Len(AllTrim(cGCod)) != 5 

            MsgAlert("O campo Código deve conter 5 caracteres", "Atenção!")
            
        else
            if Empty(AllTrim(cGCod)) .OR. Empty(AllTrim(cGEnd)) .OR. Empty(AllTrim(cGNome))
            
                MsgAlert("Existem campos não preenchidos, favor verificar", "Atenção!")

            else

                DbSelectArea("ZZ1")
                ZZ1->(DBGOBOTTOM()) //Inicia no final da tabela

                    RecLock("ZZ1",.T.)
                    
                    ZZ1->ZZ1_COD    := cGCod
                    ZZ1->ZZ1_NOME   := cGNome
                    ZZ1->ZZ1_END    := cGEnd
                        
                    MsUnlock()

                //Aadd(aDados,{cGCod,cGNome,cGEnd})
                MsgInfo("Inclusão realizada com sucesso", "Aviso")

            ENDIF
        ENDIF
    ENDIF
RETURN

//Função do botão Mostrar Tudo//
Static Function fShowAll()

    DbSelectArea("ZZ1")
    ZZ1->(DBGOTOP())

    if ZZ1->(RECCOUNT()) = 0 //Determina o número de registros existentes no arquivo. 

        MsgAlert("Não existe dados para exibir", "Aviso!")
        DBCLOSEAREA()

    else

        DbSelectArea("ZZ1")
        ZZ1->(DBGOTOP())

        while !ZZ1->(EOF())
            
            MsgInfo("Codigo ->"+ZZ1->ZZ1_COD+;
            " Nome ->"+ZZ1->ZZ1_NOME+;
            " Endereço ->"+ZZ1->ZZ1_END)

            ZZ1->(DBSKIP()) //Pula para a próxima linha da area

        ENDDO        
        DBCLOSEAREA()

    endif
RETURN

//Função do botão Pesquisar//
Static Function fShowOne(cGCod)

    DbSelectArea("ZZ1")
    ZZ1->(DBGOTOP())

    if !(DBSEEK(xFilial("ZZ1010")+cGCod)) //busca na tabela um registro com esta informação

        MsgAlert("Não existe dados para exibir", "Atenção!")
        DBCLOSEAREA()

    else

        DbSelectArea("ZZ1")

        MsgInfo("Registro encontrado com sucesso", "Aviso")
        cGNome  := ZZ1->ZZ1_NOME
        cGEnd   := ZZ1->ZZ1_END

        DBCLOSEAREA()

    endif
RETURN

//Função do botão Alterar//
Static Function fAltera(cGCod)

    dbSelectArea("ZZ1")
    dbSetOrder(1)

    if !(dbSeek(xFilial("ZZ1010")+cGCod))

	    Alert("O código não pode ser alterado OU este registro não existe","Atenção!")
	    dbCloseArea()

    else

	    dbSelectArea("ZZ1")
		RecLock("ZZ1",.F.)  
		    ZZ1->ZZ1_COD	:= cGCod
		    ZZ1->ZZ1_NOME	:= cGNome
		    ZZ1->ZZ1_END 	:= cGEnd

	    MsUnlock()
	    dbCloseArea()
	
	MsgInfo("Alteração efetuada com sucesso!","Aviso!")

    ENDIF
return

//Função do botão Deletar//
Static Function fDeleta(cGCod)

    dbSelectArea("ZZ1")
    dbSetOrder(1)

    if !(dbSeek(xFilial("ZZ1010")+cGCod))

	    Alert("Este registro não existe","Atenção!")
	    dbCloseArea()

    else
        if MsgYesNo("Tem certeza que deseja deletar este registro?", "Atenção!")

            dbSelectArea("ZZ1")
            RecLock("ZZ1",.F.)  

                DBDELETE()

            MsUnlock()
            MsgInfo("Delete efetuado com sucesso!","Aviso!")

        else
            MsgInfo("Delete abortado pelo usuário", "Aviso!")

        ENDIF
    ENDIF
    DBCLOSEAREA()   
RETURN
