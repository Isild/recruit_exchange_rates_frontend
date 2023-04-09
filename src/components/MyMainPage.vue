<template>
    <div class="container">
      
      <div style="margin-left: 20px;">
        <div style="border: 1px solid #ccc; border-radius: 16px; display: inline-table; float:left">
          Select curriencies to view:
          <ul>
            <li v-for="item in currenciesToDisplay" :key="item.id">
              <input type="checkbox" :id="item.id" :checked="item.selected" @change="changeCheckStatus(item.id)"/>
              <label :for="item.id" class="big-font"> {{ item.name }}</label>
            </li>
          </ul>
        </div>

        <div style="float:left; padding: 10px;">
          <datepicker 
            :value="date"
            @update:modelValue="dateSelected"
          ></datepicker>

        </div>
      </div>

    
      <div>
        <single-exchange-rate 
          :currencies="this.currenciesToDisplay" 
          :date="date" :exchange-rates="this.tableExchangeRates" 
          v-if="this.currenciesToDisplay && this.tableExchangeRates"
        >
        </single-exchange-rate>
      </div>

      <br>
      <br>

      <div>
        <my-table
          :currencies="this.currenciesToDisplay" 
          :date="date" :exchange-rates="this.tableExchangeRates" 
          v-if="this.currenciesToDisplay && this.tableExchangeRates"
        ></my-table>
      </div>
      
      <br>
      Reload table data 
          
      <button class="button" @click="reloadTableExchangeRateData">Reload</button>

    </div>
</template>

<script>
import uniqueId from "lodash.uniqueid";
import MyTable from './myComponents/MyTable.vue'
import SingleExchangeRate from './myComponents/SingleExchangeRate.vue'
import axios from 'axios'
import Datepicker from 'vuejs3-datepicker'
import dayjs from 'dayjs';

export default {
  name: 'MyMainPage',
  components: {
    MyTable,
    SingleExchangeRate,
    Datepicker,
  },
  props: {
    label: { required: true, type: String },
  },
  data() {
    return {
      date: null,
      id: uniqueId("checkbox-"),
      currenciesToDisplay: null,
      tableExchangeRates: null,
      dateBegin: null,
      dateEnd: null,
      backendUrl: null,
    };
  },
  methods: {
    changeCheckStatus(id) {
      const updateItem = this.currenciesToDisplay.find((item) => item.id === id)
      updateItem.selected = !updateItem.selected
    },
    getCurrencies() {
      axios.get("http://127.0.0.1:8000/v0/exchange-rates/available-currencies")
        .then((response) => {
          this.currenciesToDisplay=response.data.currencies

          this.currenciesToDisplay = this.currenciesToDisplay.map((item) => {
            return {
              id: item.id,
              name: item.name,
              selected: true,
            }
          })
        })
    },
    reloadTableExchangeRateData() {
      this.tableExchangeRates=null
      axios.get("http://127.0.0.1:8000/v0/exchange-rates?date_from=" + this.dateBegin + "&date_to=" + this.dateEnd)
        .then((response) => {
            this.tableExchangeRates=response.data.data
        })
    },
    dateSelected(selectedDate) {
      this.date = selectedDate
      this.date = this.formatData(this.date)
    },
    formatData(date) {
      const dateDisplay = dayjs(date)
      return  dateDisplay.format('YYYY-MM-DD')
    },
  },
  created() {
    this.date = new Date()
    this.dateEnd = new Date()
    this.dateBegin = new Date(Date.now()-2419200000).toISOString().substring(0,10) // display data for one month

    this.date = this.formatData(this.date)
    this.dateEnd = this.formatData(this.dateEnd)
    this.dateBegin = this.formatData(this.dateBegin)

    this.getCurrencies()
    this.reloadTableExchangeRateData()
  },
  beforeCreate() {
    this.backendUrl=process.env.VUE_APP_BACKEND_URL
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
.big-font {
    text-transform: uppercase;
}

.listing-element {
    padding: 2px;
}

.container {
  margin-right: 20px;
}

.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 12px 28px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 14px;
  border-radius: 4px;
  transition-duration: 0.4s;
  cursor: pointer;
}

.button:hover {
  background-color: white;
  color: black;
  border: 1px solid #4CAF50;
}
</style>