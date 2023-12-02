// Import external packages
require("dotenv").config();
const express = require("express");
const methodOverride = require("method-override");

// Import routes from custom modules
const indexRouter = require("./routes/indexRouter");
const apiRouter = require("./routes/apiRouter");
const guestsRouter = require("./routes/guestsRouter");

// Set app
const app = express();
const PORT = process.env.PORT || 3000;

app.set("view engine", "ejs");

// Set middleware
app.use(express.static("public"));
app.use(methodOverride("_method"));
app.use(express.urlencoded({ extended: true }));

// Set routes
app.use("/", indexRouter);
app.use("/api", apiRouter);
app.use("/guests", guestsRouter);

// Start the server
app.listen(PORT, console.log(`Server is listening on port: ${PORT}`));
