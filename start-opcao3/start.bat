@echo off
title Conversor PDF to XLSM - Opcao 3 (Background)
color 0B
echo ========================================
echo    CONVERSOR PDF TO XLSM
echo    Opcao 3: Background (Sem Janelas)
echo ========================================
echo.

REM Volta para o diretorio raiz do projeto
cd /d "%~dp0"
cd ..

echo [1/5] Verificando ambiente virtual...
if not exist venv\Scripts\activate.bat (
    echo ERRO: Ambiente virtual nao encontrado!
    echo Execute o instalador primeiro.
    pause
    exit /b 1
)

echo [2/5] Verificando se ja esta rodando...
tasklist /FI "IMAGENAME eq python.exe" 2>nul | find /I "python.exe" >nul
if not errorlevel 1 (
    echo Encerrando processos anteriores...
    taskkill /F /IM python.exe >nul 2>&1
)

tasklist /FI "IMAGENAME eq node.exe" 2>nul | find /I "node.exe" >nul
if not errorlevel 1 (
    echo Encerrando processos anteriores...
    taskkill /F /IM node.exe >nul 2>&1
)

echo [3/5] Iniciando Backend em background...
start /B venv\Scripts\python.exe app_vercel.py >nul 2>&1
echo Backend iniciado (invisivel)

echo [4/5] Aguardando backend inicializar...
timeout /t 3 /nobreak >nul

echo [5/5] Iniciando Frontend em background...
cd frontend
start /B npm run dev >nul 2>&1
cd ..
echo Frontend iniciado (invisivel)

echo.
echo Aguardando frontend inicializar...
timeout /t 5 /nobreak >nul

echo.
echo ========================================
echo    APLICACAO RODANDO EM BACKGROUND!
echo ========================================
echo.
echo Backend:  http://localhost:5000
echo Frontend: http://localhost:5173
echo.
echo A aplicacao esta rodando em segundo plano.
echo Nenhuma janela de terminal sera exibida.
echo.
echo Para PARAR a aplicacao, execute: stop.bat
echo ========================================
echo.
echo Abrindo navegador...
start http://localhost:5173

echo.
pause

