# Opção 3: Background (Sem Janelas)

## Características

- ✅ **Nenhuma janela de terminal** visível
- ✅ Interface limpa e profissional
- ✅ Processos rodando em segundo plano
- ❌ **Não mostra logs** (dificulta debug)

## Como usar

### Iniciar
```cmd
start.bat
```
A aplicação rodará em background (invisível)

### Parar
```cmd
stop.bat
```
Encerra todos os processos

### Verificar Status
```cmd
status.bat
```
Verifica se a aplicação está rodando

## Vantagens

- Interface limpa (sem terminais)
- Mais profissional
- Apenas o navegador é visível

## Desvantagens

- ⚠️ **Não vê os logs** (erros são invisíveis)
- Difícil de debugar problemas
- Precisa executar `stop.bat` para encerrar
- Se esquecer de parar, fica rodando em background

## ⚠️ Importante

Se algo der errado e você não souber o motivo, use a **Opção 1** para ver os logs!

## Scripts disponíveis

- `start.bat` - Inicia a aplicação
- `stop.bat` - Para a aplicação
- `status.bat` - Verifica o status

