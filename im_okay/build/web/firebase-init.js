// Firebase Web initialization for ImOkay
// Generated on 2025-12-01

// eslint-disable-next-line no-unused-vars
const firebaseConfig = {
  apiKey: "AIzaSyDC64q3neG5Pwxe_Ecoq-iZCYGO6qtcydo",
  authDomain: "imokayapp-741a0.firebaseapp.com",
  databaseURL: "https://imokayapp-741a0-default-rtdb.firebaseio.com",
  projectId: "imokayapp-741a0",
  storageBucket: "imokayapp-741a0.firebasestorage.app",
  messagingSenderId: "566836508326",
  appId: "1:566836508326:web:bd31b835487758b0d6e667",
  measurementId: "G-YXCMLFX4DJ"
};

// Initialize Firebase on web if not already initialized
// eslint-disable-next-line no-undef
if (typeof firebase !== 'undefined') {
  try {
    // eslint-disable-next-line no-undef
    if (firebase.apps && firebase.apps.length === 0) {
      // eslint-disable-next-line no-undef
      firebase.initializeApp(firebaseConfig);
    }
  } catch (e) {
    // Swallow errors to avoid blocking app boot; Dart will try too
    // console.warn('Firebase init (web) error:', e);
  }
}
