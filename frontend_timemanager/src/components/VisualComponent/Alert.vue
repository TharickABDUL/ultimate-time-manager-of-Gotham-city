<template>
  <div class="alert">
    <div>{{message}}</div>
    <div class="close" @click="close">
      <img src="../../assets/icon/close.png" class="close_img">
    </div>
  </div>
</template>

<script>
export default {
  name: "Alert",
  props: {
    message: String
  },
  methods: {
    close: function () {
      this.$emit('close')
    }
  }
}
</script>

<style scoped>
  .alert {
    position: relative;
    background-color: #D00000;
    border-radius: 5px;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0.5em 1em;
    width: 20vw;
    margin: 1em;
  }
  .close {
    position: absolute;
    right: 0;
    top: 0;
    transform: translate(50%, -50%);
    background-color: #D00000;
    height: 1.5em;
    width: 1.5em;
    border-radius: 25px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
  }
  .close_img {
    height: 1em;
    width: auto;
  }
</style>