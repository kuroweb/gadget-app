import {getUserFromCookie, getUserFromSession} from '@/helpers'

export const actions = {

  async nuxtServerInit ({ dispatch }, { req }) {
    const user = getUserFromCookie(req)
    if (user) {
      await dispatch('modules/user/setUSER', { email: user.email, uid: user.user_id })
      await dispatch('modules/user/loadUSERDATA', user.user_id )
    }
  }
}
