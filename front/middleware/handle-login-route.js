// ログイン済み状態でのリダイレクト処理
export default function ({ store, redirect }) {
  if (store.getters['modules/user/isAuthenticated']) {
    return redirect('/')
  }
}