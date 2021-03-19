import firebaseApp from '@/plugins/firebase'

export default function () {
  firebaseApp.auth().onAuthStateChanged(user => {
    // FirebaseAuthの認証状態を確認
  })
}