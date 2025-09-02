       IDENTIFICATION DIVISION.
       PROGRAM-ID. CRIA-BANCO.
       AUTHOR. Luiz.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CLIENTES ASSIGN TO "CLIENTES.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS CLI-COD
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD  CLIENTES.
       01  REG-CLIENTE.
           05 CLI-COD      PIC 9(05).
           05 CLI-NOME     PIC X(30).
           05 CLI-EMAIL    PIC X(40).

       WORKING-STORAGE SECTION.
       01 WS-FS           PIC XX.
       01 WS-OPCAO        PIC 9.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN I-O CLIENTES
           IF WS-FS NOT = "00"
              OPEN OUTPUT CLIENTES
              CLOSE CLIENTES
              OPEN I-O CLIENTES
           END-IF

           PERFORM UNTIL WS-OPCAO = 9
              DISPLAY "=============================="
              DISPLAY " BANCO DE DADOS DE CLIENTES "
              DISPLAY "1 - Inserir Cliente"
              DISPLAY "2 - Listar Clientes"
              DISPLAY "9 - Sair"
              DISPLAY "=============================="
              ACCEPT WS-OPCAO

              EVALUATE WS-OPCAO
                 WHEN 1 PERFORM INSERIR-CLIENTE
                 WHEN 2 PERFORM LISTAR-CLIENTES
                 WHEN 9 CONTINUE
                 WHEN OTHER DISPLAY "Opcao invalida!"
              END-EVALUATE
           END-PERFORM.

           CLOSE CLIENTES
           STOP RUN.

       INSERIR-CLIENTE.
           DISPLAY "Codigo do Cliente (5 digitos): "
           ACCEPT CLI-COD
           DISPLAY "Nome do Cliente: "
           ACCEPT CLI-NOME
           DISPLAY "Email do Cliente: "
           ACCEPT CLI-EMAIL

           WRITE REG-CLIENTE
              INVALID KEY DISPLAY "Erro: Codigo duplicado!"
           END-WRITE
           .

       LISTAR-CLIENTES.
           CLOSE CLIENTES
           OPEN INPUT CLIENTES

           MOVE "00" TO WS-FS
           PERFORM UNTIL WS-FS NOT = "00"
              READ CLIENTES NEXT RECORD
                 AT END MOVE "99" TO WS-FS
                 NOT AT END
                    DISPLAY "Codigo: " CLI-COD
                    DISPLAY "Nome  : " CLI-NOME
                    DISPLAY "Email : " CLI-EMAIL
                    DISPLAY "-------------------------"
              END-READ
           END-PERFORM

           CLOSE CLIENTES
           OPEN I-O CLIENTES
           .
