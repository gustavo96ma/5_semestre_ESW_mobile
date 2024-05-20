const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.myFunction = functions.firestore
    .document("salas/{idDocumento}/mensagens/{idMensagem}")
    .onCreate((snapshot, context) => {
        return admin.messaging().sendToTopic(context.params.idDocumento,
            {
                notification:{
                    title:snapshot.data()["email"],
                    body: snapshot.data()["conteudo"],
                    clickAction: "FLUTTER_NOTIFICATION_CLICK",
                },
            });
});


