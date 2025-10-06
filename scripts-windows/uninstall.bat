@echo off
echo ========================================
echo    DESINSTALADOR CONVERSOR PDF TO XLSM
echo ========================================
echo.
echo Tem certeza que deseja remover a aplicacao?
echo.
echo Isso ira remover:
echo - Ambiente virtual Python (venv/)
echo - Dependencias Node.js (frontend/node_modules/)
echo - Scripts de execucao
echo.
set /p confirm="Digite 'SIM' para confirmar: "

if /i "%confirm%"=="SIM" (
    echo.
    echo Removendo arquivos...
    rmdir /s /q venv >nul 2>&1
    rmdir /s /q frontend\node_modules >nul 2>&1
    del start.bat >nul 2>&1
    del stop.bat >nul 2>&1
    del uninstall.bat >nul 2>&1
    echo.
    echo Desinstalacao concluida!
) else (
    echo.
    echo Desinstalacao cancelada.
)

echo.
pause

