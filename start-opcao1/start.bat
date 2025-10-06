@echo off
title Conversor PDF to XLSM - Opcao 1 (Tudo em 1 Terminal)
color 0A
echo ========================================
echo    CONVERSOR PDF TO XLSM
echo    Opcao 1: Tudo em 1 Terminal
echo ========================================
echo.

REM Volta para o diretorio raiz do projeto
cd /d "%~dp0"
cd ..

echo [1/4] Verificando ambiente virtual...
if not exist venv\Scripts\activate.bat (
    echo ERRO: Ambiente virtual nao encontrado!
    echo Execute o instalador primeiro.
    pause
    exit /b 1
)

echo [2/4] Ativando ambiente virtual...
call venv\Scripts\activate.bat

echo [3/4] Iniciando Backend (Flask)...
start /B python app_vercel.py
echo Backend iniciado em http://localhost:5000

echo [4/4] Aguardando backend inicializar...
timeout /t 3 /nobreak >nul

echo Iniciando Frontend (Vite)...
cd frontend
echo.
echo ========================================
echo    APLICACAO INICIADA!
echo ========================================
echo.
echo Backend:  http://localhost:5000
echo Frontend: http://localhost:5173
echo.
echo Aguarde o frontend inicializar...
echo O navegador abrira automaticamente.
echo.
echo Para parar: Pressione Ctrl+C
echo ========================================
echo.

REM Aguarda 5 segundos e abre o navegador
start /B timeout /t 5 /nobreak >nul && start http://localhost:5173

REM Inicia o frontend (fica neste terminal)
npm run dev

REM Quando o usuario pressionar Ctrl+C, limpa os processos
cd ..
echo.
echo Encerrando aplicacao...
taskkill /F /IM python.exe >nul 2>&1
echo Aplicacao encerrada!
pause

