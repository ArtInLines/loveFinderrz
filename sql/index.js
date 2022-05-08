// Documentation: https://github.com/TryGhost/node-sqlite3/wiki/API

const fs = require('fs/promises');
const sqlite3 = ((verbose = process.env.NODE_ENV === 'development') => (verbose ? require('sqlite3').verbose() : require('sqlite3')))();
const db = new sqlite3.Database('.sqlite3');

const debugDB = require('../debugger')('db');
const queryLog = debugDB.extend('query');
const errorLog = debugDB.extend('error');

// TODO: Add functionality lol

/**
 * Runs a SQL-Script. It is important, that all commands in the script are seperated from each other via `;`
 * @param {import('fs').PathLike} filepath Path to the SQL-Script File
 * @param {import('sqlite3').Database} database Database instance
 */
async function runScript(filepath, database = db) {
	const query = (await fs.readFile(filepath)).toString();
	query.split(';').forEach((cmd, idx) => {
		// queryLog('Running %d. command: "%s" from script "%s"', idx + 1, cmd, filepath);

		database.run(cmd, (res, err) => {
			if (err) errorLog('Error while trying to run Script "%s": %o, while trying to run the following command: %s', filepath, err, cmd);
			else return res;
		});
	});
}

/**
 * Closes a Database instance. Only do this, when the Database is not going to be used anymore - for example when the server crashes.
 * @param {import('sqlite3').Database} database The Database instance to close
 */
function closeDB(database = db) {
	database.close((err) => {
		errorLog('Error while trying to close the Database: %o', err);
	});
}

module.exports = { DB: db, closeDB, runScript };
