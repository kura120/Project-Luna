const { SlashCommandBuilder } = require("discord.js");


module.exports = {
    data: new SlashCommandBuilder()
        .setName("suggest")
        .setDescription("Suggest a game for Project Luna")
        .addStringOption(option =>
            option.setName("link")
                .setDescription("Please insert the game link here")
                .setRequired(true))
        .addStringOption(option =>
            option.setName("features")
            .setDescription(`example [tab] => AutoFarm, this, that`)
            .setRequired(true))
}
