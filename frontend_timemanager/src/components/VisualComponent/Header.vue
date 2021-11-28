<template>
  <div class="wrapper">
    <div class="fixed-width">
      <router-link :to="{ name: 'About' }" class="router-link">About</router-link>
    </div>
    <div class="fixed-width"></div>
    <router-link :to="{ name: 'Home' }" class="router-link"><div>Time Manager</div></router-link>
    <div class="fixed-width">
      <div v-if="user !== null" class="link_wrapper">
        <router-link :to="{ name: 'Chart' }" class="router-link"><img src="../../assets/icon/pie-chart.png" class="icon"></router-link>
        <router-link :to="{ name: 'WorkingTimes' }" class="router-link"><img src="../../assets/icon/work.png" class="icon"></router-link>
        <router-link :to="{ name: 'Clock' }" class="router-link"><img src="../../assets/icon/clock.png" class="icon"></router-link>
      </div>
    </div>
    <div class="fixed-width">
      <div v-if="user !== null" class="user_space_wrapper">
        <div class="logged_user">
          <div class="username">{{user.username}}</div>
          <div class="email">{{user.email}}</div>
        </div>
        <div class="user_img" @click="clickOnUserDetail">
          <img src="../../assets/icon/user.png" class="user_img">
        </div>
        <div class="user_detail" v-if="userDetail" v-click-outside="onClickOutside">
          <router-link :to="{ name: 'Profil'}" class="router-link"><div>Profil</div></router-link>
          <router-link :to="{ name: 'Team'}" class="router-link"><div>Team</div></router-link>
          <div @click="onClickLogout">Log out</div>
        </div>
      </div>
      <div v-else class="user_space_wrapper">
        <div class="logged_user">
          Click right to login ->
        </div>
        <div class="user_img" @click="clickOnUserDetail">
          <img src="../../assets/icon/user.png" class="user_img">
        </div>
        <div class="user_detail" v-if="userDetail" v-click-outside="onClickOutside">
          <router-link :to="{ name: 'Login'}" class="router-link"><div>Login</div></router-link>
          <router-link :to="{ name: 'Register'}" class="router-link"><div>Register</div></router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import vClickOutside from "click-outside-vue3"

export default {
  name: "Header",
  directives: {
    clickOutside: vClickOutside.directive
  },
  data() {
    return {
      userDetail: false
    }
  },
  props: {
    user: Object
  },
  methods: {
    clickOnUserDetail: function () {
      this.userDetail = !this.userDetail;
    },
    onClickOutside () {
      this.clickOnUserDetail();
    },
    onClickLogout() {
      this.$emit("logout")
    }
  }
}
</script>

<style scoped>
  @import "../../style.css";
  .wrapper {
    width: 100vw;
    height: 3em;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    position: relative;
    background-color: var(--main-bg-color);
    color: var(--main-color);
    font-size: large;
    font-weight: bold;
    z-index: 5;
  }
  .fixed-width {
    width: 20vw;
  }
  .logged_user {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    justify-content: center;
    padding-right: 1em;
  }
  .username {
    font-size: 1.2em;
  }
  .email {
    font-size: 0.8em;
  }
  .user_img {
    height: 2.5em;
    width: auto;
    cursor: pointer;
  }
  .user_space_wrapper {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: right;
    padding-right: 1em;
  }
  .user_detail {
    position: absolute;
    bottom: 0;
    right: 0;
    transform: translate(0, 100%);
    display: flex;
    flex-direction: column;
    border: 1px solid var(--main-bg-color);
  }
  .user_detail div {
    background-color: var(--main-color);
    color: var(--main-bg-color);
    padding: 0.2em 1em;
    cursor: pointer;
  }
  .user_detail div:hover {
    background-color: var(--main-bg-color);
    color: var(--main-color);
  }
  .icon {
    height: 2em;
    width: auto;
    cursor: pointer;
    padding-right: 1em;
  }
  .link_wrapper {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: right;
  }

</style>