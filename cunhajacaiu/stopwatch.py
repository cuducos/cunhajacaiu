from math import floor
from arrow import utcnow
from cunhajacaiu import app


class Stopwatch:

    def __init__(self):
        self.now = self.get_now()
        diff = (self.now - app.config['LOWER_HOUSE_VOTING'])
        self.days = diff.days
        self.hours = floor(diff.seconds / 3600)
        self.minutes = floor((diff.seconds % 3600) / 60)
        self.seconds = floor((diff.seconds % 3600) % 60)
        self.fallen = app.config['HAS_FALLEN']

    def get_now(self):
        return utcnow().to(app.config['TZ_NAME'])

    def as_dict(self):
        labels = ('days', 'hours', 'minutes', 'seconds', 'fallen')
        vals = (self.days, self.hours, self.minutes, self.seconds, self.fallen)
        return dict(zip(labels, vals))
