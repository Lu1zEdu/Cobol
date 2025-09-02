       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANCO-SIMPLES.
       AUTHOR. Luiz.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CONTAS ASSIGN TO "contas.dat"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS CONTA-NUMERO
               FILE STATUS IS FS.

       DATA DIVISION.
       FILE SECTION.
       FD CONTAS.
       01 REG-CONTA.
           05 CONTA-NUMERO     PIC 9(6).
           05 CONTA-NOME       PIC X(30).
           05 CONTA-SALDO      PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       77 FS                PIC XX.
       77 OPCAO             PIC 9.
       77 VALOR             PIC 9(7)V99.
       77 WS-LINHA          PIC X(80).
       77 WS-CONTA-INICIO   PIC 9(6) VALUE 000001. *> para o START

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN I-O CONTAS
           IF FS = "35"
              OPEN OUTPUT CONTAS
              CLOSE CONTAS
              OPEN I-O CONTAS
           END-IF

           PERFORM UNTIL OPCAO = 9
              DISPLAY "============================"
              DISPLAY "   SISTEMA BANCARIO COBOL"
              DISPLAY "1 - Criar conta"
              DISPLAY "2 - Listar contas"
              DISPLAY "3 - Depositar"
              DISPLAY "4 - Sacar"
              DISPLAY "5 - Excluir conta"
              DISPLAY "9 - Sair"
              DISPLAY "============================"
              ACCEPT OPCAO

              EVALUATE OPCAO
                 WHEN 1 PERFORM CRIAR-CONTA
                 WHEN 2 PERFORM LISTAR-CONTAS
                 WHEN 3 PERFORM DEPOSITAR
                 WHEN 4 PERFORM SACAR
                 WHEN 5 PERFORM EXCLUIR-CONTA
                 WHEN 9 DISPLAY "Encerrando sistema..."
                 WHEN OTHER DISPLAY "Opcao invalida!"
              END-EVALUATE
           END-PERFORM

           CLOSE CONTAS
           STOP RUN.

       *> ===============================
       *> CRIAR CONTA
       *> ===============================
       CRIAR-CONTA.
           DISPLAY "Numero da conta (6 digitos): "
           ACCEPT CONTA-NUMERO
           DISPLAY "Nome do titular: "
           ACCEPT CONTA-NOME
           MOVE 0 TO CONTA-SALDO
           WRITE REG-CONTA
              INVALID KEY DISPLAY "Conta ja existente!"
           END-WRITE
           .

       *> ===============================
       *> LISTAR CONTAS
       *> ===============================
       LISTAR-CONTAS.
           MOVE 000000 TO CONTA-NUMERO
           MOVE "00" TO FS
           START CONTAS KEY NOT LESS THAN CONTA-NUMERO
              INVALID KEY MOVE "99" TO FS
           END-START

           PERFORM UNTIL FS = "99"
              READ CONTAS NEXT RECORD
                 AT END MOVE "99" TO FS
                 NOT AT END
                    DISPLAY "Conta: " CONTA-NUMERO
                    DISPLAY "Nome : " CONTA-NOME
                    DISPLAY "Saldo: " CONTA-SALDO
                    DISPLAY "---------------------------"
              END-READ
           END-PERFORM
           .


       *> ===============================
       *> DEPOSITAR
       *> ===============================
       DEPOSITAR.
           DISPLAY "Numero da conta: "
           ACCEPT CONTA-NUMERO
           READ CONTAS RECORD
              INVALID KEY DISPLAY "Conta nao encontrada!"
              NOT INVALID KEY
                 DISPLAY "Valor a depositar: "
                 ACCEPT VALOR
                 ADD VALOR TO CONTA-SALDO
                 REWRITE REG-CONTA
                 DISPLAY "Deposito realizado."
           END-READ
           .

       *> ===============================
       *> SACAR
       *> ===============================
       SACAR.
           DISPLAY "Numero da conta: "
           ACCEPT CONTA-NUMERO
           READ CONTAS RECORD
              INVALID KEY DISPLAY "Conta nao encontrada!"
              NOT INVALID KEY
                 DISPLAY "Valor a sacar: "
                 ACCEPT VALOR
                 IF VALOR > CONTA-SALDO
                    DISPLAY "Saldo insuficiente!"
                 ELSE
                    SUBTRACT VALOR FROM CONTA-SALDO
                    REWRITE REG-CONTA
                    DISPLAY "Saque realizado."
                 END-IF
           END-READ
           .

       *> ===============================
       *> EXCLUIR CONTA
       *> ===============================
       EXCLUIR-CONTA.
           DISPLAY "Numero da conta: "
           ACCEPT CONTA-NUMERO
           DELETE CONTAS RECORD
              INVALID KEY DISPLAY "Conta nao encontrada!"
              NOT INVALID KEY DISPLAY "Conta excluida."
           END-DELETE
           .

       END PROGRAM BANCO-SIMPLES.
