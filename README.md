# Para Minha Mulher - App Interativo

Este é um aplicativo Flutter interativo criado como uma brincadeira romântica.

## Pré-requisitos

Para executar este projeto, você precisa ter o Flutter instalado no seu computador.

### Instalando o Flutter no Windows

1. **Baixe o Flutter:**
   - Acesse: https://docs.flutter.dev/get-started/install/windows
   - Baixe o arquivo ZIP do Flutter para Windows
   - Extraia o arquivo para uma pasta (ex: `C:\flutter`)

2. **Configure as variáveis de ambiente:**
   - Abra as Configurações do Sistema
   - Vá para Variáveis de Ambiente
   - Adicione `C:\flutter\bin` ao PATH

3. **Verifique a instalação:**
   ```bash
   flutter doctor
   ```

4. **Instale o Android Studio (para desenvolvimento Android):**
   - Baixe em: https://developer.android.com/studio
   - Instale e configure o Android SDK

## Executando o Projeto

1. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

2. **Execute o aplicativo:**
   ```bash
   flutter run
   ```

## Sobre o App

Este aplicativo é um questionário interativo com várias telas:
- Tela inicial com validação de nome e idade
- Tela de autoavaliação
- Tela final com botão "Não" que se move
- Tela de confirmação do encontro

O app é uma brincadeira romântica que valida informações específicas e termina com um convite para sair. 