const { SlashCommandBuilder } = require("discord.js");


module.exports = {
    data: new SlashCommandBuilder()
        .setName("setstatus")
        .setDescription("set the bot's status")
        .addStringOption(option =>
            option.setName("status")
                .setDescription("insert status here")
                .setRequired(true)
                .addChoices(
                    {name: "online", value: "online"},
                    {name: "idle", value: "idle"},
                    {name: "invisible", value: "invisible"},
                    {name: "dnd", value: "dnd"},
                ))
}
