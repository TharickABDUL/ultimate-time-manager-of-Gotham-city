<template>
  <div class="wrapper">
    <div class="wrapper_line">
      <div><img src="../../assets/illustration/time_management.svg"></div>
      <div>
        <h2>
          Welcome to time manager!
        </h2>
        <p>
          Time manager is not the 1st app to manage your worker's time, but in a modest way the best!
        </p>
        <p>Want to learn more about our app?
          <router-link :to="{ name: 'About' }" class="router-link" style="font-weight: bold">Click Here!</router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "LandingPage"
}
</script>

<style scoped>
    .wrapper {
      height: 100vh;
      justify-content: center;
    }

  .wrapper_line {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    width: 100vw;
  }
  .wrapper_line > div {
    width: 50vw;
  }
</style>