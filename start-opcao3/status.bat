@echo off
title Status - Conversor PDF to XLSM
color 0E
echo ========================================
echo    STATUS DO CONVERSOR PDF TO XLSM
echo ========================================
echo.

echo Verificando processos em execucao...
echo.

echo [Backend - Python]
tasklist /FI "IMAGENAME eq python.exe" 2>nul | find /I "python.exe" >nul
if errorlevel 1 (
    echo Status: PARADO
) else (
    echo Status: RODANDO
    tasklist /FI "IMAGENAME eq python.exe"
)

echo.
echo [Frontend - Node.js]
tasklist /FI "IMAGENAME eq node.exe" 2>nul | find /I "node.exe" >nul
if errorlevel 1 (
    echo Status: PARADO
) else (
    echo Status: RODANDO
    tasklist /FI "IMAGENAME eq node.exe"
)

echo.
echo ========================================
echo.
pause

