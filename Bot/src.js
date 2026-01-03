const { Client, GatewayIntentBits, Routes, EmbedBuilder, PermissionsBitField, Embed } = require("discord.js");
const { token } = require("./info.json");
const fs = require("node:fs");
const client = new Client({ intents: [GatewayIntentBits.Guilds] });
const { REST } = require('@discordjs/rest');
const ms = require("ms")

const commands = [];
const commandFiles = fs.readdirSync('./commands').filter(file => file.endsWith('.js'));

const clientId = '1008503075243298831';

for (const file of commandFiles) {
	const command = require(`./commands/${file}`);
	commands.push(command.data);
    console.log(`[+] Registering ${command.data.name}`)
}

const rest = new REST({ version: '10' }).setToken(token);

(async () => {
	try {
		console.log('[~] Started refreshing application (/) commands.');

		await rest.put(
			Routes.applicationCommands(clientId),
			{ body: commands },
		);

		console.log('[+] Successfully reloaded application (/) commands.');
	} catch (error) {
		console.error(error);
	}
})();

client.once("ready", () => {
    console.log(`[!] Initiated ${client.user.username}`);
    console.log("[~] Setting bot settings");
    try {
        const { data } = require("./data.json")
        client.user.setStatus(data.status)
        client.user.setPresence({ activities: [{name: data.precenseText}]});
        //client.user.setAvatar("./luna.png")
    } catch (err) {
        console.error(err)
    }
    console.log("[+] Success!")
});

