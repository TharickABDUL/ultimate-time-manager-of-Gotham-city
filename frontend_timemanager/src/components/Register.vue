<template>
  <div class="wrapper">
      <H2>Register</H2>
      <div class="wrapper">
        <input type="text" name="username" v-model="username" placeholder="Username">
        <input type="email" name="email" v-model="email" placeholder="Email">
        <input type="password" name="pass" v-model="pass" placeholder="Password">
        <button @click="register()">Register</button>
      </div>
  </div>
</template>

<script>


import UserService from "@/services/user.service";

const userService = new UserService();

export default {
  name: "Register",
  components: {
  },
  data() {
    return {
      email : '',
			pass : '',
      username: ''
    }
  },
  mounted() {
  },
  methods: {
    async register(){
      var ctx = this;
			let login_info = {
        'user':
          {
          'username' : ctx.username,
          'email' : ctx.email,
          'password' : ctx.pass,
          'role_id': 3 //when created you'r a simple worker
        }
      };

			userService.register(login_info).then(function(response,err){
        if(err) console.log(err)
        else{
          ctx.$router.push('/users/login');
        }
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