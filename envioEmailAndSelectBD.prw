
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "Tbiconn.ch"        
#Include "TOTVS.ch"
#include "rwmake.ch"

User Function ATT02()

    Local oButton1
    Local oGet1
    Local oGet2
    Local oSay1
    Local oSay2
    Local oSay3
    Static oDlg
    Private cGet2 := Date()
    Private cGet1 := Date()
    Private aDados := {}

    //Cria primeira tela para selecionar os filtros
    DEFINE MSDIALOG oDlg TITLE "Consulta Customizada - Pedidos de Venda" FROM 000, 000  TO 500, 500 COLORS 0, 16777215 PIXEL

        @ 024, 034 SAY oSay1 PROMPT "SELECIONE O PERIODO - VISUALIZAR PEDIDOS DE VENDA" SIZE 179, 009 OF oDlg COLORS 0, 16777215 PIXEL
        @ 047, 032 SAY oSay2 PROMPT "Data Emiss�o - Inicial" SIZE 057, 008 OF oDlg COLORS 0, 16777215 PIXEL
        @ 047, 136 SAY oSay3 PROMPT "Data Emiss�o - Final" SIZE 056, 008 OF oDlg COLORS 0, 16777215 PIXEL

        @ 057, 031 MSGET oGet1 VAR cGet1 SIZE 056, 010 OF oDlg COLORS 0, 16777215 PIXEL
        @ 057, 135 MSGET oGet2 VAR cGet2 SIZE 056, 010 OF oDlg COLORS 0, 16777215 PIXEL

        //Bot�o que chama a fun��o fGer01()
        @ 084, 082 BUTTON oButton1 PROMPT "Gerar" SIZE 053, 012 PIXEL OF oDlg ACTION MsgRun('Gerando Relat�rio','Carregando',{|| fGer01(cGet1,cGet2)})

    ACTIVATE MSDIALOG oDlg CENTERED

Return

