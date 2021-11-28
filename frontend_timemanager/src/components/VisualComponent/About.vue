<template>
  <div class="wrapper">
    <div class="question_wrapper">
      <div class="question">
        Unable to have access to your computer to enter your hours?
      </div>
      <div class="answer">
        No worry! Download our mobile app to log in from anywhere.
      </div>
    </div>
    <div class="question_wrapper">
      <div class="question">
        Deficient vision?
      </div>
      <div class="answer">
        Our app is hightly compatible with screen reader.
      </div>
    </div>
    <p class="paragraph">
      Thanks to the TimeManager app you will now be able to visualize everything concerning your workingtimes. No more overtime that goes under the radar, no more weird scheduling etc...
      <br/><br/>
      Let's say you have already work 2 night shift in a row. Thanks to calendar you and your manager will now be able to see it with precision and ease. In the past your manager could assign 3 night shift in a row to you, all of this because he didn't know you already worked the other day too.
      <img src="../../assets/illustration/calendar_screenshot.png" class="screenshot">
      <br/><br/>
      This app is not used against but FOR you !
      <br/><br/>
      As for the manager and direction, the charts visible on this app are a great help. Thanks to this you will be able to see real live data on how much your team worked. Again with precision and ease !
      <img src="../../assets/illustration/chart_screenshot.png" class="screenshot">
      <br/><br/>
      Another chart is available to count working hours, thanks to this, overtime will be visible easily. No more unpaind overtime !
      <img src="../../assets/illustration/chart2_screenshot.png" class="screenshot">

    </p>
  </div>
</template>

<script>
export default {
  name: "About"
}
</script>

<style scoped>
  .question_wrapper {
    margin-top: 2em;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }
  .question {
    font-weight: bold;
    font-size: 1.2em;
  }
  .answer {

  }
  .paragraph {
    font-weight: 600;
    margin-top: 2em;
    max-width: 70vw;
  }
  .screenshot {
    width: 70vw;
  }
</style>