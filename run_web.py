#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para executar a aplicação web
"""

import os
import sys
import subprocess
from pathlib import Path

def install_requirements():
    """Instala as dependências necessárias"""
    print("Instalando dependências...")
    try:
        subprocess.run([
            sys.executable, "-m", "pip", "install", "-r", "requirements_web.txt", 
            "--break-system-packages"
        ], check=True)
        print("✅ Dependências instaladas com sucesso!")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Erro ao instalar dependências: {e}")
        return False

def create_directories():
    """Cria diretórios necessários"""
    directories = ['logs', 'templates', 'static/css', 'static/js']
    
    for directory in directories:
        Path(directory).mkdir(parents=True, exist_ok=True)
        print(f"📁 Diretório criado: {directory}")

def run_web_app():
    """Executa a aplicação web"""
    print("🚀 Iniciando aplicação web...")
    print("📱 Acesse: http://localhost:5000")
    print("🛑 Para parar: Ctrl+C")
    print("-" * 50)
    
    try:
        from app import app
        app.run(debug=True, host='0.0.0.0', port=5000)
    except ImportError as e:
        print(f"❌ Erro ao importar aplicação: {e}")
        print("💡 Certifique-se de que o arquivo app.py existe")
    except KeyboardInterrupt:
        print("\n🛑 Aplicação interrompida pelo usuário")
    except Exception as e:
        print(f"❌ Erro ao executar aplicação: {e}")

def main():
    """Função principal"""
    print("🌐 Conversor PDF para XLSM - Aplicação Web")
    print("=" * 50)
    print("📝 Processamento em memória - Sem armazenamento de arquivos")
    print("=" * 50)
    
    # Verificar se estamos no diretório correto
    if not Path("app.py").exists():
        print("❌ Arquivo app.py não encontrado!")
        print("💡 Execute este script no diretório do projeto")
        return
    
    # Criar diretórios
    create_directories()
    
    # Instalar dependências
    if not install_requirements():
        return
    
    # Executar aplicação
    run_web_app()

if __name__ == "__main__":
    main()

