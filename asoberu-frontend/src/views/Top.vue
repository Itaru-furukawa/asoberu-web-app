
<template>
  <v-main class="container-bg">
    <div class="top-bgimg">
      <div class="text-center margin-center">
        <div>
          <h1 class="display-2 font-weight-bold mb-3 white--text text--lighten-4">
            ASOBERU ~簡単に日程調整~
          </h1>
          <div class='justify-space-around d-flex spacing-playground mt-8'>
            <v-dialog
              transition="dialog-top-transition"
              v-model="dialog1"
              width="65%"
            >       
              <template v-slot:activator="{ on, attrs1 }">
                <v-btn
                  x-large
                  color="light-green lighten-1"
                  dark
                  v-bind="attrs1"
                  v-on="on"
                  class='font-weight-bold'
                >
                  日程調整に参加する
                </v-btn>
              </template>
              <v-card>
                <v-card-title class="headline light-green white--text lighten-1">
                  日程調整に参加する
                </v-card-title>
                <v-container class='space-playground pa-5'>
                  <v-text-field
                    v-model="joinScheduleId"
                    type='number'
                    label="スケジュールID"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="joinSchedulePassword"
                    label="あいことば"
                  >
                  </v-text-field>
                </v-container>
                <v-divider></v-divider>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    @click="dialog1 = false"
                  >  
                    キャンセル
                  </v-btn>
                  <v-btn
                    color="primary"
                    @click="fetchSchedule"
                  >
                    参加
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
            <v-dialog
              v-model="dialog2"
              width="65%"
              transition="dialog-top-transition"
            >       
              <template v-slot:activator="{ on, attrs2 }">
                <v-btn
                  x-large
                  color="primary lighten-2"
                  dark
                  v-bind="attrs2"
                  v-on="on"
                  class='font-weight-bold'
                >
                  日程調整を始める
                </v-btn>
              </template>
              <v-card>
                <v-stepper v-model="e1">
                  <v-stepper-header class='space-playground px-10'>
                    <v-stepper-step
                      :complete="e1 > 1"
                      step="1"
                    >
                      日程調整をはじめる
                    </v-stepper-step>

                    <v-divider></v-divider>

                    <v-stepper-step
                      :complete="e1 > 2"
                      step="2"
                    >
                      日程を選択
                    </v-stepper-step>
                  </v-stepper-header>

                  <v-stepper-items>
                    <v-stepper-content step="1">
                      <v-container class='space-playground pa-5'>
                        <v-text-field
                          v-model="scheduleName"
                          label="スケジュール名"
                        >
                        </v-text-field>
                        <v-text-field
                          v-model="memberNumber"
                          label="人数"
                          type="number"
                        >
                        </v-text-field>
                        <v-text-field
                          v-model="password"
                          label="あいことば"
                        >
                        </v-text-field>
                        <div class='grey--text '>*日程調整への参加時に必要になります。</div>
                        <template v-slot:activator="{ on, attrs }">
                          <v-text-field
                            v-model="date"
                            label="Picker in menu"
                            prepend-icon="mdi-calendar"
                            readonly
                            v-bind="attrs"
                            v-on="on"
                          ></v-text-field>
                        </template>
                      </v-container>
                      <v-divider></v-divider>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn
                            @click="dialog2 = false"
                          >
                            キャンセル
                          </v-btn>
                          <v-btn
                            color="primary"
                            @click="e1 = 2"
                          >
                            次へ
                          </v-btn>
                        </v-card-actions>
                    </v-stepper-content>

                    <v-stepper-content step="2">
                      <v-container class='space-playground pa-5 d-flex justify-space-around'>
                        <v-date-picker
                          v-model="dates"
                          range
                        ></v-date-picker>
                        <div>
                          <v-text-field
                            v-model="dateRangeText"
                            label="日程"
                            prepend-icon="mdi-calendar"
                            disabled
                          ></v-text-field>
                          <div>*左のカレンダーから開始日・終了日を選択してください。</div>
                        </div>
                      </v-container>
                      <v-divider></v-divider>
                      <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn
                            @click="e1 = 1"
                          >  
                          戻る
                          </v-btn>
                          <v-btn
                            color="primary"
                            @click="createSchedule()"
                          >
                            作成
                          </v-btn>
                      </v-card-actions>
                    </v-stepper-content>            
                  </v-stepper-items>
                </v-stepper>
              </v-card>
            </v-dialog>
          </div>
        </div>
      </div>
    </div>
  </v-main>
