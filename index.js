import express from 'express';

const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('Hello, Express.js with ES6!');
});

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
}); 