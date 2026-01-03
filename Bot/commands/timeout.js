const { SlashCommandBuilder, AuditLogOptionsType } = require("discord.js");


module.exports = {
    data: new SlashCommandBuilder()
        .setName("timeout")
        .setDescription("timeout a user")
        .addUserOption(option =>
            option.setName("user")
                .setDescription("insert user here")
                .setRequired(true))
        .addStringOption(option =>
            option.setName("reason")
                .setDescription("reason of timeout")
                .setRequired(true))
        .addStringOption(option =>
            option.setName("time")
                .setDescription("insert how long should the user be muted for")
                .setRequired(true))
}
