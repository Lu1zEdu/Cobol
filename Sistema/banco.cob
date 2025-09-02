       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANCO-COBOL.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CLIENTES ASSIGN TO "CLIENTES.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS CLI-COD
               FILE STATUS IS WS-FS-C.

           SELECT PEDIDOS ASSIGN TO "PEDIDOS.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS PED-COD
               FILE STATUS IS WS-FS-P.

       DATA DIVISION.
       FILE SECTION.
       FD  CLIENTES.
       01  REG-CLIENTE.
           05 CLI-COD      PIC 9(05).
           05 CLI-NOME     PIC X(30).
           05 CLI-EMAIL    PIC X(40).

       FD  PEDIDOS.
       01  REG-PEDIDO.
           05 PED-COD      PIC 9(05).
           05 CLI-COD-P    PIC 9(05).
           05 PED-DATA     PIC X(10).
           05 PED-VALOR    PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01 WS-FS-C         PIC XX.
       01 WS-FS-P         PIC XX.
       01 WS-OPCAO        PIC 9.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN I-O CLIENTES
           IF WS-FS-C NOT = "00"
              OPEN OUTPUT CLIENTES
              CLOSE CLIENTES
              OPEN I-O CLIENTES
           END-IF

           OPEN I-O PEDIDOS
           IF WS-FS-P NOT = "00"
              OPEN OUTPUT PEDIDOS
              CLOSE PEDIDOS
              OPEN I-O PEDIDOS
           END-IF

           PERFORM UNTIL WS-OPCAO = 9
              DISPLAY "=============================="
              DISPLAY " BANCO DE DADOS COBOL "
              DISPLAY "1 - Inserir Cliente"
              DISPLAY "2 - Inserir Pedido"
              DISPLAY "3 - Listar Clientes"
              DISPLAY "4 - Listar Pedidos (com Cliente)"
              DISPLAY "5 - Atualizar Cliente"
              DISPLAY "6 - Atualizar Pedido"
              DISPLAY "7 - Deletar Cliente"
              DISPLAY "8 - Deletar Pedido"
              DISPLAY "9 - Sair"
              DISPLAY "=============================="
              ACCEPT WS-OPCAO

              EVALUATE WS-OPCAO
                 WHEN 1 PERFORM INSERIR-CLIENTE
                 WHEN 2 PERFORM INSERIR-PEDIDO
                 WHEN 3 PERFORM LISTAR-CLIENTES
                 WHEN 4 PERFORM LISTAR-PEDIDOS
                 WHEN 5 PERFORM UPDATE-CLIENTE
                 WHEN 6 PERFORM UPDATE-PEDIDO
                 WHEN 7 PERFORM DELETE-CLIENTE
                 WHEN 8 PERFORM DELETE-PEDIDO
                 WHEN 9 CONTINUE
                 WHEN OTHER DISPLAY "Opcao invalida!"
              END-EVALUATE
           END-PERFORM.

           CLOSE CLIENTES
           CLOSE PEDIDOS
           STOP RUN.

       *> -------------------------
       *> INSERIR CLIENTE
       *> -------------------------
       INSERIR-CLIENTE.
           DISPLAY "Codigo Cliente (5 digitos): "
           ACCEPT CLI-COD
           DISPLAY "Nome do Cliente: "
           ACCEPT CLI-NOME
           DISPLAY "Email do Cliente: "
           ACCEPT CLI-EMAIL

           WRITE REG-CLIENTE
              INVALID KEY DISPLAY "Erro: Codigo duplicado!"
           END-WRITE
           .

       *> -------------------------
       *> INSERIR PEDIDO
       *> -------------------------
       INSERIR-PEDIDO.
           DISPLAY "Codigo do Pedido (5 digitos): "
           ACCEPT PED-COD
           DISPLAY "Codigo do Cliente: "
           ACCEPT CLI-COD-P

           MOVE CLI-COD-P TO CLI-COD
           READ CLIENTES KEY IS CLI-COD
              INVALID KEY
                 DISPLAY "Erro: Cliente nao encontrado!"
                 EXIT PARAGRAPH
           END-READ

           DISPLAY "Data do Pedido (DD/MM/AAAA): "
           ACCEPT PED-DATA
           DISPLAY "Valor do Pedido: "
           ACCEPT PED-VALOR

           WRITE REG-PEDIDO
              INVALID KEY DISPLAY "Erro: Codigo de pedido duplicado!"
           END-WRITE
           .

       *> -------------------------
       *> LISTAR CLIENTES
       *> -------------------------
       LISTAR-CLIENTES.
           CLOSE CLIENTES
           OPEN INPUT CLIENTES

           MOVE "00" TO WS-FS-C
           PERFORM UNTIL WS-FS-C NOT = "00"
              READ CLIENTES NEXT RECORD
                 AT END MOVE "99" TO WS-FS-C
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

       *> -------------------------
       *> LISTAR PEDIDOS
       *> -------------------------
       LISTAR-PEDIDOS.
           CLOSE PEDIDOS
           OPEN INPUT PEDIDOS

           MOVE "00" TO WS-FS-P
           PERFORM UNTIL WS-FS-P NOT = "00"
              READ PEDIDOS NEXT RECORD
                 AT END MOVE "99" TO WS-FS-P
                 NOT AT END
                    MOVE CLI-COD-P TO CLI-COD
                    READ CLIENTES KEY IS CLI-COD
                       INVALID KEY
                          DISPLAY "Pedido sem cliente valido!"
                       NOT INVALID KEY
                          DISPLAY "Pedido: " PED-COD
                          DISPLAY " Cliente: " CLI-NOME " (" CLI-COD ")"
                          DISPLAY " Data: " PED-DATA
                          DISPLAY " Valor: R$" PED-VALOR
                          DISPLAY "-------------------------"
                    END-READ
              END-READ
           END-PERFORM

           CLOSE PEDIDOS
           OPEN I-O PEDIDOS
           .

       *> -------------------------
       *> UPDATE CLIENTE
       *> -------------------------
       UPDATE-CLIENTE.
           DISPLAY "Codigo do Cliente para atualizar: "
           ACCEPT CLI-COD

           READ CLIENTES KEY IS CLI-COD
              INVALID KEY
                 DISPLAY "Cliente nao encontrado!"
                 EXIT PARAGRAPH
           END-READ

           DISPLAY "Novo Nome: "
           ACCEPT CLI-NOME
           DISPLAY "Novo Email: "
           ACCEPT CLI-EMAIL

           REWRITE REG-CLIENTE
              INVALID KEY DISPLAY "Erro ao atualizar!"
           END-REWRITE
           .

       *> -------------------------
       *> UPDATE PEDIDO
       *> -------------------------
       UPDATE-PEDIDO.
           DISPLAY "Codigo do Pedido para atualizar: "
           ACCEPT PED-COD

           READ PEDIDOS KEY IS PED-COD
              INVALID KEY
                 DISPLAY "Pedido nao encontrado!"
                 EXIT PARAGRAPH
           END-READ

           DISPLAY "Nova Data (DD/MM/AAAA): "
           ACCEPT PED-DATA
           DISPLAY "Novo Valor: "
           ACCEPT PED-VALOR

           REWRITE REG-PEDIDO
              INVALID KEY DISPLAY "Erro ao atualizar!"
           END-REWRITE
           .

       *> -------------------------
       *> DELETE CLIENTE
       *> -------------------------
       DELETE-CLIENTE.
           DISPLAY "Codigo do Cliente para deletar: "
           ACCEPT CLI-COD

           READ CLIENTES KEY IS CLI-COD
              INVALID KEY
                 DISPLAY "Cliente nao encontrado!"
                 EXIT PARAGRAPH
           END-READ

           DELETE CLIENTES
              INVALID KEY DISPLAY "Erro ao deletar cliente!"
           END-DELETE
           .

       *> -------------------------
       *> DELETE PEDIDO
       *> -------------------------
       DELETE-PEDIDO.
           DISPLAY "Codigo do Pedido para deletar: "
           ACCEPT PED-COD

           READ PEDIDOS KEY IS PED-COD
              INVALID KEY
                 DISPLAY "Pedido nao encontrado!"
                 EXIT PARAGRAPH
           END-READ

           DELETE PEDIDOS
              INVALID KEY DISPLAY "Erro ao deletar pedido!"
           END-DELETE
           .
         END PROGRAM BANCO-COBOL.