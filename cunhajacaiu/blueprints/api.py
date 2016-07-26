from flask import Blueprint, jsonify
from cunhajacaiu.stopwatch import Stopwatch

api = Blueprint('api', __name__)


@api.route('/')
def api_stopwatch():
    stopwatch = Stopwatch()
    return jsonify(**stopwatch.as_dict())
