const { SlashCommandBuilder } = require("discord.js");


module.exports = {
    data: new SlashCommandBuilder()
        .setName("kick")
        .setDescription("kick a user")
        .addUserOption(option =>
            option.setName("user")
            .setDescription("Select the user to kick.")
            .setRequired(true))
        .addStringOption(option => 
            option.setName("reason")
            .setDescription("Reason of kick.")
            .setRequired(true))
}
