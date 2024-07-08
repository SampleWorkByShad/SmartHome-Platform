<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'

const { idToken } = useAuthStore()

const apps = ref(null)

onMounted(async () => {
  const headers = { Authorization: `Bearer ${idToken}` }
  apps.value = await fetch('http://localhost:3000/me/apps', { headers })
    .then((data) => data.json())
})
</script>

<template>
  <div class="mx-auto max-w-screen-2xl p-4 md:p-6 2xl:p-10">
    <div class="flex flex-wrap gap-12">
      <div v-for="app in apps" :key="app.id" class="flex flex-nowrap items-center space-x-5">
        <img :src="app.icon" :alt="app.name" />
        <div>
          <span class="font-bold block">{{ app.name }}</span>
          <a
            :href="`http://localhost:3000/login?client_id=${encodeURIComponent(app.client_id)}&redirect_uri=${encodeURIComponent(app.app_redirects[0].uri)}&response_type=id_token`">Login</a>
        </div>
      </div>
    </div>
  </div>
</template>
