import {getUserFromCookie, getUserFromSession} from '@/helpers'

export const actions = {

  async nuxtServerInit ({ dispatch }, { req }) {
    const user = getUserFromCookie(req)
    if (user) {
      await dispatch('modules/user/setUser', { email: user.email, uid: user.user_id })
      await dispatch('modules/user/loadData', user.user_id )
    }
  }
}
