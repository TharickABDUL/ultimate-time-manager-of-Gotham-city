<template>
  <div>
    <HighChart
        v-bind:user="user"
    ></HighChart>
    <BubbleChart
      v-if="user.role == 1 || user.role == 2"
      v-bind:user="user"
    ></BubbleChart>
    <LineYearChart
      v-if="user.role == 1 || user.role == 2"    
      v-bind:user="user"
    ></LineYearChart>
  </div>
</template>

<script>

import HighChart from "@/components/Highchart";
import BubbleChart from "@/components/BubbleChart";
import LineYearChart from "@/components/LineYearChart";

export default {
  name: "ChartManager",
  components: {
    HighChart,
    BubbleChart,
    LineYearChart
  },
  props: {
    user: Object
  }
}
</script>

<style scoped>

</style>