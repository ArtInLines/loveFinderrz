require('dotenv');
const path = require('path');
const fs = require('fs/promises');
const express = require('express');
const app = express();

const PORT = process.env.PORT || 88;

app.use(express.json());

app.get('/', (req, res) => {
	res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, console.log(`Server listening on port ${PORT}...`));
