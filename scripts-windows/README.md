# Conversor PDF to XLSM - Scripts Windows

## 📋 Pré-requisitos

**Para instalação completa:** Nenhum pré-requisito necessário!

**Para instalação manual:** Antes de usar os scripts, certifique-se de ter instalado:

1. **Python 3.12** - [Download aqui](https://python.org)
2. **Node.js (LTS)** - [Download aqui](https://nodejs.org)

## 🚀 Como usar

### 1. Verificação de Arquivos
Execute `verificar-arquivos.bat` para verificar se todos os arquivos necessários estão presentes.

### 2. Instalação

**Opção A - Instalação Completa (Recomendada):**
Execute `install-completo.bat` como administrador para baixar e instalar automaticamente Python, Node.js e todas as dependências.

**Opção B - Instalação Simples:**
Execute `install-simples.bat` como administrador para abrir os links de download e guiar na instalação manual.

**Opção C - Instalação Manual:**
Execute `install.bat` como administrador (requer Python e Node.js já instalados).

### 3. Execução
Execute `start.bat` para iniciar a aplicação. O navegador abrirá automaticamente.

### 4. Parada
Execute `stop.bat` para encerrar a aplicação.

### 5. Desinstalação
Execute `uninstall.bat` para remover a aplicação.

## 📁 Estrutura de arquivos

```
conversor-pdf/
├── install.bat          (instalação)
├── start.bat            (execução)
├── stop.bat             (parada)
├── uninstall.bat        (desinstalação)
├── app_vercel.py
├── pdf_to_xlsm_converter.py
├── requirements.txt
├── runtime.txt
├── vercel.json
├── .gitignore
├── venv/                (criado automaticamente)
└── frontend/
    ├── package.json
    ├── vite.config.js
    ├── index.html
    ├── src/
    │   ├── App.jsx
    │   ├── main.jsx
    │   └── index.css
    ├── public/
    │   └── icon-j.svg
    └── node_modules/    (criado automaticamente)
```

## 🔧 Troubleshooting

### Erro: Python não encontrado
- Instale Python 3.12 e marque "Add to PATH" durante a instalação
- Reinicie o terminal após a instalação

### Erro: Node.js não encontrado
- Instale Node.js LTS e marque "Add to PATH" durante a instalação
- Reinicie o terminal após a instalação

### Erro: Porta ocupada
- Feche outros programas que possam estar usando as portas 5000 ou 5173
- Reinicie o computador se necessário

### Erro: Permissões
- Execute os scripts como administrador
- Desative temporariamente o antivírus se necessário

## 📞 Suporte

Se encontrar problemas:
1. Verifique se Python e Node.js estão instalados corretamente
2. Execute os scripts como administrador
3. Verifique se as portas 5000 e 5173 estão livres
4. Reinicie o computador e tente novamente

## 🎯 URLs da aplicação

- **Backend**: http://localhost:5000
- **Frontend**: http://localhost:5173

## ⚡ Vantagens do uso local

- ✅ Mais rápido que o Vercel
- ✅ Sem timeouts
- ✅ Processamento completo
- ✅ Sem limitações de memória
- ✅ Controle total do ambiente
