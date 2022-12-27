const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.sendDiaryNotifications =
functions.firestore.document("/users/{uid}").onWrite((event, context) =>{
  const content = event.after.get("content");
  console.log(content);
});

