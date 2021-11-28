<template>
  <div class="wrapper">
      <H2>Login</H2>
      <div class="wrapper">
        <input type="email" name="email" v-model="email" placeholder="Email">
        <input type="password" name="pass" v-model="pass" placeholder="Password">
        <button @click="login()">Login</button>
      </div>
  </div>
</template>

<script>


import UserService from "@/services/user.service";
const userService = new UserService();

export default {
  name: "Login",
  components: {
  },
  data() {
    return {
      email : '',
			pass : ''
    }
  },
  mounted() {
  },
  props: {
  },
  methods: {
    login(){
			let login_info = {
				'email' : this.email,
				'password' : this.pass
			};
      var ctx = this;
      userService.login(login_info).then(function(response,err){
        if(err) console.log(err)
        else{
          localStorage.setItem("jwt", response.data.jwt);
          ctx.$emit('setUser');
          ctx.$router.push('/')
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