from flask import Blueprint, jsonify
from cunhajacaiu.news import News
from cunhajacaiu.stopwatch import Stopwatch

api = Blueprint('api', __name__)


@api.route('/stopwatch/')
def api_stopwatch():
    stopwatch = Stopwatch()
    return jsonify(**stopwatch.as_dict())


@api.route('/news/')
def api_news():
    news = News()
    return jsonify(dict(news=list(news.parsed())))
