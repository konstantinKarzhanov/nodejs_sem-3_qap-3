// Import external packages
require("dotenv").config();
const express = require("express");
const methodOverride = require("method-override");

// Import routes from custom modules
const indexRouter = require("./routes/indexRouter");
const apiIndexRouter = require("./routes/apiIndexRouter");
const guestsRouter = require("./routes/guestsRouter");
const notFoundRouter = require("./routes/notFoundRouter");

// Set app
const app = express();
const PORT = process.env.PORT || 3000;

app.set("view engine", "ejs");

// Set middleware
app.use(express.static("public"));
app.use(methodOverride("_method"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Set routes
app.use("/", indexRouter);
app.use("/api", apiIndexRouter);
app.use("/guests", guestsRouter);
app.use("/*", notFoundRouter);

// Start the server
app.listen(PORT, console.log(`Server is listening on port: ${PORT}`));
