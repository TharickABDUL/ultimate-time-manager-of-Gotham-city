<template>
  <div class="wrapper">
      <div v-if="this.clockIn" class="wrapper">
        <div>Working</div>
        <div>Shift Started At: {{this.startTimeData}}</div>
        <button v-on:click="clock"> Clock'out </button>
      </div>
      <div v-else class="wrapper">
        <div>Dormant</div>
        <div>Last Shift Ended At: {{this.startTimeData}}</div>
        <button v-on:click="clock"> Clock'in </button>
      </div>
      <span class="time">{{ time }}</span>
  </div>
</template>

<script>
import ClockService from '@/services/clock.service'
const clockService = new ClockService(); 
export default {
  name: "ClockManager",
  props: {
    user: Object
  },
  data() {
    return{
      startTimeData : null,
      clockIn : false,
      time: '00:00:00',
      timeBegan : null,
      timeStopped : null,
      stoppedDuration : 0,
      started : null,
      running : false,
    }
  },
  methods :{
    refresh(){
      var ctx = this;
      clockService.get(this.user.userID).then(function(response){
          if(response.data.data.length > 0){
            console.log(response.data.data[response.data.data.length-1].time)
            ctx.startTimeData = response.data.data[response.data.data.length-1].time;
            ctx.clockIn = response.data.data[response.data.data.length-1].status;

            ctx.start();
          }else{
            ctx.startTimeData = null;
          }
        });
    },
    addLeadingZero(time){
      return ('0' + time).slice(-2);
    },
    currentDateTime() {
      const current = new Date();
      const date = current.getFullYear()+'-'+this.addLeadingZero(current.getMonth()+1)+'-'+this.addLeadingZero(current.getDate());
      const time = this.addLeadingZero(current.getHours()) + ":" + this.addLeadingZero(current.getMinutes()) + ":" + this.addLeadingZero(current.getSeconds());
      const dateTime = date +' '+ time;
      
      return dateTime;
    },

    clock(){
      var ctx = this;
      var curr_time = this.currentDateTime();
      var param = {
        clock :{
          time : curr_time,
          status : true //the api deals with the status already, what you put here doesn't matter
        }
      } 

      clockService.clock(this.user.userID,param,
          {
            headers: {
              'Authorization': 'Bearer '+localStorage.getItem('jwt')
            }
          }
        ).then(function(response){
        ctx.startTimeData = response.data.data.time;
        ctx.clockIn = response.data.data.status;
        ctx.start();
      }).catch(function(err){
        console.log(err)
      });
    },

    start() {
      console.log(this.clockIn);
      if(this.clockIn != true){
        this.reset();
        return;
      }

      this.started = setInterval(this.clockRunning, 10);	
    },

    reset() {
      clearInterval(this.started);
      this.time = "00:00:00";
    },

    clockRunning(){
      var start_clock = new Date(this.startTimeData);
      start_clock.setHours(start_clock.getHours() -1);
       var currentTime = new Date()
        , timeElapsed = new Date(currentTime - start_clock)
        , hour = timeElapsed.getUTCHours()
        , min = timeElapsed.getUTCMinutes()
        , sec = timeElapsed.getUTCSeconds();
      console.log(currentTime);
      console.log(timeElapsed);
      this.time = 
        this.zeroPrefix(hour,2) + ":" + 
        this.zeroPrefix(min,2) + ":" + 
        this.zeroPrefix(sec,2);
    },
    zeroPrefix(num, digit) {
      var zero = '';
      for(var i = 0; i < digit; i++) {
        zero += '0';
      }
      return (zero + num).slice(-digit);
    }


  },mounted(){
    this.refresh();
  },
  
}
</script>

<style scoped>
  button {
    margin: 1em 0;
  }
</style>