<template>
  <v-row class="fill-height">
    <v-col>
      <v-sheet height="64">
        <v-toolbar
          flat
        >
          <v-btn
            outlined
            class="mr-4"
            color="primary darken-2"
            @click="postEvents"
          >
            保存して同期する
          </v-btn>
          <v-btn
            outlined
            class="mr-4"
            color="grey darken-2"
            @click="fetchEvents"
          >
            同期
          </v-btn>
          <v-btn
            v-if="showPrev()"
            fab
            text
            normal
            color="grey darken-2"
            @click="prev"
          >
            <v-icon large>
              mdi-chevron-left
            </v-icon>
          </v-btn>
          <v-btn
            v-if="showNext()"
            fab
            text
            normal
            color="grey darken-2"
            @click="next"
          >
            <v-icon large>
              mdi-chevron-right
            </v-icon>
          </v-btn>
          <v-toolbar-title v-if="$refs.calendar">
            {{ $refs.calendar.title }}
          </v-toolbar-title>
          <v-toolbar-title v-else>
            {{ calendarTitle }}
          </v-toolbar-title>
          
          <v-spacer></v-spacer>
        </v-toolbar>
      </v-sheet>
      <v-sheet height="600">
        <v-calendar
          ref="calendar"
          v-model="value"
          color="primary"
          type="week"
          :start="startDate"
          :end="endDate"
          :events="events"
          :event-color="getEventColor"
          :event-ripple="false"
          @mousedown:event="startDrag"
          @mousedown:time="startTime"
          @mousemove:time="mouseMove"
          @mouseup:time="endDrag"
          @mouseleave.native="cancelDrag"
        >
          <template v-slot:event="{ event, timed, eventSummary }">
            <div
              class="v-event-draggable"
              v-html="eventSummary()"
            ></div>
            <div
              v-if="timed"
              class="v-event-drag-bottom"
              @mousedown.stop="extendBottom(event)"
            ></div>
          </template>
        </v-calendar>
      </v-sheet>
    </v-col>
  </v-row>
</template>

<style scoped lang="scss">
.v-event-draggable {
  padding-left: 6px;
}

.v-event-timed {
  user-select: none;
  -webkit-user-select: none;
}

.v-event-drag-bottom {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 4px;
  height: 4px;
  cursor: ns-resize;

  &::after {
    display: none;
    position: absolute;
    left: 50%;
    height: 4px;
    border-top: 1px solid white;
    border-bottom: 1px solid white;
    width: 16px;
    margin-left: -8px;
    opacity: 0.8;
    content: '';
  }

  &:hover::after {
    display: block;
  }
}
</style>