//Monta o browse de acordo com a query - Start
Static Function fGer01(cGet1,cGet2)

    cGet1 := DTOS(M->cGet1) //tranforma os valores de Data enviados pelo usu�rio em String e armazena na mem�ria
    cGet2 := DTOS(M->cGet2)

    Local oBrowse := nil
    Local cQuery := "SELECT SC5010.C5_NUM AS 'NUM_PEDIDO', SC5010.C5_EMISSAO AS 'DATA_EMISSAO', SC6010.C6_PRODUTO AS 'COD_PRODUTO', SC6010.C6_DESCRI AS 'DESCRICAO_PROD',"+;
		            " SC6010.C6_QTDVEN AS 'QUANTIDADE_VEND', SC6010.C6_PRCVEN AS 'VALOR_UNI', SC6010.C6_VALOR AS 'VALOR_TOTAL_ITEM'"+;
                    " FROM SC5010, SC6010"+;
                    " WHERE SC5010.C5_NUM = SC6010.C6_NUM AND SC5010.C5_EMISSAO BETWEEN '"+cGet1+"' AND '"+cGet2+"'"+;
                    " ORDER BY SC5010.C5_EMISSAO ASC"

    TcQuery cQuery New Alias "QRY"
    dbSelectArea('QRY')  
    QRY->(DBGOTOP())

    //Montagem do grid do relat�rio - Start
    DEFINE DIALOG oDlg TITLE "Consulta Pedidos de Venda - Por per�odo" FROM 000, 000 TO 765, 916 PIXEL           
  
    WHILE !QRY->(EOF()) //la�o para montar o array com os resultados da query
            
        aAdd( aDados, { QRY->NUM_PEDIDO, QRY->DATA_EMISSAO, QRY->COD_PRODUTO, QRY->DESCRICAO_PROD, QRY->QUANTIDADE_VEND, QRY->VALOR_UNI, QRY->VALOR_TOTAL_ITEM } )
        QRY->(DBSKIP())

    ENDDO

    DBCLOSEAREA()

    // Cria browse
    oBrowse := MsBrGetDBase():new( 0, 0, 460, 370,,,, oDlg,,,,,,,,,,,, .F., "", .T.,, .F.,,, )
 
    // Define vetor para a browse
    oBrowse:setArray( aDados )
 
    // Cria colunas do browse
    oBrowse:addColumn( TCColumn():new( "Num. pedido",       { || aDados[oBrowse:nAt, 1] },,,, "LEFT",, .F., .F.,,,, .F. ) )
    oBrowse:addColumn( TCColumn():new( "Data Emiss�o",      { || aDados[oBrowse:nAt, 2] },,,, "LEFT",, .F., .F.,,,, .F. ) )
    oBrowse:addColumn( TCColumn():new( "Cod. Produto",      { || aDados[oBrowse:nAt, 3] },,,, "LEFT",, .F., .F.,,,, .F. ) )
    oBrowse:addColumn( TCColumn():new( "Descri��o",         { || aDados[oBrowse:nAt, 4] },,,, "LEFT",, .F., .F.,,,, .F. ) )
    oBrowse:addColumn( TCColumn():new( "Quantidade Vend.",  { || aDados[oBrowse:nAt, 5] },,,, "LEFT",, .F., .F.,,,, .F. ) )
    oBrowse:addColumn( TCColumn():new( "Valor Uni.",        { || aDados[oBrowse:nAt, 6] },,,, "LEFT",, .F., .F.,,,, .F. ) )
    oBrowse:addColumn( TCColumn():new( "Valor Total Item",  { || aDados[oBrowse:nAt, 7] },,,, "LEFT",, .F., .F.,,,, .F. ) )
    oBrowse:Refresh()
 
    // Cria Bot�es com m�todos b�sicos
    TButton():new( 372, 002, "Acima",           oDlg, { || oBrowse:goUp(), oBrowse:setFocus() }, 40, 010,,, .F., .T., .F.,, .F.,,, .F. )
    TButton():new( 372, 052, "Abaixo",          oDlg, { || oBrowse:goDown(), oBrowse:setFocus() }, 40, 010,,, .F., .T., .F.,, .F.,,, .F. )
    TButton():new( 372, 102, "Ir ao Topo",      oDlg, { || oBrowse:goTop(), oBrowse:setFocus() }, 40, 010,,, .F., .T., .F.,, .F.,,, .F. )
    TButton():new( 372, 152, "Ir ao Ultimo",    oDlg, { || oBrowse:goBottom(), oBrowse:setFocus() }, 40, 010,,, .F., .T., .F.,, .F.,,, .F. )

    // Cria Bot�o que chama a fun��o Mail01()
    @ 372, 202 BUTTON oButton1 PROMPT "Enviar E-mail" SIZE 40, 010 PIXEL OF oDlg ACTION MsgRun('Enviando E-mail','Enviando',{|| Mail01(cGet1,cGet2)})

    ACTIVATE DIALOG oDlg CENTERED
    //Montagem do grid do relat�rio - End

RETURN
//Monta o browse de acordo com a query - End

