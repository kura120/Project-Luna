const { SlashCommandBuilder } = require("discord.js");

module.exports = {
    data: new SlashCommandBuilder()
        .setName("ban")
        .setDescription("ban a user")
        .addUserOption(option =>
            option.setName("user")
            .setDescription("Select the user to ban.")
            .setRequired(true))
        .addStringOption(option => 
            option.setName("reason")
            .setDescription("Reason of ban.")
            .setRequired(true))
}