# Todo List App

Um aplicativo simples de lista de tarefas que permite aos usuários criar, editar e excluir tarefas. Este projeto foi desenvolvido com o objetivo de facilitar o gerenciamento de tarefas do dia a dia.

## Funcionalidades

- **Criar tarefas:** Adicione novas tarefas com descrições personalizadas.
- **Editar tarefas:** Atualize as informações das tarefas existentes.
- **Excluir tarefas:** Remova tarefas que não são mais necessárias.

## Tecnologias Utilizadas

- **Flutter**: Framework principal utilizado para o desenvolvimento do aplicativo.
- **Dart**: Linguagem de programação utilizada.
- **Provider**: Gerenciamento de estado utilizado no aplicativo.
- **Arquitetura MVVM**: Padrão arquitetural implementado para organizar o código.

## Como Executar o Projeto

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/caiodantasmormito/challenge-todoList
   ```

2. **Navegue até o diretório do projeto**:
   ```bash
   cd challenge-todoList
   ```

3. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

4. **Execute o aplicativo**:
   ```bash
   flutter run
   ```

## Estrutura do Projeto

```plaintext
lib/
├── helper/                # Classes auxiliares
│   ├── http.dart          # Classe para chamadas HTTP
│   └── navigator.dart     # Classe para navegação
├── src/                   # Diretório principal do código
│   ├── model/             # Modelos de dados
│   │   └── todo_model.dart # Modelo representando uma tarefa
│   ├── view/              # Telas principais do aplicativo
│   │   ├── todo_create.dart # Tela para criar uma nova tarefa
│   │   ├── todo_edit.dart   # Tela para editar uma tarefa existente
│   │   └── todo_list.dart   # Tela com a lista de tarefas
│   └── viewmodel/         # Lógica de negócios e estado
│       └── todo_viewmodel.dart # ViewModel para gerenciar tarefas
└── main.dart              # Ponto de entrada do aplicativo
```

## Recursos Futuros

- **Sincronização na nuvem**: Possibilidade de sincronizar as tarefas com um serviço de nuvem.
- **Notificações**: Alertas para lembrar os usuários de suas tarefas.
- **Etiquetas e categorias**: Organização de tarefas em grupos.



---

