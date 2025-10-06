@echo off
title Conversor PDF to XLSM
echo ========================================
echo    CONVERSOR PDF TO XLSM
echo ========================================
echo.
echo Iniciando aplicacao...
echo.

echo [1/3] Iniciando Backend (Flask)...
start "Backend - Flask" cmd /k "title Backend Flask && venv\Scripts\activate && python app_vercel.py"

echo [2/3] Aguardando backend inicializar...
timeout /t 3 /nobreak >nul

echo [3/3] Iniciando Frontend (React)...
start "Frontend - React" cmd /k "title Frontend React && cd frontend && npm run dev"

echo.
echo Aguardando frontend inicializar...
timeout /t 5 /nobreak >nul

echo.
echo ========================================
echo    APLICACAO INICIADA COM SUCESSO!
echo ========================================
echo.
echo Backend:  http://localhost:5000
echo Frontend: http://localhost:5173
echo.
echo Abrindo navegador...
start http://localhost:5173

echo.
echo ========================================
echo    INSTRUCOES:
echo ========================================
echo.
echo 1. Aguarde o backend e frontend carregarem
echo 2. O navegador abrira automaticamente
echo 3. Para parar: Feche as janelas do terminal
echo 4. Para reiniciar: Execute start.bat novamente
echo.
echo Pressione qualquer tecla para fechar esta janela...
pause >nul

