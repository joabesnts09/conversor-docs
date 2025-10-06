@echo off
title Verificador de Arquivos - Conversor PDF to XLSM
echo ========================================
echo    VERIFICADOR DE ARQUIVOS
echo ========================================
echo.
echo Verificando se todos os arquivos necessarios estao presentes...
echo.

set "erro=0"

echo [1/8] Verificando arquivo requirements.txt...
if not exist requirements.txt (
    echo ❌ ERRO: requirements.txt nao encontrado!
    set "erro=1"
) else (
    echo ✅ requirements.txt encontrado
)

echo.
echo [2/8] Verificando arquivo app_vercel.py...
if not exist app_vercel.py (
    echo ❌ ERRO: app_vercel.py nao encontrado!
    set "erro=1"
) else (
    echo ✅ app_vercel.py encontrado
)

echo.
echo [3/8] Verificando arquivo pdf_to_xlsm_converter.py...
if not exist pdf_to_xlsm_converter.py (
    echo ❌ ERRO: pdf_to_xlsm_converter.py nao encontrado!
    set "erro=1"
) else (
    echo ✅ pdf_to_xlsm_converter.py encontrado
)

echo.
echo [4/8] Verificando pasta frontend...
if not exist frontend (
    echo ❌ ERRO: Pasta frontend nao encontrada!
    set "erro=1"
) else (
    echo ✅ Pasta frontend encontrada
)

echo.
echo [5/8] Verificando arquivo frontend/package.json...
if not exist frontend\package.json (
    echo ❌ ERRO: frontend/package.json nao encontrado!
    set "erro=1"
) else (
    echo ✅ frontend/package.json encontrado
)

echo.
echo [6/8] Verificando arquivo frontend/vite.config.js...
if not exist frontend\vite.config.js (
    echo ❌ ERRO: frontend/vite.config.js nao encontrado!
    set "erro=1"
) else (
    echo ✅ frontend/vite.config.js encontrado
)

echo.
echo [7/8] Verificando arquivo frontend/index.html...
if not exist frontend\index.html (
    echo ❌ ERRO: frontend/index.html nao encontrado!
    set "erro=1"
) else (
    echo ✅ frontend/index.html encontrado
)

echo.
echo [8/8] Verificando pasta frontend/src...
if not exist frontend\src (
    echo ❌ ERRO: Pasta frontend/src nao encontrada!
    set "erro=1"
) else (
    echo ✅ Pasta frontend/src encontrada
)

echo.
echo ========================================
if "%erro%"=="1" (
    echo    VERIFICACAO FALHOU!
    echo ========================================
    echo.
    echo Alguns arquivos estao faltando.
    echo Certifique-se de que todos os arquivos do projeto
    echo estao na pasta antes de executar a instalacao.
    echo.
    echo Arquivos necessarios:
    echo - requirements.txt
    echo - app_vercel.py
    echo - pdf_to_xlsm_converter.py
    echo - frontend/ (pasta completa)
    echo.
) else (
    echo    VERIFICACAO CONCLUIDA COM SUCESSO!
    echo ========================================
    echo.
    echo Todos os arquivos necessarios estao presentes.
    echo Voce pode executar a instalacao com seguranca.
    echo.
)

echo Pressione qualquer tecla para fechar...
pause >nul

