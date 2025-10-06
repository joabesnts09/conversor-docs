# Opções de Inicialização do Conversor

Este projeto oferece **3 opções** para iniciar a aplicação. Escolha a que melhor se adapta às suas necessidades.

---

## 📁 Estrutura

```
conversor/
├── scripts-windows/          # Scripts de instalação
│   ├── install.bat           # Instalação básica
│   ├── install-completo.bat  # Instalação completa (Python + Node.js)
│   ├── install-simples.bat   # Instalação guiada
│   └── verificar-arquivos.bat
│
├── start-opcao1/             # Opção 1: Tudo em 1 terminal
│   ├── start.bat
│   └── README.md
│
├── start-opcao3/             # Opção 3: Background (sem janelas)
│   ├── start.bat
│   ├── stop.bat
│   ├── status.bat
│   └── README.md
│
└── start.bat                 # Opção padrão (3 janelas)
```

---

## 🚀 Comparação das Opções

| Característica | Opção Padrão | Opção 1 | Opção 3 |
|----------------|--------------|---------|---------|
| **Janelas abertas** | 3 (Backend + Frontend + Navegador) | 1 (Tudo junto) | 0 (Background) |
| **Logs visíveis** | ✅ Sim | ✅ Sim | ❌ Não |
| **Fácil de usar** | ✅ Sim | ✅✅ Muito | ✅ Sim |
| **Fácil de parar** | ✅ Fechar janelas | ✅ Ctrl+C | ❌ Precisa de `stop.bat` |
| **Debug** | ✅ Fácil | ✅ Fácil | ❌ Difícil |
| **Interface limpa** | ❌ 3 janelas | ✅ 1 janela | ✅✅ Nenhuma janela |

---

## 📋 Detalhes de Cada Opção

### **Opção Padrão** (Pasta raiz)
```cmd
start.bat
```

**Como funciona:**
- Abre **3 janelas**:
  1. Terminal do Backend (Flask)
  2. Terminal do Frontend (Vite)
  3. Navegador (http://localhost:5173)

**Quando usar:**
- Você quer separar os logs do backend e frontend
- Precisa debugar problemas específicos
- Prefere ter controle total sobre cada processo

---

### **Opção 1** (Pasta `start-opcao1/`)
```cmd
cd start-opcao1
start.bat
```

**Como funciona:**
- Abre **1 janela** apenas
- Backend e frontend no mesmo terminal
- Logs misturados mas organizados
- `Ctrl+C` para parar tudo

**Quando usar:** ⭐ **RECOMENDADO**
- Você quer simplicidade
- Prefere uma interface limpa
- Quer ver todos os logs em um lugar
- Usa a aplicação regularmente

---

### **Opção 3** (Pasta `start-opcao3/`)
```cmd
cd start-opcao3
start.bat
```

**Como funciona:**
- **Nenhuma janela** visível
- Processos rodam em segundo plano
- Apenas o navegador abre

**Scripts disponíveis:**
- `start.bat` - Inicia
- `stop.bat` - Para
- `status.bat` - Verifica status

**Quando usar:**
- Você não precisa ver os logs
- Quer uma interface super limpa
- Já conhece a aplicação e não precisa debugar

**⚠️ Atenção:**
- Se algo der errado, você **não saberá** o que aconteceu
- Precisa executar `stop.bat` para encerrar
- Se esquecer de parar, fica rodando em background

---

## 🎯 Qual escolher?

### Para iniciantes:
**Opção 1** (Tudo em 1 terminal)
- Simples, limpo, e você vê tudo

### Para desenvolvedores:
**Opção Padrão** (3 janelas)
- Controle total e debug fácil

### Para apresentações/demos:
**Opção 3** (Background)
- Interface super limpa, sem janelas

---

## 📖 Instalação

Antes de usar qualquer opção, instale as dependências:

```cmd
cd scripts-windows
install-completo.bat
```

Ou, se já tem Python e Node.js:

```cmd
cd scripts-windows
install.bat
```

---

## 🆘 Problemas?

1. **Aplicação não inicia:**
   - Verifique se instalou as dependências
   - Execute `scripts-windows/verificar-arquivos.bat`

2. **Não consigo parar a aplicação:**
   - Use `start-opcao3/stop.bat`
   - Ou feche todas as janelas do terminal

3. **Erro desconhecido:**
   - Use a **Opção 1** para ver os logs
   - Verifique se as portas 5000 e 5173 estão livres

---

## 📝 Resumo Rápido

```cmd
# Instalação (uma vez)
cd scripts-windows
install-completo.bat

# Opção 1 (Recomendado)
cd start-opcao1
start.bat

# Opção 3 (Background)
cd start-opcao3
start.bat
# Para parar:
stop.bat

# Opção Padrão
start.bat
```

---

**Criado para facilitar o uso do Conversor PDF to XLSM** 🚀

