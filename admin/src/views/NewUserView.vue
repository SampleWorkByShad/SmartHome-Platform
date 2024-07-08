<script setup>
import { reactive } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const { idToken } = useAuthStore()

const user = reactive({})

const router = useRouter()

const submit = () => {
  const formData = new FormData()
  Object.keys(user).forEach(k => formData.append(`user[${k}]`, user[k]))
  const headers = { Authorization: `Bearer ${idToken}` }
  fetch(`http://localhost:3000/users`, {
    method: 'post',
    headers: headers,
    body: formData
  }).then((data) => data.json())
    .then((data) => {
      router.push({ name: 'user', params: { id: data.id } })
    })
}
</script>

<template>
  <div class="mx-auto max-w-screen-2xl p-4 md:p-6 2xl:p-10">
    <div class="rounded-sm border border-stroke bg-white shadow-default dark:border-strokedark dark:bg-boxdark">
      <div class="border-b border-stroke px-6.5 py-4 dark:border-strokedark">
        <h3 class="font-medium text-black dark:text-white">
          New User
        </h3>
      </div>
      <form @submit.prevent="submit">
        <div class="p-6.5">
          <div class="mb-4.5">
            <label class="mb-3 block text-sm font-medium text-black dark:text-white">
              Name
            </label>
            <input type="text" v-model="user.name" placeholder="Enter your full name"
              class="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 font-normal text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary" />
          </div>

          <div class="mb-4.5">
            <label class="mb-3 block text-sm font-medium text-black dark:text-white">
              Username
            </label>
            <input type="text" v-model="user.username" placeholder="Enter your username"
              class="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 font-normal text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary" />
          </div>

          <div class="mb-4.5">
            <label class="mb-3 block text-sm font-medium text-black dark:text-white">
              Email
            </label>
            <input type="email" v-model="user.email" placeholder="Enter your email address"
              class="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 font-normal text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary" />
          </div>

          <div class="mb-4.5">
            <label class="mb-3 block text-sm font-medium text-black dark:text-white">
              Password
            </label>
            <input type="password" v-model="user.password" placeholder="Enter password" autocomplete="password"
              class="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 font-normal text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary" />
          </div>

          <div class="mb-5.5">
            <label class="mb-3 block text-sm font-medium text-black dark:text-white">
              Re-type Password
            </label>
            <input type="password" v-model="user.password_confirmation" placeholder="Re-enter password"
              autocomplete="re-enter-password"
              class="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 font-normal text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary" />
          </div>

          <button class="flex w-full justify-center rounded bg-primary p-3 font-medium text-gray hover:bg-opacity-90">
            Create
          </button>
        </div>
      </form>
    </div>
  </div>
</template>