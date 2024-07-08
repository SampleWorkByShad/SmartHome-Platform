<script setup>
import { RouterLink } from 'vue-router'
import { ref, onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'

const { idToken } = useAuthStore()

const users = ref([])

onMounted(async () => {
  const headers = { Authorization: `Bearer ${idToken}` }
  users.value = await fetch('http://localhost:3000/users', { headers })
    .then((data) => data.json())
})
</script>

<template>
  <div class="mx-auto max-w-screen-2xl p-4 md:p-6 2xl:p-10">
    <div class="rounded-sm border border-stroke bg-white shadow-default dark:border-strokedark dark:bg-boxdark">
      <div class="px-4 py-6 md:px-6 xl:px-7.5">
        <h4 class="text-xl font-bold text-black dark:text-white">Top Products</h4>
      </div>

      <div
        class="grid grid-cols-6 border-t border-stroke px-4 py-4.5 dark:border-strokedark sm:grid-cols-6 md:px-6 2xl:px-7.5">
        <div class="col-span-1 flex items-center">
          <p class="font-extrabold">ID</p>
        </div>
        <div class="col-span-1 flex items-center">
          <p class="font-medium">Name</p>
        </div>
        <div class="col-span-1 flex items-center">
          <p class="font-medium">Username</p>
        </div>
        <div class="col-span-1 flex items-center">
          <p class="font-medium">Email</p>
        </div>
        <div class="col-span-1 flex items-center">
          <p class="font-medium">Created</p>
        </div>
        <div class="col-span-1 flex items-center">
        </div>
      </div>

      <div v-for="user in users" :key="user.id"
        class="grid grid-cols-6 border-t border-stroke px-4 py-4.5 dark:border-strokedark sm:grid-cols-6 md:px-6 2xl:px-7.5">
        <div class="col-span-1 flex items-center">
          <p class="text-sm font-medium">{{ user.id }}</p>
        </div>
        <div class="col-span-1 flex items-center">
          <p class="text-sm font-medium">{{ user.name }}</p>
        </div>
        <div class="col-span-1 flex items-center">
          <p class="text-sm font-medium">{{ user.username }}</p>
        </div>
        <div class="col-span-1 flex items-center">
          <p class="text-sm font-medium">{{ user.email }}</p>
        </div>
        <div class="col-span-1 flex items-center">
          <p class="text-sm font-medium">{{ user.created_at }}</p>
        </div>
        <div class="col-span-1 flex items-center space-x-5 justify-end">
          <RouterLink :to="{ name: 'user', params: { id: user.id } }" class="font-bold uppercase text-sm">Show
          </RouterLink>
          <RouterLink :to="{ name: 'user-edit', params: { id: user.id } }" class="font-bold uppercase text-sm">Edit
          </RouterLink>
        </div>
      </div>
    </div>
  </div>
</template>