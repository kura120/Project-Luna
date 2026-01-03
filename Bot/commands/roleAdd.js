const { SlashCommandBuilder } = require("discord.js");


module.exports = {
    data: new SlashCommandBuilder()
        .setName("roleadd")
        .setDescription("right in the name...")
        .addRoleOption(option =>
            option.setName("role")
                .setDescription("insert role here")
                .setRequired(true))
        .addUserOption(option =>
            option.setName("user")
            .setDescription("select the user you want to give the role to")
            .setRequired(true))
}
