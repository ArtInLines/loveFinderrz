const path = require('path');
const fs = require('fs/promises');
require('dotenv').config({ path: path.join(__dirname, 'config.env') });
const debugServer = require('./debugger')('server');
const express = require('express');
const app = express();
const { DB, runScript } = require('./sql/index');

const PORT = process.env.PORT || 80;
const PUBLIC_PATH = path.join(__dirname, 'public');

app.use(express.json());
app.use('/public', express.static(PUBLIC_PATH));

app.get('/', (req, res) => {
	res.sendFile(path.join(PUBLIC_PATH, 'loveFinderzz.html'));
});

app.listen(PORT, console.log(`Server listening on port ${PORT}...`));

// TEST SQLite3:
runScript(path.join(__dirname, 'sql', 'loveFinderzz_new_sql_v2.sql')).then(() => DB.all("SELECT * FROM sqlite_master where type='table';", (err, res) => console.log(res)));
