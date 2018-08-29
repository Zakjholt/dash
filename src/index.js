import axios from 'axios';
import 'babel-polyfill';
import './style.scss';

const fetchDaysSince = async () => {
  const { data } = await axios('http://localhost:8080/days');

  return data.daysSince;
};

const renderDashboard = async () => {
  const daysSince = await fetchDaysSince();
  document.querySelector('.app').innerHTML = `
    <h3>Days since prod broke</h3>
    <p>${daysSince}</p>
  `;
};

navigator.wakeLock.request('display');
navigator.wakeLock.request('system');

renderDashboard();
setInterval(renderDashboard, 1000 * 60 * 5);
