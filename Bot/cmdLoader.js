const { token } = require('./info.json');
const { Routes } = require("discord.js");
const { REST } = require("@discord.js/rest");
const fs = require("node:fs");

const cmds = [];
const cmdFiles = fs.readdirSync('./commands').filter(file => file.endsWith('.js'));
const botId = "1008503075243298831";

for (const file of cmdFiles) {
    const cmd = require(`./commands/${file}`);
    cmds.push(cmd.data.toJSON());
    console.log(`Supporting Command: ${cmds.data.name}`)
}

const rest = new REST({ version: '10' }).setToken(token)

(async () => {
    try {
        console.log("Initiate refresh app slash (/) commands...");

        await rest.put(
            Routes.applicationCommand(botId),
            { body: cmds},
        );

        console.log("Successfully refreshed app slash (/) commands.");
    } catch (error) {
        console.error(error);
    };
})();