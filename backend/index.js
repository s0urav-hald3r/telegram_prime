require("dotenv").config();
const express = require('express')
const app = express()

const PORT = process.env.PORT || 3000;

//Connect to DB
const admin = require('firebase-admin');
// Import FieldPath if not already imported
const { FieldPath } = require('firebase-admin/firestore');

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
    let { displayName, userName, description, image } = req.body

    if (!(displayName && userName && image)) {
        return res.status(400).json({ 'status': false, 'error': 'All fields are required!' })
    }

    const newBot = { displayName, userName, description, image };

    try {
        const docRef = await firestore.collection('bots').add(newBot); // 'bots' is the Firestore collection
        console.log(`Bot added with ID: ${docRef.id}`);
        return res.status(200).json({ 'status': true, 'message': 'Successfully created the Bot' })
    } catch (error) {
        console.error("Error adding document: ", error);
        return res.status(400).json({ 'status': false, 'error': 'Bot creation failed!' })
    }
})

app.get('/bots', async (req, res) => {
    let { cursor } = req.query;

    try {
        let query = firestore.collection('bots').orderBy(FieldPath.documentId()).limit(10);

        // If cursor is provided, use it to fetch the next set of documents
        if (cursor) {
            query = query.startAfter(cursor); // Pass the cursor from the previous request
        }

        const snapshot = await query.get();

        if (snapshot.empty) {
            return res.status(200).json({ 'status': true, 'message': 'No more data', 'data': [] });
        }

        // Map the documents to the response format
        const botsList = snapshot.docs.map(doc => ({
            id: doc.id,
            ...doc.data(),
        }));

        // Get the cursor for the next page (last document in the current page)
        const lastCursor = snapshot.docs[snapshot.docs.length - 1];

        res.status(200).json({
            'status': true,
            'message': 'Success',
            'data': botsList,
            'lastCursor': lastCursor ? lastCursor.id : null, // Pass the ID or other cursor value,
        });
    } catch (error) {
        console.error('Error fetching bots:', error);
        res.status(500).json({ 'status': false, 'error': 'Failed to fetch bots' });
    }
});

app.listen(PORT, () => console.log(`Tele Prime app listening on port ${PORT}!`))