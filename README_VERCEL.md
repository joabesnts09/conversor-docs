# Deploy na Vercel - Conversor PDF para XLSM

## 🚀 Deploy Automático

### Método 1: Via GitHub (Recomendado)

1. **Crie um repositório no GitHub**
2. **Faça upload dos arquivos**:
   - `app_vercel.py` (renomeie para `app.py`)
   - `vercel.json`
   - `requirements_vercel.txt` (renomeie para `requirements.txt`)
   - `templates/` (pasta completa)
   - `pdf_to_xlsm_converter.py`
   - `package.json`
   - `.vercelignore`

3. **Conecte na Vercel**:
   - Acesse: https://vercel.com
   - Clique em "New Project"
   - Importe o repositório GitHub
   - Configure:
     - **Framework Preset**: Other
     - **Root Directory**: ./
     - **Build Command**: `pip install -r requirements.txt`
     - **Output Directory**: ./
     - **Install Command**: `pip install -r requirements.txt`

4. **Deploy**:
   - Clique em "Deploy"
   - Aguarde o processo concluir
   - Acesse a URL fornecida

### Método 2: Via Vercel CLI

1. **Instale a Vercel CLI**:
   ```bash
   npm install -g vercel
   ```

2. **Login na Vercel**:
   ```bash
   vercel login
   ```

3. **Deploy**:
   ```bash
   vercel
   ```

4. **Siga as instruções**:
   - Escolha o projeto
   - Confirme as configurações
   - Aguarde o deploy

## 📁 Estrutura para Vercel

```
conversor/
├── app_vercel.py         # Aplicação principal para Vercel
├── vercel.json           # Configuração da Vercel
├── requirements_vercel.txt  # Dependências para Vercel
├── package.json         # Configuração Node.js
├── .vercelignore        # Arquivos ignorados
├── templates/           # Templates HTML
│   ├── base.html
│   ├── index.html
│   └── about.html
├── pdf_to_xlsm_converter.py  # Conversor principal
└── api/                 # API endpoints
    └── index.py
```

## ⚙️ Configurações da Vercel

### vercel.json
```json
{
  "version": 2,
  "builds": [
    {
      "src": "app_vercel.py",
      "use": "@vercel/python"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "app_vercel.py"
    }
  ],
  "env": {
    "PYTHONPATH": "/var/task"
  },
  "functions": {
    "app_vercel.py": {
      "maxDuration": 60
    }
  }
}
```

### Variáveis de Ambiente
Configure na Vercel Dashboard:
- `SECRET_KEY`: Chave secreta para sessões
- `PYTHONPATH`: `/var/task`

## 🔧 Limitações da Vercel

### Limitações de Arquivo
- **Tamanho máximo**: 10MB por arquivo
- **Tempo de execução**: 30 segundos (plano gratuito)
- **Memória**: 1GB (plano gratuito)

### Limitações de Processamento
- **PDFs grandes**: Podem exceder o tempo limite
- **Múltiplas páginas**: Processamento limitado
- **Arquivos temporários**: Armazenados em `/tmp`

## 🛠️ Adaptações para Vercel

### 1. Processamento em Memória
```python
# Processamento totalmente em memória
file_data = file.read()
file_buffer = io.BytesIO(file_data)
xlsm_data = converter.convert_pdf_to_xlsm_in_memory(file_buffer)
```

### 2. Limite de Tamanho
```python
# Reduzir limite para 10MB
MAX_FILE_SIZE = 10 * 1024 * 1024  # 10MB
```

### 3. Timeout
```python
# Configurar timeout de 60 segundos
"maxDuration": 60
```

### 4. Progresso Real
```python
# Progresso real do backend
conversion_status[task_id] = {'progress': 10, 'status': 'processing'}
# Atualizações: 10% → 30% → 60% → 80% → 100%
```

### 5. Nome de Arquivo Personalizado
```python
# Nome baseado no arquivo original
download_filename = f"{base_name}_convertido.xlsm"
```

## 📊 Performance na Vercel

### Otimizações
- **Compressão**: Gzip automático
- **CDN**: Distribuição global
- **Cache**: Headers otimizados
- **Lazy Loading**: Carregamento sob demanda

### Métricas
- **Tempo de resposta**: < 2 segundos
- **Disponibilidade**: 99.9%
- **Escalabilidade**: Automática

## 🔍 Monitoramento

### Logs
- **Vercel Dashboard**: Logs em tempo real
- **Função**: `console.log()` para debug
- **Erros**: Capturados automaticamente

### Métricas
- **Requests**: Contador de requisições
- **Duration**: Tempo de execução
- **Memory**: Uso de memória
- **Errors**: Taxa de erro

## 🚨 Solução de Problemas

### Erro: "Function timeout"
- **Causa**: Processamento demorado
- **Solução**: Otimizar código ou usar plano pago

### Erro: "File too large"
- **Causa**: Arquivo > 10MB
- **Solução**: Reduzir tamanho do PDF

### Erro: "Module not found"
- **Causa**: Dependência não instalada
- **Solução**: Verificar `requirements.txt`

### Erro: "Memory limit exceeded"
- **Causa**: Uso excessivo de memória
- **Solução**: Otimizar processamento

## 💰 Custos

### Plano Gratuito
- **100GB bandwidth/mês**
- **100GB-hours de execução**
- **10MB por arquivo**
- **30 segundos de timeout**

### Plano Pro ($20/mês)
- **1TB bandwidth/mês**
- **1TB-hours de execução**
- **50MB por arquivo**
- **60 segundos de timeout**

## 🔄 Atualizações

### Deploy Automático
- **GitHub**: Push automático
- **Vercel CLI**: `vercel --prod`
- **Dashboard**: Deploy manual

### Rollback
- **Vercel Dashboard**: Versões anteriores
- **Git**: Revert commit
- **CLI**: `vercel rollback`

## 📱 Acesso

### URLs
- **Produção**: `https://seu-projeto.vercel.app`
- **Preview**: `https://seu-projeto-git-branch.vercel.app`
- **Local**: `http://localhost:3000`

### Domínio Customizado
- **Vercel Dashboard**: Domains
- **DNS**: Configurar CNAME
- **SSL**: Automático

## ✅ Checklist de Deploy

- [x] `app_vercel.py` atualizado com todas as melhorias
- [x] `vercel.json` configurado para `app_vercel.py`
- [x] `requirements_vercel.txt` atualizado
- [x] `api/index.py` atualizado com progresso real
- [x] `.vercelignore` configurado
- [x] Templates HTML incluídos
- [x] Processamento em memória implementado
- [x] Progresso real do backend
- [x] Nome de arquivo personalizado
- [x] Timeout aumentado para 60 segundos
- [ ] Variáveis de ambiente configuradas
- [ ] Deploy realizado
- [ ] Teste de funcionalidade
- [ ] Monitoramento ativo

## 🎯 Próximos Passos

1. **Deploy inicial**: Teste básico
2. **Otimização**: Performance
3. **Monitoramento**: Logs e métricas
4. **Escalabilidade**: Plano pago (se necessário)
5. **Domínio**: Customizado
6. **SSL**: Automático
7. **CDN**: Global

