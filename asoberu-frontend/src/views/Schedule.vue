<template>
  <v-main class="space-playground mx-auto mt-12">
    <v-card class="main-card space-playground mb-12">
      <v-card-title>
        日程調整
      </v-card-title>
      <v-container class="space-playground pa-12">
        <v-row
          justify="center" align-content="center"
        >
          <v-col class='col-md-10'>
            <v-text-field
              v-model="scheduleId"
              label="スケジュールID"
              readonly
            ></v-text-field>
          </v-col>
          <v-spacer></v-spacer>
        </v-row>
        <v-row
          justify="center" align-content="center"
        >
          <v-col class='col-md-10'>
            <v-text-field
              v-model="scheduleName"
              label="スケジュール名"
              readonly
            ></v-text-field>
          </v-col>
          <v-spacer></v-spacer>
        </v-row>
        <v-row
          justify="center" align-content="center"
        >
          <v-col class='col-md-10'>
            <v-text-field
              label="入力者名"
              v-model="userName"
            ></v-text-field>
          </v-col>
          <v-col class='d-flex align-center'>
            <v-btn
              outlined
              color="primary lighten-2"
              dark
              class='font-weight-bold space-playground my-auto'
            >
              入力者変更
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </v-card>
    <calendar :userName="userName"></calendar>
  </v-main>
</template>

<style>
  .application {
    font-family: "Open Sans";
  }
  .main-card{
    width: 1000px;
  }
  .margin-center{
  }
</style>

<script>
import calendar from './Calendar.vue'
export default {
  name: 'App',

  components: {
    calendar
  },
  
  data: () => ({
    userName: 'wawa',
    scheduleId: 3,
    scheduleName: 'わわわ'
  }),
  computed: {
    dateRangeText () {
      return this.dates.join(' ~ ')
    },
  }
};
</script>
