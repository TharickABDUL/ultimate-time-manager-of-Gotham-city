<template>
  <div class="wrapper">
    <H2>Profil</H2>
    <div class="wrapper">
      <input v-model="inputUsername" :placeholder="user.username" />
      <input v-model="inputEmail" :placeholder="user.email" />
      <h4>
        Put your old password or a new to change it
      </h4> 
      <input v-model="inputPass" placeholder="Password"/>
      
      <button @click="updateUser()">Update</button>
      <button @click="deleteUser()">Delete</button>
    </div>
  </div>

</template>

<script>


import UserService from "@/services/user.service";


const userService = new UserService();

export default {
  name: "User",
  components: {
  },
  data() {
    return {
      inputUsername: this.user.username,
      inputEmail:this.user.email,
      inputPass : ""
    }
  },
  mounted() {
  },
  props: {
    user: Object
  },
  methods: {
    updateUser() {

      let user = {
        "user": {
          "username": this.inputUsername,
          "email": this.inputEmail,
          "password":this.inputPass
        }
      };
      userService.update(user, this.user.userID).then((data) => {
        console.log(data)
      });

    },

    deleteUser() {
      userService.delete(this.user.userID).then((data) => {
        console.log(data);
        this.$emit('logout');
      });
    }
  },
}

</script>

<style scoped>
  button, input {
    margin-top: 1em;
  }

</style>