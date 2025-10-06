#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Aplicação Web para Conversor PDF para XLSM
"""

from flask import Flask, render_template, request, jsonify
import os
import logging
import uuid
import threading
import time
from werkzeug.utils import secure_filename
from pdf_to_xlsm_converter import PDFToXLSMConverter

# Configurar Flask
app = Flask(__name__)
app.secret_key = 'sua_chave_secreta_aqui'  # Altere para uma chave segura em produção

# Dicionário para armazenar status das conversões
conversion_status = {}

# Dicionário separado para armazenar dados binários
conversion_data = {}

# Configurar logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Configurações
ALLOWED_EXTENSIONS = {'pdf'}
MAX_FILE_SIZE = 50 * 1024 * 1024  # 50MB

# Criar diretório de logs
os.makedirs('logs', exist_ok=True)

app.config['MAX_CONTENT_LENGTH'] = MAX_FILE_SIZE

def allowed_file(filename):
    """Verifica se o arquivo tem extensão permitida"""
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/')
def index():
    """Página principal"""
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    """Processa upload e conversão do arquivo com progresso real"""
    try:
        # Verificar se arquivo foi enviado
        if 'file' not in request.files:
            return jsonify({'error': 'Nenhum arquivo selecionado'}), 400
        
        file = request.files['file']
        
        # Verificar se arquivo foi selecionado
        if file.filename == '':
            return jsonify({'error': 'Nenhum arquivo selecionado'}), 400
        
        # Verificar extensão
        if not allowed_file(file.filename):
            return jsonify({'error': 'Apenas arquivos PDF são permitidos'}), 400
        
        # Gerar ID único para a tarefa
        task_id = str(uuid.uuid4())
        
        # Ler o arquivo para um buffer antes de processar
        file.seek(0)  # Voltar ao início do arquivo
        file_data = file.read()
        filename = secure_filename(file.filename)
        
        # Iniciar processamento em background
        thread = threading.Thread(target=process_conversion, args=(task_id, file_data, filename))
        thread.daemon = True
        thread.start()
        
        return jsonify({
            'task_id': task_id,
            'message': 'Conversão iniciada'
        })
        
    except Exception as e:
        logger.error(f"Erro no upload: {str(e)}")
        return jsonify({'error': str(e)}), 500

def process_conversion(task_id, file_data, filename):
    """Processa a conversão em background com progresso real"""
    try:
        logger.info(f"Iniciando process_conversion para task_id: {task_id}")
        logger.info(f"Tipo do file_data: {type(file_data)}")
        logger.info(f"Tamanho do file_data: {len(file_data) if file_data else 'None'}")
        
        conversion_status[task_id] = {'progress': 0, 'status': 'processing', 'error': None, 'filename': filename}
        
        # 10% - Iniciando
        conversion_status[task_id]['progress'] = 10
        time.sleep(0.5)
        
        # 30% - Extraindo dados
        conversion_status[task_id]['progress'] = 30
        converter = PDFToXLSMConverter()
        time.sleep(0.5)
        
        # 60% - Processando dados
        conversion_status[task_id]['progress'] = 60
        
        # Criar um objeto file-like a partir dos dados
        import io
        logger.info(f"Criando BytesIO com {len(file_data)} bytes")
        file_buffer = io.BytesIO(file_data)
        file_buffer.name = filename  # Manter o nome do arquivo
        logger.info(f"BytesIO criado com sucesso")
        
        xlsm_data = converter.convert_pdf_to_xlsm_in_memory(file_buffer)
        time.sleep(0.5)
        
        # 80% - Finalizando
        conversion_status[task_id]['progress'] = 80
        time.sleep(0.5)
        
        # 100% - Concluído
        conversion_status[task_id] = {
            'progress': 100, 
            'status': 'completed', 
            'error': None,
            'filename': filename
        }
        # Armazenar dados XLSM separadamente para download
        conversion_data[task_id] = xlsm_data
        
    except Exception as e:
        conversion_status[task_id] = {
            'progress': 0, 
            'status': 'error', 
            'error': str(e)
        }

@app.route('/api/status/<task_id>')
def get_status(task_id):
    """API para verificar status da conversão"""
    if task_id not in conversion_status:
        return jsonify({'error': 'Tarefa não encontrada'}), 404
    
    # Retornar apenas dados serializáveis em JSON
    return jsonify(conversion_status[task_id])

@app.route('/download/<task_id>')
def download_file(task_id):
    """Download do arquivo convertido"""
    try:
        if task_id not in conversion_status:
            return jsonify({'error': 'Tarefa não encontrada'}), 404
        
        status = conversion_status[task_id]
        
        if status['status'] != 'completed':
            return jsonify({'error': 'Arquivo não está pronto'}), 400
        
        # Buscar dados XLSM separadamente
        if task_id not in conversion_data:
            return jsonify({'error': 'Dados do arquivo não encontrados'}), 404
        
        xlsm_data = conversion_data[task_id]
        
        # Gerar nome do arquivo baseado no original
        original_filename = status.get('filename', 'arquivo')
        # Remover extensão .pdf e adicionar .xlsm
        if original_filename.lower().endswith('.pdf'):
            base_name = original_filename[:-4]  # Remove .pdf
        else:
            base_name = original_filename
        download_filename = f"{base_name}_convertido.xlsm"
        
        from flask import Response
        return Response(
            xlsm_data,
            mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            headers={
                'Content-Disposition': f'attachment; filename="{download_filename}"',
                'Content-Type': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            }
        )
        
    except Exception as e:
        logger.error(f"Erro no download: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route('/about')
def about():
    """Página sobre o conversor"""
    return render_template('about.html')


if __name__ == '__main__':
    # Forçar recarregamento de templates
    app.config['TEMPLATES_AUTO_RELOAD'] = True
    app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0
    app.jinja_env.auto_reload = True
    app.jinja_env.cache = None
    
    app.run(debug=True, host='0.0.0.0', port=5000)
