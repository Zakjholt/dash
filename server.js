const storage = require('node-persist');
const express = require('express');

const startServer = () => {
  const app = express();
  app.use(express.static('dist'));

  app.get('/days', async (req, res) => {
    const daysSince = await storage.getItem('daysSince');
    res.send(200, { daysSince });
  });

  app.listen(8080);

  console.log('server is running on port 8080');
};

const initDb = async () => {
  await storage.init({
    expiredInterval: 1000 * 60 * 60 * 48
  });
  const daysSince = await storage.getItem('daysSince');

  if (!daysSince) {
    await storage.setItem('daysSince', 0);
  }
};

const incrementDays = async () => {
  const daysSince = await storage.getItem('daysSince');
  const daysSinceInt = parseInt(daysSince);

  await storage.setItem('daysSince', daysSinceInt + 1);
};

const main = async () => {
  await initDb();
  startServer();
  setInterval(incrementDays, 1000 * 60 * 60 * 24);
};

main();
