# 🛠️ Otimizador Windows 10 e 11

Script em `.bat` para manutenção, limpeza e otimização do Windows 10 e Windows 11, desenvolvido para facilitar tarefas administrativas e ajudar na manutenção preventiva do sistema operacional.

O projeto utiliza ferramentas nativas do Windows e oferece um menu interativo para executar operações individualmente, permitindo que o usuário escolha quais procedimentos deseja realizar.

## 📋 Funcionalidades

- 🧹 **Limpeza de arquivos temporários:** remove arquivos temporários do usuário e do Windows, ignorando arquivos que estejam em uso ou não possam ser excluídos.
- 🌐 **Limpeza do cache DNS:** executa o comando `ipconfig /flushdns`.
- 🔍 **Verificação de arquivos do sistema:** executa o Verificador de Arquivos do Sistema (`sfc /scannow`).
- 🔧 **Reparo da imagem do Windows:** utiliza o DISM para verificar e reparar componentes do sistema.
- 💽 **Limpeza de Disco:** abre a ferramenta nativa `cleanmgr.exe`.
- 🚀 **Aplicativos de inicialização:** abre as configurações para gerenciar os programas iniciados com o Windows.
- ⚙️ **Desempenho visual:** abre as configurações de efeitos visuais do sistema.
- 📦 **Desinstalação seletiva de aplicativos:** permite tentar remover aplicativos opcionais, como Clipchamp, Teams pessoal, Copilot, Notícias, Clima e outros.
- 🎮 **Remoção seletiva de componentes Xbox:** oferece a remoção de determinados pacotes relacionados ao Xbox.
- 🖥️ **Informações do sistema:** exibe informações básicas sobre o Windows, memória RAM e armazenamento.
- 💾 **Configurações de armazenamento:** abre as opções de gerenciamento de espaço em disco.
- 🔄 **Windows Update:** abre as configurações de atualização do sistema.
- 📝 **Registro de operações:** cria o arquivo `Otimizacao_Windows.log` para registrar as principais ações executadas.

## 💻 Sistemas compatíveis

- Windows 10
- Windows 11

**Requisitos:**
- Permissões de administrador para executar o script.
- Windows PowerShell disponível, conforme as operações utilizadas.
- Ferramentas nativas do Windows necessárias para cada funcionalidade.
- Conexão com a internet para operações de reparo que dependam do Windows Update.

A disponibilidade de aplicativos e recursos pode variar conforme a edição, a versão e a configuração do Windows.

## 📥 Como baixar e executar

### 1. Baixe o projeto

Na página do repositório GitHub, clique em **Code → Download ZIP** e extraia os arquivos para uma pasta de sua preferência.

### 2. Execute o script

Localize o arquivo:

`Otimizador_Windows_10_11.bat`

Clique com o botão direito e selecione **Executar como administrador**. O script também tenta solicitar a elevação de privilégios automaticamente.

### 3. Escolha uma operação

Utilize o menu apresentado no terminal para selecionar a tarefa desejada.

| Opção | Função |
|---|---|
| 1 | Limpar temporários do usuário |
| 2 | Limpar temporários do Windows |
| 3 | Limpar cache DNS |
| 4 | Verificar arquivos do sistema |
| 5 | Reparar a imagem do Windows |
| 6 | Abrir Limpeza de Disco |
| 7 | Gerenciar aplicativos de inicialização |
| 8 | Configurar efeitos visuais |
| 9 | Gerenciar aplicativos opcionais |
| 10 | Exibir informações do sistema |
| 11 | Abrir configurações de armazenamento |
| 12 | Abrir Windows Update |
| L | Abrir o arquivo de log |
| 0 | Encerrar o programa |

## ⚠️ Avisos importantes

- Execute o script por sua conta e risco, preferencialmente após criar um ponto de restauração e manter um backup dos arquivos importantes.
- Leia as mensagens exibidas antes de confirmar qualquer operação.
- A limpeza de arquivos temporários pode liberar espaço, mas não garante aumento perceptível de desempenho em todos os computadores.
- As verificações SFC e DISM podem demorar vários minutos.
- A desinstalação de aplicativos pode remover funcionalidades utilizadas pelo usuário. A remoção de componentes Xbox, por exemplo, pode afetar a Game Bar e recursos associados.
- O script remove pacotes de aplicativos do usuário atual e não remove o provisionamento desses pacotes para novos usuários.
- O funcionamento depende da versão do Windows, das permissões disponíveis e dos pacotes instalados.
- Este projeto não desativa indiscriminadamente serviços essenciais, o Windows Defender ou o Windows Update.
- Não existe garantia de compatibilidade com todas as versões futuras do Windows.

**Recomendação:** revise o código-fonte antes de executá-lo, principalmente em computadores corporativos ou equipamentos que contenham dados importantes.

## 📂 Estrutura do projeto

```text
Otimizador-Windows/
├── Otimizador_Windows_10_11.bat
├── Otimizacao_Windows.log
└── README.md
```

O arquivo de log é criado durante a execução. Portanto, ele pode não existir na primeira vez que o programa for iniciado.

## 🎯 Objetivo do projeto

Disponibilizar uma ferramenta simples, gratuita e interativa para auxiliar usuários domésticos, técnicos de informática e profissionais de suporte na manutenção preventiva de computadores com Windows 10 e Windows 11.

## 🤝 Contribuições

Sugestões, correções e melhorias são bem-vindas.

1. Faça um fork deste repositório.
2. Crie uma branch para sua alteração.
3. Implemente e teste as modificações.
4. Envie um pull request descrevendo as melhorias realizadas.

## 📄 Licença

Este projeto ainda não possui uma licença de distribuição definida. Antes de permitir a reutilização, modificação ou redistribuição por terceiros, adicione um arquivo `LICENSE` com os termos escolhidos.

## 👨‍💻 Autor

**Fabrício Azor**

- Website: https://www.azorweb.com.br
- GitHub: https://github.com/

---

⭐ Se este projeto foi útil para você, considere deixar uma estrela no repositório e compartilhar sugestões para futuras melhorias.