client.on('interactionCreate', async interaction => {
    if (!interaction.isChatInputCommand()) return;

    const sendMsg = (msg, channelId) => {
        client.channels.cache.get(channelId).send(msg);
    };
    
    switch (interaction.commandName) {
        case "suggest":
            const gameLink = interaction.options.getString("link");
            const features = interaction.options.getString("features");
    
            if (gameLink && features) {
                if (interaction.channelId == "1014588899655417959") {
                    try {
                        const sEmbed = new EmbedBuilder()
                        .setColor("Blurple")
                        .setTitle("Luna Suggestion")
                        .setDescription(`${interaction.user.username} has suggested a game.`)
                        .addFields({ name: 'Game Link', value: gameLink, inline: true }, { name: 'Features', value: features, inline: true });
                        await interaction.reply({content: `Thank you for suggesting - Luna Team.\nGame Link Suggested: <${gameLink}>`, ephemeral: false});
    
                        sendMsg({embeds: [sEmbed], content: "New suggestion."}, "1008518373216370778");
                    } catch (err) {
                        interaction.reply("There was an error making this interaction, please send this to kura.");
                        console.error(err)
                    }
                } else {
                    await interaction.reply({content: "Wrong channel to suggest, please suggest in <#998345882506379284>.", ephemeral: true});
                }
            } else {
                await interaction.reply({content: "there was a problem making this interaction, please send this to kura.", ephemeral: true});
            }
            break;
        case "roleadd":
            const role = interaction.options.getRole("role");
            const user = interaction.options.getMember("user");
            const userv = interaction.options.getUser("user")

            if (role && user) {
                try {
                    if (interaction.member.permissions.has(PermissionsBitField.Flags.ManageRoles)) {
                        if (interaction.member.roles.cache.some(r => r.name != role.name)) {
                            user.roles.add(role);
                            await interaction.reply({content: `Successfully gave ${role.name} to ${userv.username}.`, ephemeral: true})
                            
                        }
                    } else {
                        await interaction.reply({content: "You don't have the permissions for that.", ephemeral: true});
                    }
                } catch (err) {
                    await interaction.reply("There was an error making this interaction, please send this to kura.");
                    console.error(err)
                }
            } else {
                await interaction.reply({content: "there was a problem making this interaction, please send this to kura.", ephemeral: false});
            }

            break;
        case "botinfo":
            let totalSeconds = (client.uptime / 1000);
            let days = Math.floor(totalSeconds / 86400);
            totalSeconds %= 86400;
            let hours = Math.floor(totalSeconds / 3600);
            totalSeconds %= 3600;
            let minutes = Math.floor(totalSeconds / 60);
            let seconds = Math.floor(totalSeconds % 60);

            try {
                let uptime = `${seconds} seconds`;
                if (minutes > 0) {
                    uptime = `${minutes} minutes and ${seconds} seconds`;

                    if (hours > 0) {
                        uptime = `${hours} hours, ${minutes} minutes and ${seconds} seconds`;
                    }

                    if (days > 0) {
                        uptime = `${days} days, ${hours} hours, ${minutes} minutes and ${seconds} seconds`;
                    }
                }

                
                const bEmbed = new EmbedBuilder()
                .setColor("Blurple")
                .setTitle("Luna Bot Info")
                .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                .setThumbnail(interaction.guild.iconURL())
                .setDescription(`${interaction.user.username} has requested to see bot info`)
                .addFields({ name: 'Uptime', value: `${uptime}`, inline: true },
                    { name: 'Ping', value: `${Math.round(client.ws.ping)}ms`, inline: true },
                    { name: 'Bot Owner', value: "<@877231123476906035>", inline: true },
                    { name: 'Members', value: `${interaction.guild.memberCount}`, inline: true },
                    { name: "Discord Owner", value: `<@${interaction.guild.ownerId}>`, inline: true}
                    )

                interaction.reply({embeds: [bEmbed], content: "", ephemeral: false});

            } catch (err) {
                await interaction.reply("There was an error making this interaction. please send this to kura.");
                console.error(err);
            }
            break;
        case "ban":
            const bUser = interaction.options.getUser("user");
            const reason = interaction.options.getString("reason");
            const bMem = interaction.options.getMember("user")
            let date = new Date();
            let dateContent = date.getDate() + '/' + date.getMonth() + '/' + date.getFullYear();
            let timeContent = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
            if (bUser && reason) {
                try {
                    if (interaction.member.permissions.has(PermissionsBitField.Flags.BanMembers) && bMem.bannable != null && bMem.bannable) {
                        const banEmbed = new EmbedBuilder()
                        .setColor("Blurple")
                        .setTitle("Luna Bot Logs")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`${interaction.user.username} has banned a user`)
                        .addFields({name: "Information", value:
                        `
                        **Time:** ${timeContent}
                        **Date:** ${dateContent}
                        **Reason:** ${reason}
                        **User Banned:** ${bUser.username}
                        **UserID:** ${bUser.id}
                        `, inline: true});

                        const dmResp = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`You've been banned from ${interaction.guild.name} because ${reason}`);

                        const bResponse = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`${bUser.username} was successfully banned.`);
                        
                        await bUser.send({embeds: [dmResp], content: `Hello, <@${bUser.id}>`}).then(() => {
                            bMem.ban({days: 0, reason: reason}).then(() => {
                                sendMsg({embeds: [banEmbed], content: "", ephemeral: false}, "1009925606571507753");
                                interaction.reply({embeds: [bResponse], content: "", ephemeral: false});
                            })
                        })

                    } else {
                        await interaction.reply("You don't have the permissions for that.");
                    }
                    
                } catch (err) {
                    await interaction.reply("there was an error making this interaction, please send this to kura.");
                    console.error(err)
                }
            } else {
                await interaction.reply("there was an error making this interaction, please send this to kura.");
            }
            break;
        case "kick":
            const kUser = interaction.options.getUser("user");
            const kReason = interaction.options.getString("reason");
            const kMem = interaction.options.getMember("user");
            let date1 = new Date();
            let dateContent1 = date1.getDate() + '/' + date1.getMonth() + '/' + date1.getFullYear();
            let timeContent1 = date1.getHours() + ":" + date1.getMinutes() + ":" + date1.getSeconds();
            if (kUser && kReason) {
                try {
                    if (interaction.member.permissions.has(PermissionsBitField.Flags.KickMembers) && kMem.kickable != null && kMem.kickable) {
                        const kEmbed = new EmbedBuilder()
                        .setColor("Blurple")
                        .setTitle("Luna Bot Logs")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`${interaction.user.username} has kicked a user`)
                        .addFields({name: "Information", value:
                        `
                        **Time:** ${timeContent1}
                        **Date:** ${dateContent1}
                        **Reason:** ${kReason}
                        **User Kicked:** ${kUser.username}
                        **UserID:** ${kUser.id}
                        `, inline: true});
                        const kResponse = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`${kUser.username} was successfully kicked.`);

                        const dmRespk = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`You've been kicked from ${interaction.guild.name} because ${kReason}`);

                        await kUser.send({embeds: [dmRespk], content: `Hello, <@${kUser.id}>`}).then(() => {
                            interaction.guild.members.kick(kUser, kReason).then(() => {
                                sendMsg({embeds: [kEmbed], content: "", ephemeral: false}, "1009925606571507753");
                                interaction.reply({embeds: [kResponse], content: "", ephemeral: false});
                            })
                        })
                        
                    } else {
                        await interaction.reply("You don't have the permissions for that.");
                    }
                    
                } catch (err) {
                    await interaction.reply("there was an error making this interaction, please send this to kura.");
                    console.error(err);
                }
            } else {
                await interaction.reply("there was an error making this interaction, please send this to kura.");
            }
            break;
        case "unban":
            const id = interaction.options.getString("user")
            const uReason = interaction.options.getString("reason")

            if (id && uReason) {

                try {
                    let userName = null

                    client.users.fetch(id).then(user => userName = user.username)

                    let date2 = new Date();
                    let dateContent2 = date2.getDate() + '/' + date2.getMonth() + '/' + date2.getFullYear();
                    let timeContent2 = date2.getHours() + ":" + date2.getMinutes() + ":" + date2.getSeconds();
                    
                    if (interaction.member.permissions.has(PermissionsBitField.Flags.KickMembers)) {
                        const uEmbed = new EmbedBuilder()
                        .setColor("Blurple")
                        .setTitle("Luna Bot Logs")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`${interaction.user.username} has unbanned a user`)
                        .addFields({name: "Information", value:
                        `
                        **Time:** ${timeContent2}
                        **Date:** ${dateContent2}
                        **Reason:** ${uReason}
                        **User Unbanned:** ${userName}
                        **UserID:** ${id}
                        `, inline: true});

                        const uResponse = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`${userName} was successfully unbanned.`);

                        await interaction.guild.members.unban(id).then(() => {
                            sendMsg({embeds: [uEmbed], content: "", ephemeral: false}, "1009925606571507753");
                            interaction.reply({embeds: [uResponse], content: "", ephemeral: false});
                        })

                    } else {
                        await interaction.reply("You don't have the permissions for that.");
                    }

                } catch (err) {
                    await interaction.reply("there was an error making this interaction, please send this to kura.");
                    console.error(err);
                }

            } else {
                await interaction.reply("there was an error making this interaction, please send this to kura.")
            }
            break;
        case "setpresence":
            const text = interaction.options.getString("text")

            if (text) {
                try {
                    if (interaction.member.id == "877231123476906035" || interaction.member.id == "756911615018008596" || interaction.member.id == "786682781019144194" || interaction.member.id == "1007372467226038354") {

                        const tResponse = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription("Successfully changed presence.");

                        await interaction.reply({embeds: [tResponse], content: "", ephemeral: false});
                        client.user.setPresence({ activities: [{name: text}]});

                    } else {
                        await interaction.reply("You don't have the permission to set the bot's presence.");
                    }
                } catch (err) {
                    await interaction.reply("there was an error making this interaction, please send this to kura.");
                    console.error(err);
                }
            } else { 
                await interaction.reply("there was an error making this interaction, please send this to kura.")
            }
            break;
        case "setstatus":
            const r = interaction.options.getString("status")

            if (r) {
                try {
                    if (interaction.member.id == "877231123476906035" || interaction.member.id == "756911615018008596" || interaction.member.id == "786682781019144194" || interaction.member.id == "1007372467226038354") {
                        const rResponse = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription("Successfully changed status.");

                        await interaction.reply({embeds: [rResponse], content: "", ephemeral: false});
                        client.user.setStatus(r);
                    } else {
                        await interaction.reply("You don't have the permission to set the bot's presence.");
                    }
                } catch (err) {
                    await interaction.reply("there was an error making this interaction, please send this to kura.");
                    console.error(err);
                }
            } else { 
                await interaction.reply("there was an error making this interaction, please send this to kura.");
            }
            break;
        case "timeout":
            const userTime = interaction.options.getMember("user");
            const userTime2 = interaction.options.getUser("user");
            const length = interaction.options.getString("time");
            const tReason = interaction.options.getString("reason");
            const newNum = ms(length);

            let date3 = new Date();
            let dateContent3 = date3.getDate() + '/' + date3.getMonth() + '/' + date3.getFullYear();
            let timeContent3 = date3.getHours() + ":" + date3.getMinutes() + ":" + date3.getSeconds();
            if (userTime && length) {
                try {
                    if (interaction.member.permissions.has(PermissionsBitField.Flags.Administrator)) {
                        const timeResponse = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`Successfully timed out ${userTime2.username}.`);

                        const response = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`You've been timed out from ${interaction.guild.name} because ${tReason}`);
    
                        const timeEmbed = new EmbedBuilder()
                            .setColor("Blurple")
                            .setTitle("Luna Bot Logs")
                            .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                            .setThumbnail(interaction.guild.iconURL())
                            .setDescription(`${interaction.user.username} has timed out a user`)
                            .addFields({name: "Information", value:
                            `
                            **Time:** ${timeContent3}
                            **Date:** ${dateContent3}
                            **Reason:** ${tReason}
                            **User Timed Out:** ${userTime2.username}
                            **UserID:** ${userTime2.id}
                            `, inline: true});
                        userTime.timeout(newNum, tReason).then(userTime.send({embeds: [response], content: `Hello, <@${userTime2.id}>`}).then(() => {
                            interaction.reply({embeds: [timeResponse], content: "", ephemeral: false});
                            sendMsg({embeds: [timeEmbed], content: "", ephemeral: false}, "1009925606571507753");
                        }))
                    }
                    
                } catch (err) {
                    await interaction.reply("there was an error making this interaction, please send this to kura.");
                    console.error(err);
                }
            } else {
                await interaction.reply("there was an error making this interaction, please send this to kura.");
            }
            break;
        case "untimeout":
            const userUntime = interaction.options.getMember("user");
            const userUntime2 = interaction.options.getUser("user")
            const unReason = interaction.options.getString("reason");
            let date4 = new Date();
            let dateContent4 = date4.getDate() + '/' + date4.getMonth() + '/' + date4.getFullYear();
            let timeContent4 = date4.getHours() + ":" + date4.getMinutes() + ":" + date4.getSeconds();

            if (userUntime && unReason) {
                try {
                    if (interaction.member.permissions.has(PermissionsBitField.Flags.Administrator)) {
                        const untimeResponse = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`Successfully untimed out ${userUntime2.username}.`);

                        const unresponse = new EmbedBuilder()
                        .setColor("Blurple")
                        .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                        .setThumbnail(interaction.guild.iconURL())
                        .setDescription(`You've been untimed out from ${interaction.guild.name} because ${unReason}`);
    
                        const untimeEmbed = new EmbedBuilder()
                            .setColor("Blurple")
                            .setTitle("Luna Bot Logs")
                            .setAuthor({name: interaction.guild.name, iconURL: interaction.guild.iconURL(), url: "https://lunahub.cf"})
                            .setThumbnail(interaction.guild.iconURL())
                            .setDescription(`${interaction.user.username} has untimed out a user`)
                            .addFields({name: "Information", value:
                            `
                            **Time:** ${timeContent4}
                            **Date:** ${dateContent4}
                            **Reason:** ${unReason}
                            **User Untimed Out:** ${userUntime2.username}
                            **UserID:** ${userUntime2.id}
                            `, inline: true});

                        userUntime.timeout(null, unReason).then(userUntime.send({embeds: [unresponse], content: `Hello, <@${userUntime2.id}>`}).then(() => {
                            interaction.reply({embeds: [untimeResponse], content: "", ephemeral: false});
                            sendMsg({embeds: [untimeEmbed], content: "", ephemeral: false}, "1009925606571507753");
                        }))
                    }
                } catch (err) {
                    await interaction.reply("there was an error making this interaction, please send this to kura.");
                    console.error(err);
                }
            } else {
                await interaction.reply("there was an error making this interaction, please send this to kura.");

            }
    }
})

client.login(token)