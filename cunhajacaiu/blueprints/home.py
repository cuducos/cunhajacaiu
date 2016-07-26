from flask import Blueprint, render_template


home = Blueprint('home', __name__)


@home.route('/')
def index():
    return render_template('home.html')


@home.context_processor
def meta_info():
    return {'title': 'Cunha já caiu?',
            'description': 'O Cunha já caiu? Não. Mas estamos esperando…'}
