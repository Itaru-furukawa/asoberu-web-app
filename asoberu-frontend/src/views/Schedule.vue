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
    <div>
      <calendar
        :userName="userName"
        :startDate="startDate"
        :endDate="endDate"
        :scheduleId="scheduleId"
        :password="password">
      </calendar>
    </div>
    <div class='spacing-playground mt-8 mb-12 d-flex justify-end'>
      <v-btn
        outlined
        color="grey"
        dark
        @click="toTop()"
        class='font-weight-bold space-playground my-auto'
      >
        トップに戻る
      </v-btn>
    </div>
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
    userName: '',
    scheduleId: undefined,
    scheduleName: '',
    password: '',
    startDate: undefined,
    endDate: undefined
  }),
  computed: {
    dateRangeText () {
      return this.dates.join(' ~ ')
    },
  },
  methods: {
    toTop(){
      this.$router.push({name: 'Top'})
    },
    fetchSchedule(){
      const scheduleId = sessionStorage.getItem('scheduleId')
      const password = sessionStorage.getItem('password')
      if(typeof scheduleId !== 'undefined' && typeof password !== 'undefined'){
        this.axios.get(`${process.env.VUE_APP_API_HOST_NAME}/api/v1/schedules/${scheduleId}?password=${password}`)
          .then(response => {
            this.scheduleId = response.data['data'].id
            this.scheduleName = response.data['data'].name
            this.password = response.data['data'].password
            this.startDate = new Date(response.data['data'].start_date)
            this.endDate = new Date(response.data['data'].end_date)
          })
          .catch(error => alert(error))
      } else {
        alert('セッション切れです!')
        this.$routes.push({name: 'Top'})
      }
    }
  },
  created(){
    console.log('schdulenの作成開始！')
    if (!this.$route.params.id){
      this.fetchSchedule()
    } else {
      this.scheduleId = this.$route.params.id
      this.scheduleName = this.$route.params.name
      this.password = this.$route.params.password
      this.startDate = new Date(this.$route.params.start_date)
      this.endDate = new Date(this.$route.params.end_date)
    }
  }
};
</script>
