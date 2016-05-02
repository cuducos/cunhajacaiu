from flask import Blueprint, render_template
from cunhajacaiu.news import News
from cunhajacaiu.stopwatch import Stopwatch


home = Blueprint('home', __name__)


@home.route('/')
def index():
    stopwatch = Stopwatch()
    news = News()
    context = dict(news=list(news.parsed()))
    context.update(stopwatch.as_dict())
    return render_template('home.html', **context)


@home.context_processor
def meta_info():
    return {'title': 'O Cunha já caiu?',
            'description': 'O Cunha já caiu? Não. Mas estamos esperando…'}
