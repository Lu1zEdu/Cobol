       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULADORA.
       AUTHOR. Luiz.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NUM1        PIC 9(5)V99.
       01 WS-NUM2        PIC 9(5)V99.
       01 WS-RESULTADO   PIC 9(10)V99.
       01 WS-OPCAO       PIC 9.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

           PERFORM UNTIL WS-OPCAO = 5

               DISPLAY "=============================="
               DISPLAY "      CALCULADORA COBOL"
               DISPLAY "=============================="
               DISPLAY "1 - Somar"
               DISPLAY "2 - Subtrair"
               DISPLAY "3 - Multiplicar"
               DISPLAY "4 - Dividir"
               DISPLAY "5 - Sair"
               DISPLAY "=============================="
               DISPLAY "Escolha uma opcao: "
               ACCEPT WS-OPCAO

               EVALUATE WS-OPCAO
                   WHEN 1
                       PERFORM SOMAR
                   WHEN 2
                       PERFORM SUBTRAIR
                   WHEN 3
                       PERFORM MULTIPLICAR
                   WHEN 4
                       PERFORM DIVIDIR
                   WHEN 5
                       DISPLAY "Encerrando a calculadora."
                   WHEN OTHER
                       DISPLAY "Opcao invalida!"
               END-EVALUATE

           END-PERFORM.

           STOP RUN.

       *> Paragrafo para pedir os numeros
       PEDIR-NUMEROS.
           DISPLAY "Digite o primeiro numero: "
           ACCEPT WS-NUM1
           DISPLAY "Digite o segundo numero: "
           ACCEPT WS-NUM2
           .

       *> Operacao SOMA
       SOMAR.
           PERFORM PEDIR-NUMEROS
           ADD WS-NUM1 TO WS-NUM2 GIVING WS-RESULTADO
           DISPLAY "Resultado da Soma: " WS-RESULTADO
           DISPLAY " "
           .

       *> Operacao SUBTRACAO
       SUBTRAIR.
           PERFORM PEDIR-NUMEROS
           SUBTRACT WS-NUM2 FROM WS-NUM1 GIVING WS-RESULTADO
           DISPLAY "Resultado da Subtracao: " WS-RESULTADO
           DISPLAY " "
           .

       *> Operacao MULTIPLICACAO
       MULTIPLICAR.
           PERFORM PEDIR-NUMEROS
           MULTIPLY WS-NUM1 BY WS-NUM2 GIVING WS-RESULTADO
           DISPLAY "Resultado da Multiplicacao: " WS-RESULTADO
           DISPLAY " "
           .

       *> Operacao DIVISAO
       DIVIDIR.
           PERFORM PEDIR-NUMEROS
           IF WS-NUM2 = 0
               DISPLAY "Erro: Divisao por zero nao e permitida."
           ELSE
               DIVIDE WS-NUM1 BY WS-NUM2 GIVING WS-RESULTADO
               DISPLAY "Resultado da Divisao: " WS-RESULTADO
           END-IF
           DISPLAY " "
           .

       END PROGRAM CALCULADORA.
