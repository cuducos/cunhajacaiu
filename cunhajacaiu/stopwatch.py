from math import floor
from arrow import utcnow


class Stopwatch:

    def __init__(self, lower_house_voting, tz_name):
        self.tz_name = tz_name
        self.now = self.get_now()
        diff = (self.now - lower_house_voting)
        self.days = diff.days
        self.hours = floor(diff.seconds / 3600)
        self.minutes = floor((diff.seconds % 3600) / 60)
        self.seconds = floor((diff.seconds % 3600) % 60)

    def get_now(self):
        return utcnow().to(self.tz_name)

    def as_dict(self):
        labels = ('days', 'hours', 'minutes', 'seconds')
        values = (self.days, self.hours, self.minutes, self.seconds)
        return dict(zip(labels, values))
