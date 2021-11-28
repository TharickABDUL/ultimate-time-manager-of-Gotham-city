<template>
  <div v-if="user.role">
    <div>Graph all user Working Time :</div>

    <highchartsWT :options="chartOptionsWT"></highchartsWT>
    <button @click="workingTimesYear()">refresh</button>
  </div>
</template>

<script>
import { Chart } from "highcharts-vue";
import WorkingTimesService from "@/services/workingtimes.service";

const workingTimesService = new WorkingTimesService();
import UserService from "@/services/user.service";

const userService = new UserService();

export default {
  name: "Chart",
  components: {
    highchartsWT: Chart,
  },
  props: {
    user: Object,
  },
  data() {
    return {
      chartOptionsWT: {
        chart: {
          type: "line",
        },
        title: {
          text: "Average Monthly Working hours",
        },
        series: [
          {
            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // sample data
            color: "red",
          },
        ],
        xAxis: {
          categories: [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
          ],
          crosshair: true,
        },
      },
      firstJanuary: "2021-01-01 00:00:00",
      users: [],
      workingTimes: [],
    };
  },
  methods: {
    addLeadingZero(time) {
      return ("0" + time).slice(-2);
    },
    knowTheNumberOfUsers() {
      var ctx = this;
      userService.get_all().then(
        function (response) {
          //ctx.users = []
          response.data.data.forEach((element) => {
            ctx.users.push(element.id);
          });
          console.log(ctx.users);
          ctx.workingTimesYear();
        },
        (error) => {
          console.log(error);
        }
      );
    },

    workingTimesYear() {
      console.log("here");
      const ctx = this;
      let myArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

      new Promise((resolve, reject) => {
        ctx.users.forEach((userUnique, index, array) => {
          workingTimesService
            .get_all(userUnique, "2021-01-01 00:00:00", "2021-12-31 23:59:59")
            .then(function (response) {
              new Promise((resolve, reject) => {
                response.data.data.forEach(
                  (data, index, array) => {
                    const startDate = new Date(data.start);
                    const endDate = new Date(data.end);
                    const month = startDate.getMonth();
                    const seconds = parseInt((endDate - startDate) / 1000);
                    const minute = parseInt(seconds / 60 / 60);
                    myArray[month] += minute;
                    if (index === array.length - 1) resolve();
                  },
                  (error) => {
                    reject(error);
                  }
                );
              })
                .then(() => {
                  if (index === array.length - 1) resolve();
                })
                .catch((error) => {
                  reject(error);
                });
            });
        });
      }).then(() => {
        console.log(myArray);
        for (let i = 0; i < myArray.length; i++) {
          myArray[i] = myArray[i] / ctx.users.length;
        }
        console.log(myArray);
        this.chartOptionsWT.series[0].data = myArray;
      });
    },
  },
  created() {
    this.knowTheNumberOfUsers();
  },
};
</script>

<style scoped>
@import "../style.css";

.wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>