require("dotenv").config();
const express = require('express')
const app = express()

const PORT = process.env.PORT || 3000;

//Connect to DB
const admin = require('firebase-admin');

// Initialize Firebase Admin SDK
try {

    // Parse the JSON string from the environment variable
    const serviceAccount = process.env.ENV === 'prod' ? JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT) : require('./serviceAccountKey.json');

    // Initialize Firebase Admin SDK
    admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });

    console.log("Firebase Admin SDK initialized successfully!");
} catch (error) {
    console.error("Error parsing service account JSON:", error.message);
}

const firestore = admin.firestore(); // Firestore Database Reference

// configuration
app.set("view engine", "ejs")
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.get('/', (req, res) => res.send('Welcome to Tele Prime Admin Portal!'))

app.get('/add', (req, res) => res.render('home'))

app.post('/add', async (req, res) => {
    let { displayName, userName, image } = req.body

    if (!(displayName && userName && image)) {
        return res.status(400).json({ 'status': false, 'error': 'All fields are required!' })
    }

    const newBot = { displayName, userName, image };

    try {
        const docRef = await firestore.collection('bots').add(newBot); // 'bots' is the Firestore collection
        console.log(`Bot added with ID: ${docRef.id}`);
        return res.status(200).json({ 'status': true, 'message': 'Successfully created the Bot' })
    } catch (error) {
        console.error("Error adding document: ", error);
        return res.status(400).json({ 'status': false, 'error': 'Bot creation failed!' })
    }
})

// GET Endpoint to fetch the list of bots
app.get('/bots', async (req, res) => {
    try {
        const botsRef = firestore.collection('bots'); // 'bots' is the Firestore collection name
        const snapshot = await botsRef.get();

        if (snapshot.empty) {
            return res.status(200).json({ 'status': true, 'message': 'Success', 'data': [] });
        }

        const botsList = snapshot.docs.map(doc => ({
            id: doc.id, // Document ID
            ...doc.data(), // Document Data
        }));

        res.status(200).json({ 'status': true, 'message': 'Success', 'data': botsList }); // Respond with the bots list
    } catch (error) {
        console.error('Error fetching bots:', error);
        res.status(500).json({ 'status': false, 'error': 'Failed to fetch bots' });
    }
});

app.listen(PORT, () => console.log(`Tele Prime app listening on port ${PORT}!`))