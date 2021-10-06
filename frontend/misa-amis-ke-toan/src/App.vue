<template>
  <div id="app">
    <app-sidebar :class="{minimize: isMinimize}" @change-sidebar-size="isMinimize = false;"/>
    <div class="content-wrapper">
      <app-header @change-sidebar-size="isMinimize = true;"/>
      <app-content/>
    </div>
  </div>
</template>

<script>
import AppSidebar from './components/layout/AppSidebar.vue'
import AppHeader from './components/layout/AppHeader.vue'
import AppContent from './components/layout/AppContent.vue'

export default {
  name: 'App',
  components: {
    AppSidebar,
    AppHeader,
    AppContent
  },
  data(){
    return{
      isMinimize: false,
    }
  }
}
</script>

<style>
  @import url('./css/common/common.css');
  @import url('./css/common/tooltip.css');
  @import url('./css/common/checkbox.css');
</style>
