<template>
  <div class="wrapper">
    <div class="teammates">
        <H2>Here are your team member</H2>
        <Multiselect
          v-model="worker"
          :options="workers"
          mode="tags"
          :closeOnSelect="false"
          :searchable="true"
          :createTag="true"
        />
        <!-- <H2>Here are the team managers</H2>
        <Multiselect
          v-model="manager"
          :options="managers"
          mode="tags"
          :closeOnSelect="false"
          :searchable="true"
          :createTag="true"
        /> -->
        <button v-if="user.role == 1 || user.role == 2" @click="Promote"> Promote </button>
        <button v-if="user.role == 1" @click="Demote"> Demote </button>
    </div>
  </div>
  <!-- <div>manage team</div> -->
</template>

<script>


import TeamService from "@/services/team.service";
const teamService = new TeamService();
import Multiselect from '@vueform/multiselect'

export default {
  
  name: "Team",
  components: {
    Multiselect
  },
  props: {
    user:Object
  },
  data() {
    return {
      workers:[],
      workers_user_id:[],
      worker: null,
      managers:[],
      managers_user_id:[],
      manager: null
    }
  },
  mounted() {
    console.log(this.user)
    if(this.user.role == 1){
      //getAllTeamMembers();
    }else{
      this.getTeamMembers();    
    }
  },
  methods: {

    getTeamMembers(){
      this.user.teams.forEach(team =>{
        teamService.get(team.id).then(response => {
        console.log(response.data.data.users)
        if(response.data.data.users.length == 0) return;
        response.data.data.users.forEach(user => {
          console.log(user)
            this.workers.push(user.username);
            this.workers_user_id.push(user.id);
        });
      });
      });
      
    },
    promote(){
      // this.worker.forEach(user =>{
      //   // var index = this.workers.indexOf(user);
      //   // userService.promote(team_user_id[index]);
      // });

      // manager.forEach(user =>{//admin can promote an other manager to admin 
      //   index = team.indexOf(user);
      //   // userService.promote(team_user_id[index]);
      // });
    },
    demote(){
      //utiliser les routes pour demote un user
      // manager.forEach(user =>{
      //   index = team.indexOf(user);
      //   // userService.demote(team_user_id[index]);
      // });
    }
  }

}

</script>
<style src="@vueform/multiselect/themes/default.css"></style>
<style scoped>
  button, input {
    margin-top: 1em;
    margin-right: 1em;
  }
</style>