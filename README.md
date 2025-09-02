
# Meus Projetos em COBOL

Este repositório contém meus primeiros projetos desenvolvidos na linguagem de programação COBOL. O objetivo é aplicar os conceitos aprendidos e criar sistemas funcionais, desde um simples "Olá, Mundo\!" até um sistema de gerenciamento de banco de dados.

## Projetos

Aqui estão os projetos que você encontrará neste repositório:

1.  **Hello World**: Um programa introdutório que exibe uma mensagem de saudação.
2.  **Sistema Simples de Cadastro**: Um sistema básico para cadastrar e listar clientes.
3.  **Sistema Bancário Simples**: Um sistema para gerenciamento de contas bancárias, com funcionalidades de depósito, saque e exclusão de contas.
4.  **Sistema de Clientes e Pedidos**: Um sistema mais completo para gerenciar clientes e seus respectivos pedidos.

## Como Compilar e Executar

Para compilar os programas em COBOL, você precisará de um compilador. As instruções abaixo utilizam o **GnuCOBOL (anteriormente OpenCOBOL)**, que é um compilador de COBOL de código aberto e gratuito.

### Instalação do GnuCOBOL (Linux - Ubuntu/Debian)

```bash
sudo apt-get update
sudo apt-get install open-cobol
```

### Compilando os fontes

Para compilar um arquivo `.cob` ou `.CBL`, utilize o seguinte comando no terminal:

```bash
cobc -x -free <nome-do-arquivo>.cob
```

  * `cobc`: O comando para chamar o compilador GnuCOBOL.
  * `-x`: Cria um arquivo executável.
  * `-free`: Indica que o código-fonte está em formato livre.

### Executando os programas

Após a compilação, um arquivo executável será criado no mesmo diretório. Para executá-lo, use o comando:

```bash
./<nome-do-arquivo>
```

-----

## Detalhes dos Projetos

### 1\. Hello World

  * **Descrição**: O clássico programa "Olá, Mundo\!" para demonstrar a estrutura básica de um programa COBOL.
  * **Arquivo Fonte**: `Hello World/OLA.CBL`
  * **Para compilar**:
    ```bash
    cobc -x -free "Hello World/OLA.CBL"
    ```
  * **Para executar**:
    ```bash
    ./OLA
    ```

### 2\. Sistema Simples de Cadastro

  * **Descrição**: Um programa de console para gerenciar um cadastro de clientes, que são salvos em um arquivo `CLIENTES.DAT`.
  * **Arquivo Fonte**: `Sistema Simples/cria-banco.cob`
  * **Funcionalidades**:
      * Inserir um novo cliente.
      * Listar todos os clientes cadastrados.
  * **Para compilar**:
    ```bash
    cobc -x -free "Sistema Simples/cria-banco.cob"
    ```
  * **Para executar**:
    ```bash
    ./cria-banco
    ```

### 3\. Sistema Bancário Simples

  * **Descrição**: Um sistema de gerenciamento de contas bancárias. As informações são armazenadas no arquivo `contas.dat`.
  * **Arquivo Fonte**: `Sistema Bancario Simples/banco.cob`
  * **Funcionalidades**:
      * Criar uma nova conta.
      * Listar todas as contas.
      * Realizar depósitos.
      * Realizar saques.
      * Excluir uma conta.
  * **Para compilar**:
    ```bash
    cobc -x -free "Sistema Bancario Simples/banco.cob"
    ```
  * **Para executar**:
    ```bash
    ./banco
    ```

### 4\. Sistema de Clientes e Pedidos

  * **Descrição**: Um sistema mais robusto que gerencia clientes e pedidos de forma separada, mas interligada. Utiliza os arquivos `CLIENTES.DAT` e `PEDIDOS.DAT`.
  * **Arquivo Fonte**: `Sistema/banco.cob`
  * **Funcionalidades**:
      * Inserir, atualizar, listar e deletar clientes.
      * Inserir, atualizar, listar e deletar pedidos, associando-os a um cliente.
  * **Para compilar**:
    ```bash
    cobc -x -free "Sistema/banco.cob"
    ```
  * **Para executar**:
    ```bash
    ./banco
    ```

