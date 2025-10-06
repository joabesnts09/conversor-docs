@echo off
title Parar Conversor - Opcao 3
color 0C
echo ========================================
echo    ENCERRANDO CONVERSOR PDF TO XLSM
echo ========================================
echo.

echo Encerrando processos em background...
echo.

echo [1/2] Encerrando Backend (Python)...
taskkill /F /IM python.exe >nul 2>&1
if errorlevel 1 (
    echo Backend nao estava rodando.
) else (
    echo Backend encerrado!
)

echo [2/2] Encerrando Frontend (Node.js)...
taskkill /F /IM node.exe >nul 2>&1
if errorlevel 1 (
    echo Frontend nao estava rodando.
) else (
    echo Frontend encerrado!
)

echo.
echo ========================================
echo    APLICACAO ENCERRADA COM SUCESSO!
echo ========================================
echo.
pause

