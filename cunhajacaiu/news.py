import redis
import requests
import requests_cache
from datetime import timedelta
from cunhajacaiu import app


class News:

    REDDIT_SEARCH = 'https://www.reddit.com/search.json'
    FILTER = ('"Eduardo Cunha"', 'subreddit:brasil', 'self:no', '-flair:Humor')
    QUERY = {'q': ' '.join(FILTER), 'sort': 'top', 't': 'week'}

    def __init__(self):

        # set up cache
        backend = app.config['REQUESTS_CACHE_BACKEND']
        cache_settings = {'backend': backend,
                          'expire_after': timedelta(hours=2)}
        if backend == 'redis':
            redis_url = app.config['REDIS_URL']
            connection = {'connection': redis.from_url(redis_url)}
            cache_settings.update(connection)
        requests_cache.install_cache(**cache_settings)

        # try to fecth news from reddit
        success = False
        attempts = 0
        while not success and attempts < 5:
            self.full_news = self.load()
            if not self.full_news:
                attempts += 1
            else:
                success = True

    def load(self):

        response = requests.get(self.REDDIT_SEARCH, params=self.QUERY)
        if response.status_code != 200:
            requests_cache.clear()

        response_json = response.json()
        response_data = response_json.get('data', {})
        return response_data.get('children', [])

    def parsed(self):
        fields = ('domain', 'url', 'title')
        for news in self.full_news:
            yield {field: news['data'][field] for field in fields}
