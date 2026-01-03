const { SlashCommandBuilder } = require("discord.js");


module.exports = {
    data: new SlashCommandBuilder()
        .setName("setpresence")
        .setDescription("set the bot's presence text")
        .addStringOption(option =>
            option.setName("text")
                .setDescription("insert text here")
                .setRequired(true))
}
