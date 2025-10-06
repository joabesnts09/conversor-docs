@echo off
echo ========================================
echo    INSTALADOR CONVERSOR PDF TO XLSM
echo ========================================
echo.

echo [1/6] Verificando Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERRO: Python nao encontrado!
    echo Baixe e instale Python 3.12 de: https://python.org
    pause
    exit /b 1
)
echo Python encontrado!

echo.
echo [2/6] Verificando Node.js...
node --version >nul 2>&1
if errorlevel 1 (
    echo ERRO: Node.js nao encontrado!
    echo Baixe e instale Node.js de: https://nodejs.org
    pause
    exit /b 1
)
echo Node.js encontrado!

echo.
echo [3/6] Criando ambiente virtual Python...
python -m venv venv
if errorlevel 1 (
    echo ERRO: Falha ao criar ambiente virtual!
    pause
    exit /b 1
)
echo Ambiente virtual criado!

echo.
echo [4/6] Verificando arquivos do projeto...
if not exist requirements.txt (
    echo ERRO: Arquivo requirements.txt nao encontrado!
    echo Certifique-se de que todos os arquivos do projeto estao na pasta.
    pause
    exit /b 1
)

if not exist frontend\package.json (
    echo ERRO: Pasta frontend nao encontrada!
    echo Certifique-se de que todos os arquivos do projeto estao na pasta.
    pause
    exit /b 1
)

echo Ativando ambiente virtual e instalando dependencias Python...
call venv\Scripts\activate
pip install -r requirements.txt
if errorlevel 1 (
    echo ERRO: Falha ao instalar dependencias Python!
    pause
    exit /b 1
)
echo Dependencias Python instaladas!

echo.
echo [5/6] Instalando dependencias do frontend...
cd frontend
npm install
if errorlevel 1 (
    echo ERRO: Falha ao instalar dependencias Node.js!
    pause
    exit /b 1
)
echo Dependencias Node.js instaladas!

echo.
echo [6/6] Criando scripts de execucao...
cd ..
echo @echo off > start.bat
echo echo Iniciando Conversor PDF to XLSM... >> start.bat
echo start "Backend" cmd /k "venv\Scripts\activate && python app_vercel.py" >> start.bat
echo timeout /t 3 /nobreak ^>nul >> start.bat
echo start "Frontend" cmd /k "cd frontend && npm run dev" >> start.bat
echo timeout /t 5 /nobreak ^>nul >> start.bat
echo start http://localhost:5173 >> start.bat
echo echo. >> start.bat
echo echo Aplicacao iniciada! >> start.bat
echo echo Backend: http://localhost:5000 >> start.bat
echo echo Frontend: http://localhost:5173 >> start.bat
echo echo. >> start.bat
echo echo Pressione qualquer tecla para fechar... >> start.bat
echo pause ^>nul >> start.bat

echo.
echo ========================================
echo    INSTALACAO CONCLUIDA COM SUCESSO!
echo ========================================
echo.
echo Para iniciar a aplicacao, execute: start.bat
echo.
pause
