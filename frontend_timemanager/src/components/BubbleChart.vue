<template>
  <div>
    <highcharts :options="chartOptions"></highcharts>
  </div>
</template>

<script>


import {Chart} from 'highcharts-vue'

import UserService from "@/services/user.service";
const userService = new UserService();
import ClockService from "@/services/clock.service";
const clockservice = new ClockService();
import Highcharts from 'highcharts';
import more from 'highcharts/highcharts-more';
more(Highcharts);

export default {
  name: "Chart",
  components: {
    highcharts: Chart 
  },
  props: {
    user: Object
  },
  data() {
    return {
        chartOptions: {
          chart: {
            type: 'packedbubble',
          },
          title: {
            text: 'Connected Users'
          },
          series: [
            {
            name : "User Working ",
            data: [], // sample data
            color: "#C6C10F"
            },
            {
              name : "User Sleeping ",
              data: [], // sample data
              color: "#2c3e50"
            }
          ],
          plotOptions: {
            packedbubble: {
              minSize: '20%',
              zMin: 0,
              zMax: 1000,
              layoutAlgorithm: {
                gravitationalConstant: 0.05,
                splitSeries: true,
                seriesInteraction: false,
                dragBetweenSeries: true,
                parentNodeLimit: true
              },
              dataLabels: {
                enabled: true,
                format: '{point.name}',
                filter: {
                  property: 'y',
                  operator: '>',
                  value: 250
                },
                style: {
                  color: 'black',
                  textOutline: 'none',
                  fontWeight: 'normal'
                }
              }
            }
          },
      },
      usersdb : []
    }
  },
  methods: {
    getUserConnected(){
      this.chartOptions.series[0].data= [];
      this.chartOptions.series[1].data= [];
      var ctx = this;
      this.usersdb.forEach(user_id => {
        console.log("test")


        clockservice.get(user_id).then(function(response){
          var id = Math.max( ...response.data.data.map(o=>o.id))
          if(response.data.data.length == 0){
            ctx.chartOptions.series[1].data.push(user_id);
          }else{
            response.data.data.forEach(clock => {
              if(id == clock.id){
                if(clock.status == true){
                  ctx.chartOptions.series[0].data.push(user_id);          
                }else{
                  ctx.chartOptions.series[1].data.push(user_id);
                }
              }
            });
          }
        });
      });
    }
  },
  mounted(){
    console.log(this.user)
    var ctx = this;
    userService.get_all().then(function(response){
      let context = ctx;
      response.data.data.forEach(user => {
        context.usersdb.push(user.id);
      });
      ctx.getUserConnected();
    });
    console.log(this.usersdb)
  }
}

</script>

<style scoped>
  @import "../style.css";

  .wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
</style>