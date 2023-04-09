<template>
    <div style="display: inline-flex; float:right;">
        <div style="padding-right: 10px;">
            Reload single
            <button class="button" @click="reloadExchangeRateData"> Refresh </button>
        </div>
        <div class="listing-element" 
            v-for="currency in toDisplay(displayCurrencies)" 
            :key="currency.id" 
        > 
            <div v-for="exchangeRate in data.slice(0, 1)" :key="exchangeRate.id">
                <div class="big-font">{{ currency.name }}</div> {{ exchangeRate[currency.name] }}
            </div>
        </div>

    </div>
</template>

<script>
import axios from 'axios'
// import dayjs from 'dayjs';

export default {
    name: 'SingleExchangeRate',
    props: {
        currencies: { required:true, type:Array },
        exchangeRates: { required:true, type:Array },
        date: { required:true, type:String },
    },
    data() {
        return {
            displayDate: this.date,
            displayCurrencies: this.currencies,
            data: this.exchangeRates,
        }
    },
    methods: {
        reloadExchangeRateData() {
            axios.get("http://127.0.0.1:8000/v0/exchange-rates?date_from=" + this.date + "&date_to=" + this.date)
                .then((response) => {
                    this.data=response.data.data
                })
        },
        toDisplay(currencies) {
            return currencies.filter(item => item.selected)
        }
    },
}
</script>

<style>
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