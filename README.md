# 📱 Flutter API Mock - Cadastro de Alunos

Este projeto Flutter consome uma API REST hospedada no [MockAPI](https://mockapi.io) para realizar operações de **leitura e inserção de dados** sobre alunos. É uma aplicação simples com interface gráfica que exibe uma lista de alunos e permite adicionar novos registros.

## 🚀 Funcionalidades

- 🔄 Consome dados da API com método GET
- ➕ Insere novos registros com método POST
- 🧾 Exibe os dados em uma lista com nome, cidade e país
- 📲 Interface amigável feita com Flutter

## 🛠️ Tecnologias Utilizadas

- [Flutter](https://flutter.dev/) (Framework)
- [Dart](https://dart.dev/) (Linguagem)
- [HTTP package](https://pub.dev/packages/http) (Requisições REST)
- [MockAPI](https://mockapi.io) (Back-end fake para testes)

## 🧩 Como funciona

1. **Tela inicial** exibe a lista de alunos obtida da API.
2. Ao clicar em **"Inserir Registro"**, o app navega para outra tela com um formulário.
3. Ao preencher os campos (nome, cidade, país) e clicar em "Salvar", o novo aluno é enviado à API e adicionado à lista.

## 🔗 URL da API

> https://67f059fb2a80b06b8897a135.mockapi.io/api/cadastro/aluno

