const { onDocumentUpdated } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();
const messaging = admin.messaging();
exports.onteamplayerschange = onDocumentUpdated({
    document: "teams/{teamId}",
    region: "asia-south1"
}, async event => {
    const oldTeam = event.data.before.data();
    const newTeam = event.data.after.data();
    const oldPlayers = oldTeam.team_players || [];
    const newPlayers = newTeam.team_players || [];
    const addedPlayers = newPlayers.filter(player => !oldPlayers.some(oldPlayer => oldPlayer.id === player.id));
    const removedPlayers = oldPlayers.filter(player => !newPlayers.some(newPlayer => newPlayer.id === player.id));
    console.log('Added Players:', addedPlayers);
    console.log('Removed Players:', removedPlayers);
    if (addedPlayers.length > 0) {
        const playerIds = addedPlayers.map((player) => player.id);
        const userSessions = await getBatchUserSessions(playerIds);
        const tokens = userSessions.data().map((session) => session.device_fcm_token).filter(token => token != undefined);
        const payload = {
            tokens: tokens,
            notification: {
                title: "Welcome to ${newTeam.name}",
                body: "You've been added to ${newTeam.name}. Get ready to join the action and play with your new teammates!",
            },
            data: {
                teamId: newTeam.id
            }
        }
        await sendNotification(payload);
    }
    if (removedPlayers.length > 0) {
        const playerIds = removedPlayers.map((player) => player.id);
        const userSessions = await getBatchUserSessions(playerIds);
        const tokens = userSessions.data().map((session) => session.device_fcm_token).filter(token => token != undefined);
        const payload = {
            tokens: tokens,
            notification: {
                title: "You Removed from ${newTeam.name}",
                body: "You've  not longer part of ${newTeam.name} team.",
            },
            data: {
                teamId: newTeam.id
            }
        }
        await sendNotification(payload);
    }
});

async function getBatchUserSessions(playerIds) {
    const batch = db.batch();
    playerIds.forEach((playerId) => {
        batch.get(db.collection('users').doc(playerId).collection('user_sessions'));
    });
    return await batch.get();
}

async function sendNotification(payload) {
    return new Promise((resolve, reject) => {
        messaging.sendMulticast(payload)
          .then(response => {
            console.log("Successfully sent notifications:", response);
            resolve(response);
          })
          .catch(error => {
            console.error("Failed to send notifications:", error.code);
            reject(error);
          });
      });
}
