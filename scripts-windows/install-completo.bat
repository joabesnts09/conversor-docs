@echo off
title Instalador Completo - Conversor PDF to XLSM
echo ========================================
echo    INSTALADOR COMPLETO - CONVERSOR PDF TO XLSM
echo ========================================
echo.
echo Este script ira:
echo 1. Baixar e instalar Python 3.12
echo 2. Baixar e instalar Node.js LTS
echo 3. Instalar todas as dependencias
echo 4. Configurar a aplicacao
echo.
echo ATENCAO: Execute como ADMINISTRADOR!
echo.
pause

echo.
echo ========================================
echo    VERIFICANDO PREREQUISITOS
echo ========================================

echo.
echo [1/8] Verificando se Python ja esta instalado...
python --version >nul 2>&1
if not errorlevel 1 (
    echo Python ja esta instalado!
    goto :check_node
)

echo.
echo [2/8] Python nao encontrado. Baixando Python 3.12...
echo Criando pasta temporaria...
mkdir temp_install >nul 2>&1
cd temp_install

echo Baixando Python 3.12.7...
powershell -Command "& {Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.7/python-3.12.7-amd64.exe' -OutFile 'python-installer.exe'}" >nul 2>&1

if not exist python-installer.exe (
    echo ERRO: Falha ao baixar Python!
    echo Baixe manualmente de: https://python.org
    pause
    exit /b 1
)

echo Instalando Python 3.12.7...
python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 >nul 2>&1

echo Aguardando instalacao...
timeout /t 10 /nobreak >nul

echo Limpando arquivos temporarios...
del python-installer.exe >nul 2>&1
cd ..
rmdir temp_install >nul 2>&1

echo Python instalado com sucesso!

:check_node
echo.
echo [3/8] Verificando se Node.js ja esta instalado...
node --version >nul 2>&1
if not errorlevel 1 (
    echo Node.js ja esta instalado!
    goto :install_deps
)

echo.
echo [4/8] Node.js nao encontrado. Baixando Node.js LTS...
echo Criando pasta temporaria...
mkdir temp_install >nul 2>&1
cd temp_install

echo Baixando Node.js LTS...
powershell -Command "& {Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.11.0/node-v20.11.0-x64.msi' -OutFile 'nodejs-installer.msi'}" >nul 2>&1

if not exist nodejs-installer.msi (
    echo ERRO: Falha ao baixar Node.js!
    echo Baixe manualmente de: https://nodejs.org
    pause
    exit /b 1
)

echo Instalando Node.js LTS...
msiexec /i nodejs-installer.msi /quiet /norestart >nul 2>&1

echo Aguardando instalacao...
timeout /t 15 /nobreak >nul

echo Limpando arquivos temporarios...
del nodejs-installer.msi >nul 2>&1
cd ..
rmdir temp_install >nul 2>&1

echo Node.js instalado com sucesso!

:install_deps
echo.
echo [5/8] Atualizando PATH do sistema...
call refreshenv >nul 2>&1

echo.
echo [6/8] Verificando instalacoes...
python --version
if errorlevel 1 (
    echo ERRO: Python nao foi instalado corretamente!
    pause
    exit /b 1
)

node --version
if errorlevel 1 (
    echo ERRO: Node.js nao foi instalado corretamente!
    pause
    exit /b 1
)

echo.
echo [7/8] Voltando para o diretorio do projeto...
cd /d "%~dp0"
cd ..

echo.
echo [8/8] Verificando arquivos do projeto...
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
echo Criando ambiente virtual Python...
python -m venv venv
if errorlevel 1 (
    echo ERRO: Falha ao criar ambiente virtual!
    pause
    exit /b 1
)

echo.
echo Instalando dependencias Python...
call venv\Scripts\activate
pip install --upgrade pip >nul 2>&1
pip install -r requirements.txt
if errorlevel 1 (
    echo ERRO: Falha ao instalar dependencias Python!
    pause
    exit /b 1
)

echo.
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
echo Python 3.12: Instalado
echo Node.js LTS: Instalado
echo Dependencias: Instaladas
echo.
echo Para iniciar a aplicacao, execute: start.bat
echo.
echo IMPORTANTE: Reinicie o computador para garantir
echo que todas as configuracoes sejam aplicadas.
echo.
pause
