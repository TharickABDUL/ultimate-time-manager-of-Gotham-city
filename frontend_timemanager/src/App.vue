<template>
  <div>
    <Header
      v-bind:user="user"
      v-on:logout="logout"
    >
    </Header>
    <router-view
      v-bind:user="user"
      v-on:setUser="setUser"
      v-on:logout="logout"
    ></router-view>
  </div>
</template>

<script>
import Header from "@/components/VisualComponent/Header";
import http from '@/services/api.service';
export default {
  name: 'App',
  data() {
    return {
      user: null
    }
  },
  mounted() {
    this.setUser();
  },
  components: {
    Header,
  },
  methods: {
    logout: function () {
      localStorage.removeItem('jwt')
      this.setUser()
      this.$router.push('/')
    },
    setUser(){
      let jwt = localStorage.getItem("jwt");
      if(jwt == null){
        delete http.defaults.headers.common["Authorization"];
        this.user = null
      }else{
        http.defaults.headers.common['Authorization']= "Bearer "+ jwt;
        http.get('users/me').then(data => {
          console.log(data) 
          this.user = {
            userID : data.data.id,
            email : data.data.email,
            username : data.data.username,
            role : data.data.role.id,
            teams : data.data.teams
          };
        }).catch(err =>{
          console.log(err)
        });        
      }
    },
    getUser(){
      return this.user;
    }
  }
}

</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;

}
</style>
