const { SlashCommandBuilder } = require("discord.js");


module.exports = {
    data: new SlashCommandBuilder()
        .setName("unban")
        .setDescription("unban a user")
        .addStringOption(option =>
            option.setName("user")
            .setDescription("Select the user to unban. (ID)")
            .setRequired(true))
        .addStringOption(option => 
            option.setName("reason")
            .setDescription("Reason of unban.")
            .setRequired(true))
}
