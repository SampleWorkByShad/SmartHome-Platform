import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', {
  state: () => ({ idToken: null, state: null }),
  persist: {
    storage: sessionStorage
  }
})