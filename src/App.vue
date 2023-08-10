<template>
  <div id="app">
	<router-view></router-view>
  </div>
</template>

<script>
import Log from './components/log/Log.vue'
import Manager from './components/Manager.vue'

export default {
  name: 'App',
  components: {
	Log,
	Manager
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  
  width: 100%;
  height: 760px;
}
</style>
