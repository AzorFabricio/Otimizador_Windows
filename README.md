# 🛠️ Otimizador Seguro — Windows 10 e Windows 11

Script de manutenção e otimização para Windows 10 e Windows 11, desenvolvido em **Batch (.bat)**, com menu interativo para facilitar a limpeza de arquivos temporários, a manutenção do sistema e a execução de ferramentas nativas de diagnóstico e reparo do Windows.

O objetivo é oferecer uma ferramenta simples, prática e segura, sem desativar o Windows Update, o Microsoft Defender, o Firewall ou serviços essenciais do sistema operacional.

## 📌 Funcionalidades

- 🧹 **Limpeza de arquivos temporários do usuário:** remove arquivos temporários que podem ser excluídos.
- 🗑️ **Limpeza de arquivos temporários do Windows:** tenta remover arquivos temporários do sistema.
- 🌐 **Limpeza do cache DNS:** utiliza `ipconfig /flushdns`.
- 🔍 **Verificação e reparo de arquivos do sistema:** executa `sfc /scannow`.
- 🔧 **Reparo da imagem do Windows:** executa `DISM /Online /Cleanup-Image /RestoreHealth`.
- ⚡ **Limpeza completa:** combina a limpeza dos arquivos temporários, a limpeza do cache DNS e a verificação SFC.
- 💽 **Limpeza de Disco:** abre o utilitário nativo `cleanmgr`, quando disponível.
- 💻 **Informações do sistema:** exibe dados básicos sobre o computador, o usuário e a versão do Windows.
- 📝 **Registro de atividades:** grava operações e resultados selecionados em um arquivo de log.
- 🔐 **Elevação administrativa:** solicita permissão de Administrador para executar as tarefas.

## 🖥️ Compatibilidade

- Windows 10
- Windows 11
- Arquiteturas x64 e x86, conforme a disponibilidade das ferramentas nativas do sistema.

**Requisitos:**
- Permissão de Administrador.
- Prompt de Comando e Windows PowerShell disponíveis.
- Conexão com a internet pode ser necessária para determinadas operações do DISM.

## 📥 Como baixar

1. Acesse o repositório deste projeto no GitHub.
2. Clique no botão **Code**.
3. Selecione **Download ZIP** ou clone o repositório utilizando o Git.

Para clonar o repositório pelo terminal:

```bash
git clone URL_DO_SEU_REPOSITORIO
```

Substitua `URL_DO_SEU_REPOSITORIO` pelo endereço real do repositório.

## ▶️ Como executar

1. Baixe o arquivo `Otimizador_Windows_10_11.bat`.
2. Salve-o em uma pasta de sua preferência.
3. Execute o arquivo `.bat`.
4. Autorize a solicitação de privilégios administrativos.
5. Escolha uma opção no menu e siga as instruções apresentadas.

**Recomendação:** feche os programas desnecessários antes de executar a limpeza. Se possível, salve seus trabalhos e crie um ponto de restauração antes de realizar operações de manutenção.

## 📋 Menu de opções

| Opção | Função |
|---|---|
| 1 | Limpar arquivos temporários do usuário |
| 2 | Limpar arquivos temporários do Windows |
| 3 | Limpar cache DNS |
| 4 | Verificar e reparar arquivos do sistema (SFC) |
| 5 | Reparar a imagem do Windows (DISM) |
| 6 | Executar limpeza completa |
| 7 | Abrir a Limpeza de Disco, se disponível |
| 8 | Mostrar informações básicas do sistema |
| 0 | Sair do programa |

## 📝 Arquivo de log

O programa registra atividades em:

`Otimizacao_Windows.log`

O arquivo é criado na mesma pasta do script e permite consultar registros de operações executadas.

## 🔒 Segurança e observações

- O script não desativa intencionalmente o Windows Update, o Microsoft Defender ou o Firewall.
- A limpeza de arquivos temporários pode ignorar arquivos que estejam em uso ou protegidos pelo sistema.
- O comando SFC verifica a integridade dos arquivos protegidos do Windows e pode tentar repará-los.
- O DISM verifica e tenta reparar a imagem do Windows.
- Os resultados dependem do estado do sistema, das permissões e da disponibilidade dos componentes necessários.
- A limpeza de arquivos temporários não garante aumento de desempenho; os benefícios dependem da situação do computador.
- A opção de limpeza completa executa o SFC, mas não inclui automaticamente o DISM.

**Importante:** revise o conteúdo do script antes de executá-lo e utilize-o por sua conta e risco. Recomenda-se manter backups dos arquivos importantes.

## 🧰 Tecnologias utilizadas

- Windows Batch Script (`.bat`)
- Windows Command Prompt (CMD)
- Windows PowerShell
- System File Checker (SFC)
- Deployment Image Servicing and Management (DISM)
- IPConfig
- System Information (`systeminfo`)

## 🎯 Objetivo do projeto

Disponibilizar uma ferramenta gratuita e de fácil utilização para auxiliar na manutenção preventiva do Windows, reunindo comandos nativos em um único menu.

## 🤝 Contribuições

Sugestões, melhorias e correções são bem-vindas!

1. Faça um fork do repositório.
2. Crie uma branch para sua alteração.
3. Realize as modificações e os testes.
4. Envie um Pull Request com a descrição das melhorias.

## 📄 Licença

Este projeto pode ser distribuído sob a licença MIT, desde que o repositório inclua o arquivo `LICENSE` correspondente.

## 👨‍💻 Autor

**Fabrício Azor**

Desenvolvedor e profissional de Tecnologia da Informação, com experiência em programação, manutenção de computadores, servidores Windows e Linux.

🌐 Portfólio: https://www.azorweb.com.br

---

⭐ Se este projeto foi útil para você, considere deixar uma estrela no repositório!
