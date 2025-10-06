@echo off
title Instalador Simples - Conversor PDF to XLSM
echo ========================================
echo    INSTALADOR SIMPLES - CONVERSOR PDF TO XLSM
echo ========================================
echo.
echo Este script ira abrir os links para download
echo e guiar voce na instalacao manual.
echo.
echo ATENCAO: Execute como ADMINISTRADOR!
echo.
pause

echo.
echo ========================================
echo    VERIFICANDO PREREQUISITOS
echo ========================================

echo.
echo [1/4] Verificando Python...
python --version >nul 2>&1
if not errorlevel 1 (
    echo Python ja esta instalado!
    goto :check_node_simple
)

echo Python nao encontrado!
echo.
echo Abrindo pagina de download do Python...
echo IMPORTANTE: Marque "Add Python to PATH" durante a instalacao!
start https://www.python.org/downloads/
echo.
echo Aguarde a instalacao do Python e pressione qualquer tecla...
pause

:check_node_simple
echo.
echo [2/4] Verificando Node.js...
node --version >nul 2>&1
if not errorlevel 1 (
    echo Node.js ja esta instalado!
    goto :install_deps_simple
)

echo Node.js nao encontrado!
echo.
echo Abrindo pagina de download do Node.js...
echo IMPORTANTE: Marque "Add to PATH" durante a instalacao!
start https://nodejs.org/
echo.
echo Aguarde a instalacao do Node.js e pressione qualquer tecla...
pause

:install_deps_simple
echo.
echo [3/4] Verificando instalacoes...
python --version
if errorlevel 1 (
    echo ERRO: Python nao foi instalado corretamente!
    echo Verifique se marcou "Add Python to PATH"
    pause
    exit /b 1
)

node --version
if errorlevel 1 (
    echo ERRO: Node.js nao foi instalado corretamente!
    echo Verifique se marcou "Add to PATH"
    pause
    exit /b 1
)

echo.
echo [4/4] Verificando arquivos do projeto...
if not exist requirements.txt (
    echo ERRO: Arquivo requirements.txt nao encontrado!
    echo Certifique-se de que todos os arquivos do projeto estao na pasta.
    echo Diretorio atual: %CD%
    pause
    exit /b 1
)

if not exist frontend\package.json (
    echo ERRO: Pasta frontend nao encontrada!
    echo Certifique-se de que todos os arquivos do projeto estao na pasta.
    echo Diretorio atual: %CD%
    pause
    exit /b 1
)

echo Arquivos do projeto encontrados!
echo.
echo Instalando dependencias...
echo Criando ambiente virtual Python...
python -m venv venv
if errorlevel 1 (
    echo ERRO: Falha ao criar ambiente virtual!
    pause
    exit /b 1
)

echo Instalando dependencias Python...
call venv\Scripts\activate
pip install -r requirements.txt
if errorlevel 1 (
    echo ERRO: Falha ao instalar dependencias Python!
    pause
    exit /b 1
)

echo Instalando dependencias Node.js...
cd frontend
npm install
if errorlevel 1 (
    echo ERRO: Falha ao instalar dependencias Node.js!
    pause
    exit /b 1
)

cd ..

echo.
echo ========================================
echo    INSTALACAO CONCLUIDA COM SUCESSO!
echo ========================================
echo.
echo Para iniciar a aplicacao, execute: start.bat
echo.
pause
