exports.sendSupportRequest = onCall({ region: "asia-south1"}, async (request) => {

    const db = admin.firestore();
    var data = request.data;

    await db.collection('support_requests')
        .add({
            to: ["sidhdhi.p@canopas.com", "mayank.v@canopas.com"],
            template: {
                name: "support_request",
                data: {
                    request: data
                },
            },
        }).then(() => console.log('Queued email for delivery!'));

});