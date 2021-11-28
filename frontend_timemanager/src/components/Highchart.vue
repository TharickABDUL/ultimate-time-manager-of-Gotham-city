<template>
  <div >
    <!-- Lundi <input type="text" v-bind="startingDate"> -->
    <div class="wrapper">
      <div class="margin_top">
      <input type="text" v-model="startingDate" />
      
        <button v-on:click="get_days_based_on_weeks"> Show </button>
      </div>
      <div class="margin_top">
        <select v-model="user2">
          <option :value="null">None</option>
          <option :value="user.id" v-for="user in users" :key="user.id">{{user.username}} - {{user.email}}</option>
        </select>
      </div>
      <button v-on:click="get_days_based_on_weeks"> Show </button>

    </div>

    <div class="fixed_width">
      <highcharts :options="chartOptions" class="fixed_width"
      ></highcharts>
    </div>

  </div>
</template>

<script>


import {Chart} from 'highcharts-vue'
import WorkingTimesService from "@/services/workingtimes.service";
import UserService from "@/services/user.service";

const userService = new UserService();
const workingTimesService = new WorkingTimesService();

export default {
  name: "Chart",
  components: {
    highcharts: Chart,
  },
  props: {
    user: Object
  },
  data() {
    return {
      chartOptions: {
        chart: {
          type: 'column',
        },
        title: {
          text: "Working hours comparator"
        },
        series: [{
          name : "User "+this.user.userID,
          data: [0,0,0,0,0,0,0], // sample data
          color: "#2c3e50"
        }],
        xAxis: {
          categories: [],
          crosshair: true
        },
      },
      startingDate : new Date(),
      user2 : null,
      users: []
    }
  },
  methods: {
    getUsers: function () {
      userService.get_all().then((data)=> {
        this.users = data.data.data;
      })
    },
    heure_de_travail(debut,fin,day,serie,user){
      var ctx = this;
      workingTimesService.get_all(user,debut,fin).then(function(response){
        var minute = 0;
        var work = response.data.data;
        if(work.length>0){
          work.forEach(time => {
            var startDate = Date.parse(time.start)
            var endDate = Date.parse(time.end)
            var seconds = parseInt((endDate-startDate)/1000);
            minute += parseInt((seconds/60)/60);
          });
        }
        ctx.chartOptions.series[serie].data[day] = minute;
        console.log("minute", minute)
      });
    },
    addLeadingZero(time){
      return ('0' + time).slice(-2);
    },
    get_days_based_on_weeks(){

      const dateRef = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday','Sunday'];

      let arr = dateRef.slice(new Date(this.startingDate).getDay() - 1, dateRef.length)
      arr.push.apply(arr, dateRef.slice(0, new Date(this.startingDate).getDay() -1))
      this.chartOptions.xAxis.categories = arr

      let startingDate2 = new Date(this.startingDate);

      console.log("starting date: ", startingDate2);
      for(let i = 0;i<7;i++){
        const debut =  new Date(new Date(new Date(startingDate2).setDate(startingDate2.getDate() + i)).setHours(2,0,0,0)); //-> 2 pour décalage
        const fin =  new Date(new Date(new Date(startingDate2).setDate(startingDate2.getDate() + i + 1)).setHours(2,0,0,0));

        console.log("start end", debut, fin)
        this.heure_de_travail(debut.toISOString(), fin.toISOString(),i,0,this.user.userID);
        if(this.user2 != null){
          if(this.chartOptions.series.length === 1){
            this.chartOptions.series.push({
              data: [0,0,0,0,0,0,0], // sample data
              color: "#C6C10F",
              name : "User "+this.user2
            })
          }
          this.heure_de_travail(debut.toISOString(), fin.toISOString(),i,1,this.user2);
        }
      }
      console.log("hour", this.chartOptions.series[0].data)
    },
  },
  mounted(){
    this.getUsers()
    this.get_days_based_on_weeks();
  }
}

</script>

<style scoped>
button, .margin_top {
  margin-top: 1em;
}
</style>