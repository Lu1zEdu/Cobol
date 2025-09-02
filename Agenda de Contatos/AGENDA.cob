       IDENTIFICATION DIVISION.
       PROGRAM-ID. AGENDA.
       AUTHOR. Luiz.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CONTATOS ASSIGN TO "CONTATOS.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS CONTATO-COD
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD  CONTATOS.
       01  REG-CONTATO.
           05 CONTATO-COD      PIC 9(05).
           05 CONTATO-NOME     PIC X(30).
           05 CONTATO-TELEFONE PIC X(15).
           05 CONTATO-EMAIL    PIC X(40).

       WORKING-STORAGE SECTION.
       01  WS-FS              PIC XX.
       01  WS-OPCAO           PIC 9.
       01  WS-COD-PESQUISA    PIC 9(05).
       01  WS-COD-INICIO      PIC 9(05) VALUE 00001.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN I-O CONTATOS
           IF WS-FS NOT = "00"
               OPEN OUTPUT CONTATOS
               CLOSE CONTATOS
               OPEN I-O CONTATOS
           END-IF.

           PERFORM UNTIL WS-OPCAO = 9
               DISPLAY "=============================="
               DISPLAY "      AGENDA DE CONTATOS"
               DISPLAY "=============================="
               DISPLAY "1 - Inserir Contato"
               DISPLAY "2 - Listar Contatos"
               DISPLAY "3 - Buscar Contato"
               DISPLAY "4 - Alterar Contato"
               DISPLAY "5 - Excluir Contato"
               DISPLAY "9 - Sair"
               DISPLAY "=============================="
               DISPLAY "Escolha uma opcao: "
               ACCEPT WS-OPCAO

               EVALUATE WS-OPCAO
                   WHEN 1 PERFORM INSERIR-CONTATO
                   WHEN 2 PERFORM LISTAR-CONTATOS
                   WHEN 3 PERFORM BUSCAR-CONTATO
                   WHEN 4 PERFORM ALTERAR-CONTATO
                   WHEN 5 PERFORM EXCLUIR-CONTATO
                   WHEN 9 DISPLAY "Fechando agenda."
                   WHEN OTHER DISPLAY "Opcao invalida!"
               END-EVALUATE
           END-PERFORM.

           CLOSE CONTATOS.
           STOP RUN.

       *> ===============================
       *> INSERIR CONTATO
       *> ===============================
       INSERIR-CONTATO.
           DISPLAY "Codigo do Contato (5 digitos): "
           ACCEPT CONTATO-COD.
           DISPLAY "Nome: "
           ACCEPT CONTATO-NOME.
           DISPLAY "Telefone: "
           ACCEPT CONTATO-TELEFONE.
           DISPLAY "Email: "
           ACCEPT CONTATO-EMAIL.
           WRITE REG-CONTATO
               INVALID KEY DISPLAY "Erro: Codigo de contato ja existe!"
           END-WRITE.
           DISPLAY " ".

       *> ===============================
       *> LISTAR CONTATOS
       *> ===============================
       LISTAR-CONTATOS.
           MOVE "00" TO WS-FS.
           START CONTATOS KEY NOT LESS THAN WS-COD-INICIO
               INVALID KEY MOVE "99" TO WS-FS
           END-START.

           PERFORM UNTIL WS-FS = "99"
               READ CONTATOS NEXT RECORD
                   AT END MOVE "99" TO WS-FS
                   NOT AT END
                       DISPLAY "Codigo  : " CONTATO-COD
                       DISPLAY "Nome    : " CONTATO-NOME
                       DISPLAY "Telefone: " CONTATO-TELEFONE
                       DISPLAY "Email   : " CONTATO-EMAIL
                       DISPLAY "-------------------------"
               END-READ
           END-PERFORM.
           DISPLAY " ".

       *> ===============================
       *> BUSCAR CONTATO
       *> ===============================
       BUSCAR-CONTATO.
           DISPLAY "Digite o codigo do contato a buscar: "
           ACCEPT WS-COD-PESQUISA.
           MOVE WS-COD-PESQUISA TO CONTATO-COD.
           READ CONTATOS KEY IS CONTATO-COD
               INVALID KEY
                   DISPLAY "Erro: Contato nao encontrado!"
               NOT INVALID KEY
                   DISPLAY "--- Dados do Contato ---"
                   DISPLAY "Codigo  : " CONTATO-COD
                   DISPLAY "Nome    : " CONTATO-NOME
                   DISPLAY "Telefone: " CONTATO-TELEFONE
                   DISPLAY "Email   : " CONTATO-EMAIL
                   DISPLAY "------------------------"
           END-READ.
           DISPLAY " ".

       *> ===============================
       *> ALTERAR CONTATO
       *> ===============================
       ALTERAR-CONTATO.
           DISPLAY "Digite o codigo do contato a alterar: "
           ACCEPT WS-COD-PESQUISA.
           MOVE WS-COD-PESQUISA TO CONTATO-COD.
           READ CONTATOS KEY IS CONTATO-COD
               INVALID KEY
                   DISPLAY "Erro: Contato nao encontrado!"
               NOT INVALID KEY
                   DISPLAY "Digite o novo nome: "
                   ACCEPT CONTATO-NOME
                   DISPLAY "Digite o novo telefone: "
                   ACCEPT CONTATO-TELEFONE
                   DISPLAY "Digite o novo email: "
                   ACCEPT CONTATO-EMAIL
                   REWRITE REG-CONTATO
                       INVALID KEY DISPLAY "Erro ao alterar o contato!"
                       NOT INVALID KEY DISPLAY "Contato alterado com sucesso!"
                   END-REWRITE
           END-READ.
           DISPLAY " ".

       *> ===============================
       *> EXCLUIR CONTATO
       *> ===============================
       EXCLUIR-CONTATO.
           DISPLAY "Digite o codigo do contato a excluir: "
           ACCEPT WS-COD-PESQUISA.
           MOVE WS-COD-PESQUISA TO CONTATO-COD.
           DELETE CONTATOS RECORD
               INVALID KEY
                   DISPLAY "Erro: Contato nao encontrado!"
               NOT INVALID KEY
                   DISPLAY "Contato excluido com sucesso!"
           END-DELETE.
           DISPLAY " ".
