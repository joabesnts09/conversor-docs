import React, { useState, useRef, useEffect } from 'react'

function App() {
  const [selectedFile, setSelectedFile] = useState(null)
  const [isUploading, setIsUploading] = useState(false)
  const [progress, setProgress] = useState(0)
  const [status, setStatus] = useState('')
  const [taskId, setTaskId] = useState(null)
  const [isDragOver, setIsDragOver] = useState(false)
  const [conversionHistory, setConversionHistory] = useState([])
  const [showFeatures, setShowFeatures] = useState(false)
  const [apiStatus, setApiStatus] = useState('checking')
  const fileInputRef = useRef(null)

  // Verificar status da API
  useEffect(() => {
    const checkApiStatus = async () => {
      try {
        // Em produção, usar URL relativa (mesmo domínio)
        // Em desenvolvimento, o proxy do Vite redireciona para localhost:5000
        const response = await fetch('/health')
        if (response.ok) {
          setApiStatus('online')
        } else {
          setApiStatus('offline')
        }
      } catch (error) {
        setApiStatus('offline')
      }
    }
    
    checkApiStatus()
    const interval = setInterval(checkApiStatus, 30000) // Verificar a cada 30s
    
    return () => clearInterval(interval)
  }, [])

  const handleFileSelect = (file) => {
    if (file && file.type === 'application/pdf') {
      setSelectedFile(file)
      setStatus('')
    } else {
      setStatus('Por favor, selecione apenas arquivos PDF.')
    }
  }

  const handleFileInputChange = (e) => {
    const file = e.target.files[0]
    handleFileSelect(file)
  }

  const handleDrop = (e) => {
    e.preventDefault()
    setIsDragOver(false)
    const file = e.dataTransfer.files[0]
    handleFileSelect(file)
  }

  const handleDragOver = (e) => {
    e.preventDefault()
    setIsDragOver(true)
  }

  const handleDragLeave = (e) => {
    e.preventDefault()
    setIsDragOver(false)
  }

  const handleUpload = async () => {
    if (!selectedFile) {
      setStatus('Por favor, selecione um arquivo PDF.')
      return
    }

    setIsUploading(true)
    setProgress(0)
    setStatus('Iniciando conversão...')

    try {
      const formData = new FormData()
      formData.append('file', selectedFile)

      // Em produção, usar URL relativa (mesmo domínio)
      // Em desenvolvimento, o proxy do Vite redireciona para localhost:5000
      const response = await fetch('/upload', {
        method: 'POST',
        body: formData
      })

      const data = await response.json()

      if (data.error) {
        throw new Error(data.error)
      }

      setTaskId(data.task_id)
      setStatus('Conversão iniciada...')
      monitorProgress(data.task_id)

    } catch (error) {
      setStatus(`Erro: ${error.message}`)
      setIsUploading(false)
    }
  }

  const monitorProgress = (taskId) => {
    const checkStatus = setInterval(async () => {
      try {
        // Em produção, usar URL relativa (mesmo domínio)
        // Em desenvolvimento, o proxy do Vite redireciona para localhost:5000
        const response = await fetch(`/api/status/${taskId}`)
        const data = await response.json()

        if (data.error) {
          clearInterval(checkStatus)
          setStatus(`Erro: ${data.error}`)
          setIsUploading(false)
          return
        }

        setProgress(data.progress)
        setStatus(`Processando... ${data.progress}%`)

        if (data.status === 'completed') {
          clearInterval(checkStatus)
          setStatus('Conversão concluída!')
          setProgress(100)
          
          // Adicionar ao histórico
          const newEntry = {
            id: taskId,
            filename: selectedFile.name,
            timestamp: new Date().toLocaleString(),
            status: 'completed'
          }
          setConversionHistory(prev => [newEntry, ...prev.slice(0, 4)]) // Manter apenas 5 entradas
          
          // Download automático
          setTimeout(() => {
            // Em produção, usar URL relativa (mesmo domínio)
            // Em desenvolvimento, o proxy do Vite redireciona para localhost:5000
            window.location.href = `/download/${taskId}`
            resetForm()
          }, 1000)
        } else if (data.status === 'error') {
          clearInterval(checkStatus)
          setStatus(`Erro: ${data.error}`)
          setIsUploading(false)
        }
      } catch (error) {
        clearInterval(checkStatus)
        setStatus('Erro de comunicação')
        setIsUploading(false)
      }
    }, 1000)
  }

  const resetForm = () => {
    setSelectedFile(null)
    setIsUploading(false)
    setProgress(0)
    setStatus('')
    setTaskId(null)
    if (fileInputRef.current) {
      fileInputRef.current.value = ''
    }
  }

  return (
    <div className="app-container">
      {/* Header Escuro */}
      <header className="app-header">
        <div className="container">
          <div className="d-flex justify-content-center align-items-center">
            <div className="logo">
              <i className="fas fa-file-excel text-success me-2"></i>
              <span>PDF to XLSM</span>
            </div>
          </div>
        </div>
      </header>

      {/* Notificação de Erro */}
      {status && status.includes('Erro') && (
        <div className="error-notification">
          <div className="container">
            <div className="d-flex justify-content-between align-items-center">
              <span>
                <i className="fas fa-exclamation-triangle me-2"></i>
                {status}
              </span>
              <button 
                className="btn-close"
                onClick={() => setStatus('')}
              >
                <i className="fas fa-times"></i>
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Hero Section */}
      <section className="hero-section">
        <div className="container">
          <div className="hero-content">
            <h1 className="hero-title">Conversor PDF para XLSM</h1>
            <p className="hero-description">
              Converta arquivos PDF com tabelas financeiras para formato Excel (XLSM) 
              com formatação profissional e estrutura otimizada.
            </p>
            
            {/* Indicador de Conversão */}
            <div className="conversion-indicator">
              <div className="format-tag">
                <i className="fas fa-file-pdf me-2"></i>
                PDF
              </div>
              <div className="arrow">
                <i className="fas fa-arrow-right"></i>
              </div>
              <div className="format-tag">
                <i className="fas fa-file-excel me-2"></i>
                XLSM
              </div>
            </div>
          </div>
          
          {/* Ícone Decorativo */}
          <div className="hero-icon">
            <i className="fas fa-file-excel"></i>
          </div>
        </div>
      </section>

      {/* Card de Upload */}
      <section className="upload-section">
        <div className="container">
          <div className="upload-card">
            <div className="upload-header">
              <h3 className="upload-title">
                <i className="fas fa-upload text-primary me-2"></i>
                Converter Arquivo
              </h3>
            </div>
            
            <div className="upload-body">
              
              <div 
                className={`upload-area ${isDragOver ? 'dragover' : ''}`}
                onDrop={handleDrop}
                onDragOver={handleDragOver}
                onDragLeave={handleDragLeave}
                onClick={() => fileInputRef.current?.click()}
              >
                <i className="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                <p className="upload-instruction">
                  Arraste e solte seu arquivo PDF aqui ou clique para selecionar
                </p>
                <input
                  ref={fileInputRef}
                  type="file"
                  accept=".pdf"
                  onChange={handleFileInputChange}
                  style={{ display: 'none' }}
                />
              </div>

              {selectedFile && (
                <div className="mt-3">
                  <p className="text-success">
                    <i className="fas fa-check-circle me-2"></i>
                    Arquivo selecionado: {selectedFile.name}
                  </p>
                </div>
              )}

              {status && !status.includes('Erro') && (
                <div className="mt-3">
                  <p className="text-info">
                    {status}
                  </p>
                </div>
              )}

              {isUploading && (
                <div className="progress-container">
                  <div className="progress">
                    <div 
                      className="progress-bar progress-bar-animated bg-primary" 
                      role="progressbar" 
                      style={{ width: `${progress}%` }}
                    >
                      {progress}%
                    </div>
                  </div>
                </div>
              )}

              <div className="text-center mt-4">
                <button
                  className="btn btn-primary btn-lg"
                  onClick={handleUpload}
                  disabled={!selectedFile || isUploading}
                >
                  {isUploading ? (
                    <>
                      <i className="fas fa-spinner fa-spin me-2"></i>
                      Convertendo...
                    </>
                  ) : (
                    <>
                      <i className="fas fa-magic me-2"></i>
                      Converter para XLSM
                    </>
                  )}
                </button>
              </div>

              <div className="mt-4 text-center">
                <small className="text-muted">
                  <i className="fas fa-info-circle me-1"></i>
                  Suporte apenas para arquivos PDF. Tamanho máximo: 10MB.
                </small>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Histórico de Conversões */}
      {conversionHistory.length > 0 && (
        <section className="history-section">
          <div className="container">
            <div className="history-card">
              <div className="history-header">
                <h5 className="history-title">
                  <i className="fas fa-history text-primary me-2"></i>
                  Histórico de Conversões
                </h5>
              </div>
              <div className="history-body">
                <div className="table-responsive">
                  <table className="table table-sm">
                    <thead>
                      <tr>
                        <th>Arquivo</th>
                        <th>Data/Hora</th>
                        <th>Status</th>
                        <th>Ação</th>
                      </tr>
                    </thead>
                    <tbody>
                      {conversionHistory.map((entry) => (
                        <tr key={entry.id}>
                          <td>
                            <i className="fas fa-file-pdf text-danger me-2"></i>
                            {entry.filename}
                          </td>
                          <td>{entry.timestamp}</td>
                          <td>
                            <span className="badge bg-success">
                              <i className="fas fa-check me-1"></i>
                              Concluído
                            </span>
                          </td>
                          <td>
                            <button 
                              className="btn btn-sm btn-outline-primary"
                              onClick={() => {
                                // Em produção, usar URL relativa (mesmo domínio)
                                // Em desenvolvimento, o proxy do Vite redireciona para localhost:5000
                                window.location.href = `/download/${entry.id}`
                              }}
                            >
                              <i className="fas fa-download me-1"></i>
                              Baixar
                            </button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </section>
      )}

      {/* Footer */}
      <footer className="app-footer">
        <div className="container">
          <div className="text-center">
            <p className="mb-2">
              <i className="fas fa-code me-2"></i>
              Desenvolvido com React + Flask
            </p>
            <p className="mb-0">
              <i className="fas fa-server me-2"></i>
              Processamento em tempo real • 
              <i className="fas fa-shield-alt ms-2 me-2"></i>
              Seguro e confiável
            </p>
          </div>
        </div>
      </footer>
    </div>
  )
}

export default App
