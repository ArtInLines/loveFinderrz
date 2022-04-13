require('dotenv');
const path = require('path');
const fs = require('fs/promises');
const express = require('express');
const app = express();

const PORT = process.env.PORT || 80;
const PUBLIC_PATH = path.join(__dirname, 'public');

app.use(express.json());
app.use('/public', express.static(PUBLIC_PATH));

app.get('/', (req, res) => {
	res.sendFile(path.join(PUBLIC_PATH, 'index.html'));
});

app.listen(PORT, console.log(`Server listening on port ${PORT}...`));