<script>
  export default {
    props: {
      userName: String,
      startDate: Date,
      endDate: Date,
      scheduleId: Number,
      password: String
    },
    data: () => ({
      value: '',
      events: [],
      colors: ['#2196F3', '#3F51B5', '#673AB7', '#00BCD4', '#4CAF50', '#FF9800', '#757575'],
      names: ['Meeting', 'Holiday', 'PTO', 'Travel', 'Event', 'Birthday', 'Conference', 'Party'],
      dragEvent: null,
      dragStart: null,
      createEvent: null,
      createStart: null,
      extendOriginal: null,
      firstShowNext: false,
      firstShowPrev: false,
      calendarTitle: ''
    }),
    created(){
    },
    watch: {
      startDate: {
        handler: function(){
          this.$refs.calendar.checkChange()
          this.events.push({
            color: "#3F51B5",
            end: this.endDate.getTime(),
            name: "日程調整対象",
            start: this.startDate.getTime(),
            timed: false
          })
          this.calendarTitle = this.$refs.calendar.title
          const weekFirst = new Date(this.$refs.calendar.renderProps.start['date']).getTime()
          const weekLast = new Date(this.$refs.calendar.renderProps.end['date']).getTime()

          if (weekFirst >= this.startDate.getTime()){
            this.firstShowPrev = true
          } else {
            this.firstShowPrev = false
          }
          if (weekLast <= this.endDate.getTime()){
            this.firstShowNext = true
          } else {
            this.firstShowNext = false
          }
        }
      }
    },
    mounted () {
      if(this.startDate){
        this.$refs.calendar.checkChange()
        this.events.push({
            color: "#3F51B5",
            end: this.endDate.getTime(),
            name: "日程調整対象",
            start: this.startDate.getTime(),
            timed: false
          })
        this.calendarTitle = this.$refs.calendar.title
        const weekFirst = new Date(this.$refs.calendar.renderProps.start['date']).getTime()
        const weekLast = new Date(this.$refs.calendar.renderProps.end['date']).getTime()

        if (weekFirst >= this.startDate.getTime()){
          this.firstShowPrev = true
        } else {
          this.firstShowPrev = false
        }
        if (weekLast <= this.endDate.getTime()){
          this.firstShowNext = true
        } else {
          this.firstShowNext = false
        }
      }
    },
    computed: {
    },
    methods: {
      postEvents () {
        const events = this.events.filter(event => {return event.new == true})
        console.log(events)
        if (events.length){
          this.axios.put(`${process.env.VUE_APP_API_HOST_NAME}/api/v1/events/${this.scheduleId}?password=${this.password}`, { 
            events: events
          })
          .then(response => {
            console.log(response)
          })
          .catch(error => console.log(alert(error)))
          // this.fetchEvents()
        }
      },
      fetchEvents () {
        this.axios.get(`${process.env.VUE_APP_API_HOST_NAME}/api/v1/events/?schedule_id=${this.scheduleId}&password=${this.password}`)
        .then(response => {
          console.log(response)
          this.events = response.data.data
          this.events.push({
            color: "#3F51B5",
            end: this.endDate.getTime(),
            name: "日程調整対象",
            start: this.startDate.getTime(),
            timed: false
          })
        })
        .catch(error => console.log(alert(error)))
      },
      scrollToTime () {
        const time = this.getCurrentTime()
        const first = Math.max(0, time - (time % 30) - 30)

        this.$refs.calendar.scrollToTime(first)
      },
      showNext() {
        if (this.$refs.calendar){
          const weekLast = new Date(this.$refs.calendar.renderProps.end['date']).getTime()
          if (weekLast <= this.endDate.getTime()){
            return true
          }

          return false
        }
        return this.firstShowNext
      },
      showPrev() {
        if (this.$refs.calendar){
          const weekFirst = new Date(this.$refs.calendar.renderProps.start['date']).getTime()
          if (weekFirst >= this.startDate.getTime()){
            return true
          }

          return false
        }
        return this.firstShowPrev
      },
      setToday () {
        this.value = ''
      },
      prev () {
        this.$refs.calendar.prev()
      },
      next () {
        this.$refs.calendar.next()
      },
      startDrag ({ event, timed }) {
        if (event && timed) {
          this.dragEvent = event
          this.dragTime = null
          this.extendOriginal = null
        }
      },
      startTime (tms) {
        const mouse = this.toTime(tms)
        const roundTime = this.roundTime(mouse)
        if(!(roundTime >= this.startDate.getTime() && roundTime <= this.endDate.getTime())){
          return
        }
        if (this.dragEvent && this.dragTime === null) {
          const start = this.dragEvent.start
          this.dragTime = mouse - start
        } else {
          this.createStart = roundTime
          this.createEvent = {
            schedule_id: this.scheduleId,
            member_id: 4,
            name: `${this.userName} 予定あり`,
            color: this.rndElement(this.colors),
            start: this.createStart,
            end: this.createStart,
            timed: true,
            new: true
          }

          this.events.push(this.createEvent)
        }
        console.log(this.newEvents)
      },
      extendBottom (event) {
        this.createEvent = event
        this.createStart = event.start
        this.extendOriginal = event.end
      },
      mouseMove (tms) {
        const mouse = this.toTime(tms)

        if (this.dragEvent && this.dragTime !== null) {
          const start = this.dragEvent.start
          const end = this.dragEvent.end
          const duration = end - start
          const newStartTime = mouse - this.dragTime
          const newStart = this.roundTime(newStartTime)
          const newEnd = newStart + duration

          this.dragEvent.start = newStart
          this.dragEvent.end = newEnd
          this.dragEvent.new = true
        } else if (this.createEvent && this.createStart !== null) {
          const mouseRounded = this.roundTime(mouse, false)
          const min = Math.min(mouseRounded, this.createStart)
          const max = Math.max(mouseRounded, this.createStart)
          this.createEvent.start = min
          this.createEvent.end = max
          this.createEvent.new = true
        }
      },
      endDrag () {
        this.dragTime = null
        this.dragEvent = null
        this.createEvent = null
        this.createStart = null
        this.extendOriginal = null
      },
      cancelDrag () {
        if (this.createEvent) {
          if (this.extendOriginal) {
            this.createEvent.end = this.extendOriginal
          } else {
            const i = this.events.indexOf(this.createEvent)
            if (i !== -1) {
              this.events.splice(i, 1)
            }
          }
        }

        this.createEvent = null
        this.createStart = null
        this.dragTime = null
        this.dragEvent = null
      },
      roundTime (time, down = true) {
        const roundTo = 15 // minutes
        const roundDownTime = roundTo * 60 * 1000

        return down
          ? time - time % roundDownTime
          : time + (roundDownTime - (time % roundDownTime))
      },
      toTime (tms) {
        return new Date(tms.year, tms.month - 1, tms.day, tms.hour, tms.minute).getTime()
      },
      getEventColor (event) {
        const rgb = parseInt(event.color.substring(1), 16)
        const r = (rgb >> 16) & 0xFF
        const g = (rgb >> 8) & 0xFF
        const b = (rgb >> 0) & 0xFF

        return event === this.dragEvent
          ? `rgba(${r}, ${g}, ${b}, 0.7)`
          : event === this.createEvent
            ? `rgba(${r}, ${g}, ${b}, 0.7)`
            : event.color
      },
      // getEvents ({ start, end }) {
      //   const events = []

      //   const min = new Date(`${start.date}T00:00:00`).getTime()
      //   const max = new Date(`${end.date}T23:59:59`).getTime()
      //   const days = (max - min) / 86400000
      //   const eventCount = this.rnd(days, days + 20)

      //   for (let i = 0; i < eventCount; i++) {
      //     const timed = this.rnd(0, 3) !== 0
      //     const firstTimestamp = this.rnd(min, max)
      //     const secondTimestamp = this.rnd(2, timed ? 8 : 288) * 900000
      //     const start = firstTimestamp - (firstTimestamp % 900000)
      //     const end = start + secondTimestamp

      //     events.push({
      //       name: this.rndElement(this.names),
      //       color: this.rndElement(this.colors),
      //       start,
      //       end,
      //       timed,
      //     })
      //   }
      //   events.push({
      //     color: "#3F51B5",
      //     end: 1653103900000,
      //     name: "日程調整対象",
      //     start: 1642917600000,
      //     timed: false
      //   })
      //   //this.events = events
      // },
      rnd (a, b) {
        return Math.floor((b - a + 1) * Math.random()) + a
      },
      rndElement (arr) {
        return arr[this.rnd(0, arr.length - 1)]
      },
    },
  }
</script>
