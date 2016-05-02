const React = require('react');
const ReactDOM = require('react-dom');

const Stopwatch = React.createClass({
  getInitialState: function () {
    return ({
      days: parseInt(this.props.days),
      hours: parseInt(this.props.hours),
      minutes: parseInt(this.props.minutes),
      seconds: parseInt(this.props.seconds),
      labels: {
        days: 'dia',
        hours: 'hora',
        minutes: 'minuto',
        seconds: 'segundo',
      },
    });
  },

  componentDidMount: function () {
    setInterval(this.updateStopwatch, 1000);
  },

  updateStopwatch: function () {
    let current = this.state;
    current.seconds++;
    if (current.seconds === 60) {
      current.seconds = 0;
      current.minutes++;
      if (current.minutes === 60) {
        current.minutes = 0;
        current.hours++;
        if (current.hours == 24) {
          current.hours = 0;
          current.days++;
        }
      }
    }

    this.setState(current);
  },

  getLabel: function (field, value) {
    let label = this.state.labels[field];
    if (value !== 1) {
      label += 's';
    }

    return label;
  },

  render: function () {
    return (
      <div>
        <div>
          {this.state.days}
          <span>{this.getLabel('days', this.state.days)}</span>
        </div>
        <div>
          {this.state.hours}
          <span>{this.getLabel('hours', this.state.hours)}</span>
        </div>
        <div>
          {this.state.minutes}
          <span>{this.getLabel('minutes', this.state.minutes)}</span>
        </div>
        <div>
          {this.state.seconds}
          <span>{this.getLabel('seconds', this.state.seconds)}</span>
        </div>
      </div>
    );
  },

});

const StopwatchContainer =  document.getElementById('stopwatch');
const StopwatchDataset = StopwatchContainer.dataset;

ReactDOM.render(
  <Stopwatch days={StopwatchDataset.days} hours={StopwatchDataset.hours}
    minutes={StopwatchDataset.minutes} seconds={StopwatchDataset.seconds}
    apiUrl={StopwatchDataset.apiUrl} />,
  StopwatchContainer
);
