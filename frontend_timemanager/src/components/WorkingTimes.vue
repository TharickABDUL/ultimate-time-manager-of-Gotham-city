<template>
  <div>
    <vue-cal
        style="height: 70vh"
        :time-step="30"
        :events="events"
        :disable-views="['years', 'year']"
    />
    <button v-on:click="showWorkingTimes" class="refresh">Refresh</button>
    <!--<div>{{posts}}</div>-->
    <WorkingTime
        v-bind:user="user"
    ></WorkingTime>
    <Alert
        class="alert"
        v-bind:message="errorMessage"
        v-if="errorMessage !== ''"
        v-on:close="removeErrorMessage"
    ></Alert>
  </div>
</template>


<script>

import WorkingTimesService from "@/services/workingtimes.service";
import WorkingTime from "@/components/WorkingTime";
import VueCal from 'vue-cal'
import 'vue-cal/dist/vuecal.css'
import Alert from "@/components/VisualComponent/Alert";
const workingTimesService = new WorkingTimesService()


export default {
  data() {
    return {
      posts: [],
      errors: [],
      events: [],
      errorMessage: ''
    }
  },
  components: {
    WorkingTime,
    VueCal,
    Alert
  },
  props: {
    user: Object
  },
  methods: {
    removeErrorMessage: function () {
      this.errorMessage = ''
    },
    treatData(data) {
      this.events = [];
      console.log(data);
      const ctx = this;
      data.forEach((record)=> {
        const event = {
          start: new Date(record.start),
          end: new Date(record.end),
          id: record.id,
          title: 'Work: ' + record.id,
          class: 'work'
        };
        ctx.events.push(event)
      })
      console.log(this.events)
    },
    getWorkingTimes() {
      workingTimesService.get(this.user.userID).then((data) => {
        console.log(this.user.userID)
        console.log(data)
        this.posts = data.data.data
        this.treatData(data.data.data);
      }, (error) => {
        console.log(error);
      })
    },
    showWorkingTimes() {
      this.getWorkingTimes()
    }

  },

// Fetches posts when the component is created.
  created() {
    this.getWorkingTimes()
  }

}


</script>

<style scoped>

.refresh {
  margin: 1em 0;
}
</style>