export const state = () => ({
  data: {},
  gadgets: {}
})

export const getters = {
  data(state) {
    return state.data
  },
  gadgets(state) {
    return state.gadgets
  }
}

export const actions = {
  ////////////////
  // 詳細ページ用 //
  ////////////////
  setData ({ commit }, payload) {
    commit('setData', payload)
  },
  reloadGadgetByEditGadget ({ commit }, gadget) {
    commit('reloadGadgetByEditGadget', gadget)
  },

  ////////////////
  // 一覧ページ用 //
  ////////////////
  setGadgets ({ commit }, gadgets) {
    commit('setGadgets', gadgets)
  },
  reloadGadgetsByCreateGadget ({ commit }, gadget) {
    commit('reloadGadgetsByCreateGadget', gadget)
  },
  reloadGadgetsByEditGadget ({ commit }, gadgetId) {
    commit('reloadGadgetsByEditGadget', gadgetId)
  },
  reloadGadgetsByDeleteGadget ({ commit }, gadgetId) {
    commit('reloadGadgetsByDeleteGadget', gadgetId)
  },
  reloadGadgetsByPageScrolling ({ commit }, gadgets) {
    commit('reloadGadgetsByPageScrolling', gadgets)
  },
}

export const mutations = {
  ////////////////
  // 詳細ページ用 //
  ////////////////
  setData (state, payload) {
    state.data = payload
  },
  reloadGadgetByEditGadget (state, gadget) {
    state.data.images_url = gadget.images_url
    state.data.title = gadget.title
    state.data.good_description = gadget.good_description
    state.data.bad_description = gadget.bad_description
    state.data.stars = gadget.stars
    state.data.tags = gadget.tags
  },

  ////////////////
  // 一覧ページ用 //
  ////////////////
  setGadgets (state, payload) {
    state.gadgets = payload
  },
  reloadGadgetsByCreateGadget (state, gadget) {
    state.gadgets.unshift(gadget)
  },
  reloadGadgetsByEditGadget (state, gadget) {
    state.gadgets.forEach(p => {
      if (p.id === gadget.id) {
        p.images_url = gadget.images_url
        p.title = gadget.title
        p.good_description = gadget.good_description
        p.bad_description = gadget.bad_description
        p.stars = gadget.stars
        p.tags = gadget.tags
      }
    })
  },
  reloadGadgetsByDeleteGadget (state, gadgetId) {
    state.gadgets.forEach((p, index) => {
      if (p.id === gadgetId) {
        state.gadgets.splice(index, 1)
      }
    })
  },
  reloadGadgetsByPageScrolling (state, gadgets) {
    gadgets.forEach(gadget => {
      state.gadgets.push(gadget)
    })
  }
}