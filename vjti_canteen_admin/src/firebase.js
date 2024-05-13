import { initializeApp } from 'firebase/app';
import { getFirestore } from '@firebase/firestore';

const firebaseConfig = {
  apiKey: "AIzaSyC5CtNfv7hQpUdBqVk1NpCa4ohMGPkrcEs",
      authDomain: "canteen-vjti.firebaseapp.com",
      projectId: "canteen-vjti",
      storageBucket: "canteen-vjti.appspot.com",
      messagingSenderId: "669007152872",
      appId: "1:669007152872:web:b8a4077bf5a868013a6b5d"
};

const app = initializeApp(firebaseConfig);

export const db = getFirestore(app);