</template>

<style>
  .application {
    font-family: "Open Sans";
  }
  .top-bgimg{
    background: url('../assets/679452.jpg');
    background-size: auto;
    background-repeat:  no-repeat;  /* 背景の繰り返し設定 */
    background-position: center;    /* 背景の位置指定 */
    width: auto;
    height:95vh;
    
  }
  .container-bg{
    background: #E1F5FE;
  }
  .margin-center{
    margin: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 80%;
  }
</style>

<script>

export default {
  name: 'App',

  components: {
  },

  data: () => ({
    e1: 1,
    dialog1: false,
    dialog2: false,
    scheduleName: '',
    memberNumber: '',
    password: '',
    dates: [],
    scheduleId: '',
    joinScheduleId: sessionStorage.getItem('scheduleId'),
    joinSchedulePassword: sessionStorage.getItem('password'),
    schedule: {}
  }),
  computed: {
    dateRangeText () {
      this.swapDate()
      return this.dates.join(' ~ ')
    },
  },
  methods: {
    scheduleParams(){
      return {
        name: this.scheduleName,
        member_number: this.memberNumber,
        password: this.password,
        start_date: new Date(`${this.dates[0]}T00:00:00`),
        end_date: new Date(`${this.dates[1]}T23:59:59`) 
      }
    },
    defaultMembers(scheduleId){
      const members = []
      for(let i = 0; i < this.memberNumber; i++){
        members.push({name: `新規ユーザー${i+1}`, schedule_id: scheduleId})
      }
      return members
    },
    createSchedule(){
      this.axios.post(`${process.env.VUE_APP_API_HOST_NAME}/api/v1/schedules`, { 
        schedule: this.scheduleParams()
      })
      .then(response => {
        const scheduleId = response.data['data'].id
        const password = response.data['data'].password
        if(scheduleId && password){
          sessionStorage.setItem('scheduleId', scheduleId)
          sessionStorage.setItem('password', password)
        }
        this.schedule = response.data
        this.createMembers(scheduleId, password)
      })
      .catch(error => console.log(alert(error)))
    },
    createMembers(scheduleId, password){
      this.axios.post(`${process.env.VUE_APP_API_HOST_NAME}/api/v1/members?schedule_id=${scheduleId}&password=${password}`, { 
        members: this.defaultMembers(scheduleId)
      })
      .then(this.$router.push({name: 'Schedule', params: this.schedule}))
      .catch(error => console.log(alert(error)))
    },
    swapDate(){
      let startDate = new Date(this.dates[0]).getTime()
      let endDate = new Date(this.dates[1]).getTime()
      if (startDate > endDate){
        let tmp = this.dates[0]
        this.dates[0] = this.dates[1]
        this.dates[1] = tmp
      }
    },
    fetchSchedule(){
      this.axios.get(`${process.env.VUE_APP_API_HOST_NAME}/api/v1/schedules/${this.joinScheduleId}?password=${this.joinSchedulePassword}`)
        .then(response => {
          sessionStorage.setItem('scheduleId', this.joinScheduleId)
          sessionStorage.setItem('password', this.joinSchedulePassword)
          this.$router.push({name: 'Schedule', params: response.data['data']})
        })
        .catch(error => alert(error,'正しいID、パスワードを入力してください'))
    }
  }
};
</script>
