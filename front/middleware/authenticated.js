// 未ログイン状態のリダイレクト処理
export default function ({ store, redirect }) {
  if (!store.getters['modules/user/isAuthenticated']) {
    return redirect('/auth/signin')
  }
}