const { SlashCommandBuilder } = require("discord.js");


module.exports = {
    data: new SlashCommandBuilder()
        .setName("botinfo")
        .setDescription("shows info from the bot")
}
