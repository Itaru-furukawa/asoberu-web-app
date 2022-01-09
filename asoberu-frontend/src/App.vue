<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <div class="d-flex align-center">
        <h1>Asoberu（プロトタイプ）</h1>
      </div>

      <v-spacer></v-spacer>

      <v-btn
        href="https://github.com/Itaru-furukawa/asoberu-web-app"
        target="_blank"
        text
      >
        <span class="mr-2">Github repository</span>
        <v-icon>mdi-open-in-new</v-icon>
      </v-btn>
    </v-app-bar>
    <router-view/>
  </v-app>
</template>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>
