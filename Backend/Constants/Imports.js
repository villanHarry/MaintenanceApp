const express = require('express');
const app = express();
const dotenv = require('dotenv').config('./.env');
const port = process.env.PORT;

module.exports={
    express,
    app,
    port
};