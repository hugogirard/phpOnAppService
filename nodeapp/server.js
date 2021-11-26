const express = require('express');
const path = require('path');
const fs = require('fs');
const app = express();

const port = process.env.PORT || 3000;

app.set('views',path.join(__dirname,'views'));
app.set('view engine','ejs');

app.use(express.json());
app.use(express.urlencoded({ extended: true}));

app.use('/',require('./controller/IndexController')(express).init())

app.listen(port,() => {
    console.log(`Listening on port ${port}`);
});