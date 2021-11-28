<template>
  <div class="wrapper">
    <div>
      <input type="text" v-model="date[0]" />
      <input type="text" v-model="date[1]" />
      <button @click="createWorkingTime()">Create WorkingTime</button>
    </div>
    <div>
      <div><input v-model="inputWorkingTimeID" placeholder="id" class="input"/></div>
      <button @click="updateWorkingTime()" style="margin-right: 1em">Update the WorkingTime</button>
      <button @click="deleteWorkingTime()">Delete the WorkingTime</button>
    </div>
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
import Alert from "@/components/VisualComponent/Alert";

const workingTimeService = new WorkingTimesService()


export default {
  data() {
    return {
      inputStartTime: '',
      inputEndTime: '',
      inputWorkingTimeID: 0,
      errorMessage: '',
      date: []
    }
  },
  components: {
    Alert
  },
  props: {
    user: Object
  },
  methods: {
    removeErrorMessage: function () {
      this.errorMessage = ''
    },
    createWorkingTime: function () {
    console.log(this.date)
      if (this.date.length === 2) {
        let workingTime = {
          "workingtime": {
            "start": new Date(this.date[0]).toISOString(),
            "end": new Date(this.date[1]).toISOString()
          }
        }
        workingTimeService.create(this.user.userID, workingTime).then((data) => {
          console.log(data);
          this.inputStartTime = "";
          this.inputEndTime = "";
        }).catch((error) => {
          this.errorMessage = error;
        })
      } else {
        this.errorMessage = "Need to choose 2 dates";
      }
    },

    updateWorkingTime: function () {
      if (this.date.length === 2 && this.inputWorkingTimeID) {
        let workingTime = {
          "workingtime": {
            "start": this.date[0].toISOString(),
            "end": this.date[1].toISOString()
          }
        }
        workingTimeService.update(this.inputWorkingTimeID, workingTime).then((data) => {
          console.log(data);
          this.inputStartTime = "";
          this.inputEndTime = "";
          this.workingTimeID = 0;
        }).catch((error) => {
          console.log(workingTime);
          console.log(this.workingTimeID);
          this.errorMessage = error;
        })
      } else {
        this.errorMessage = "Need to choose 2 dates and the workingTime id";
      }
    },

    deleteWorkingTime: function () {
      if (this.inputWorkingTimeID) {
        workingTimeService.delete(this.inputWorkingTimeID).then((data) => {
          console.log(data);
          this.errorMessage = "ok";
        }).catch ((error) => {
          this.errorMessage = error;
        })
      } else {
        this.errorMessage = "Need to choose the workingTime id";
      }

    },


  }
}
</script>

<style scoped>

  button {
    margin: 1em 0;
  }

  .input {
    text-align: center;
  }
</style>