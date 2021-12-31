
<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <div class="d-flex align-center">
        <h1>Asoberu</h1>
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
                      v-model="scheduleId"
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
                      @click="e1 = 1"
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
                            v-model="peopleNum"
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
                              @click="e1 = 1"
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
  </v-app>
</template>

<style>
  .application {
    font-family: "Open Sans";
  }
  .top-bgimg{
    background: url('assets/679452.jpg');
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
    peopleNum: '',
    password: '',
    dates: [],
    scheduleId: '',
    joinSchedulePassword: ''
  }),
  computed: {
    dateRangeText () {
      return this.dates.join(' ~ ')
    },
  }
};
</script>