//Envio do relat�rio via e-mail - Start
Static Function Mail01(cGet1,cGet2)

    Local cHtml := ""
    Local cEmailTo := RTrim(UsrRetMail(__CUSERID)) //retorna o cod do usuario logado no momento/retorna seu e-mail/retira espa�os a diretira

    Local cQuery := "SELECT SC5010.C5_NUM AS 'NUM_PEDIDO', SC5010.C5_EMISSAO AS 'DATA_EMISSAO', SC6010.C6_PRODUTO AS 'COD_PRODUTO', SC6010.C6_DESCRI AS 'DESCRICAO_PROD',"+;
		            " SC6010.C6_QTDVEN AS 'QUANTIDADE_VEND', SC6010.C6_PRCVEN AS 'VALOR_UNI', SC6010.C6_VALOR AS 'VALOR_TOTAL_ITEM'"+;
                    " FROM SC5010, SC6010"+;
                    " WHERE SC5010.C5_NUM = SC6010.C6_NUM AND SC5010.C5_EMISSAO BETWEEN '"+cGet1+"' AND '"+cGet2+"'"+;
                    " ORDER BY SC5010.C5_EMISSAO ASC"

    //Montagem da tabela que ser� enviada por e-mail - Start
    cHtml += "<html>"
    cHtml +=    "<head>"
    cHtml +=        "<style>"
    cHtml +=            "table, th, td {"
    cHtml +=            "border: 1px solid black;"
    cHtml +=            "}"
    cHtml +=        "</style>"
    cHtml +=    "</head>"
    cHtml +=    "<body>"
    cHtml +=    "<p>Ol�!</p><p>Segue abaixo relat�rio dos pedidos de vendas do per�odo de "+CValToChar(STOD(cGet1))+" at� "+CValToChar(STOD(cGet2))+"</p>"
    cHtml +=        "<table>"
	cHtml +=            "<tr> "
	cHtml +=                "<td><b>NUM_PEDIDO</b></td>"
	cHtml +=                "<td><b>DATA_EMISSAO</b></td>"
	cHtml +=                "<td><b>COD_PRODUTO</b></td>"
	cHtml +=                "<td><b>DESCRICAO_PROD</b></td>"
    cHtml +=                "<td><b>QUANTIDADE_VEND</b></td>"
	cHtml +=                "<td><b>VALOR_UNI</b></td>"
	cHtml +=                "<td><b>VALOR_TOTAL_ITEM</b></td>"
	cHtml +=            "</tr>"
    
    TcQuery cQuery New Alias "QRY"
    dbSelectArea('QRY')  
    QRY->(DBGOTOP())

    //alimenta as linhas da tabela
    WHILE !QRY->(EOF())

        cHtml +=        "<tr>"
        cHtml +=            "<td>"+QRY->NUM_PEDIDO+"</td>"
        cHtml +=            "<td>"+QRY->DATA_EMISSAO+"</td>"
        cHtml +=            "<td>"+QRY->COD_PRODUTO+"</td>"
        cHtml +=            "<td>"+QRY->DESCRICAO_PROD+"</td>"
        cHtml +=            "<td>"+CValToChar(QRY->QUANTIDADE_VEND)+"</td>"
        cHtml +=            "<td>"+CValToChar(QRY->VALOR_UNI)+"</td>"
        cHtml +=            "<td>"+CValToChar(QRY->VALOR_TOTAL_ITEM)+"</td>"
        cHtml +=        "</tr>"
        QRY->(DBSKIP()) 

    ENDDO 

    DBCLOSEAREA()

    cHtml +=        "</table>"
    cHtml +=    "</body>"
    cHtml += "</html>"	
	//Montagem da tabela que ser� enviada por e-mail - Start

			//Faz o envio do e-mail - Start
			oProcess := nil //respons�vel pela cria��o e gerenciamento do processo
			oProcess := TWFProcess():New("Mail01", "testeEmailGodoy") //responsavel pela cria��o e inicializa��o da classe WFProcess 
			oProcess:NewTask ("Teste de envio de e-mail","\workflow\Testes\teste_agodoy_email.htm") //resp. por criar a seq. de tarefas a serem executadas e identificar qual html ser� utilizado pelo processo

			oHTML := oProcess:oHTML //Esta propriedade � respons�vel pelo tratamento das palavras chaves no html mencionado no m�todo :NewTask()

			oHTML:ValByName( "TAB_REL_TESTE", cHtml	)  //atribui ou obtem um valor � uma macro existente no html - substitui TAB_REL_TESTE por cHtml
			
			oProcess:cFromName	:= "Imply Tecnologia Eletr�nica LTDA" //remetente
			oProcess:cSubject	:= "Envio de E-mail Teste" //assunto
            //oProcess:AttachFile("\workflow\Testes\testeAnexo.txt") Envia arquivo anexo
			oProcess:cTo		:= cEmailTo //destinat�rio
			oProcess:Start() //inicia o processo de envio

            MsgInfo("E-mail enviado com sucesso para <b>"+ cEmailTo, "Aviso!")
            //Faz o envio do e-mail - End
RETURN
//Envio do relat�rio via e-mail - End
