const { SlashCommandBuilder } = require("discord.js");


module.exports = {
    data: new SlashCommandBuilder()
        .setName("untimeout")
        .setDescription("untimeout a user")
        .addUserOption(option =>
            option.setName("user")
                .setDescription("insert user here")
                .setRequired(true))
        .addStringOption(option =>
            option.setName("reason")
                .setDescription("reason of untimeout")
                .setRequired(true))
}
