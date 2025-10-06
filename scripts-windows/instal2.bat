@echo off
echo ========================================
echo    INSTALADOR CONVERSOR PDF TO XLSM
echo ========================================
echo.

:: Obtém o diretório raiz absoluto (um nível acima do local do script)
pushd "%~dp0\.."
set "ROOT_DIR=%CD%"
popd

cd /d "%ROOT_DIR%"

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

:: Verifica o arquivo requirements
echo Verificando arquivo requirements...

set "REQ_FILE="
if exist "%ROOT_DIR%\requirements.txt" set "REQ_FILE=requirements.txt"
if exist "%ROOT_DIR%\requirements" set "REQ_FILE=requirements"

if "%REQ_FILE%"=="" (
    echo ERRO: Nenhum arquivo requirements encontrado em "%ROOT_DIR%"!
    echo Esperado: requirements.txt ou requirements
    pause
    exit /b 1
)

echo Encontrado: %REQ_FILE%

:: Verifica a pasta frontend
if not exist "%ROOT_DIR%\frontend\package.json" (
    echo ERRO: Pasta frontend nao encontrada em "%ROOT_DIR%\frontend"!
    echo Certifique-se de que todos os arquivos do projeto estao corretos.
    pause
    exit /b 1
)

echo.
echo [5/6] Instalando dependencias Python...
call venv\Scripts\activate
pip install -r "%ROOT_DIR%\%REQ_FILE%"
if errorlevel 1 (
    echo ERRO: Falha ao instalar dependencias Python!
    pause
    exit /b 1
)
echo Dependencias Python instaladas!

echo.
echo [6/6] Instalando dependencias do frontend...
cd "%ROOT_DIR%\frontend"
npm install
if errorlevel 1 (
    echo ERRO: Falha ao instalar dependencias Node.js!
    pause
    exit /b 1
)
echo Dependencias Node.js instaladas!

echo.
echo Criando script de execucao...
cd "%ROOT_DIR%"
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
