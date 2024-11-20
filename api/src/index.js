const app = require("./app");
const { PORT } = require("./config/index.js");

app.listen(PORT, () => {
  console.log(`\nServer running on port:  http://localhost:${PORT}/\n`);
});
