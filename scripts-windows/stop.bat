@echo off
echo ========================================
echo    PARANDO CONVERSOR PDF TO XLSM
echo ========================================
echo.

echo Encerrando processos...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im cmd.exe /fi "WINDOWTITLE eq Backend*" >nul 2>&1
taskkill /f /im cmd.exe /fi "WINDOWTITLE eq Frontend*" >nul 2>&1

echo.
echo Aplicacao encerrada!
echo.
pause

