<template>
    <div>
        <table id="exchagne-rates-table">
            <thead>
                <tr>
                    <th>
                        Date
                    </th> 
                    <th 
                        class="big-font"
                        v-for="currency in toDisplay(currencies)" 
                        :key="currency.id"
                    >
                        {{ currency.name }}
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr 
                    v-for="exchangeRate in exchangeRates" 
                    :key="exchangeRate.id"
                >
                    <td>{{ exchangeRate.date }}</td>
                    <td v-for="currency in toDisplay(currencies)" 
                        :key="currency.id"
                    >
                        {{ exchangeRate[currency.name] }}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>

export default {
    name: 'MyTable',
    props: {
        currencies: { required:true, type:Array },
        exchangeRates: { required:true, type:Array },
    },
    data() {
        return {
            currenciesToDisplay: [],
            tableExchangeRates:[],
        }
    },
    methods: {
      toDisplay(currencies) {
          return currencies.filter(item => item.selected)
      }
    },
}	
</script>

<style>
#exchagne-rates-table {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#exchagne-rates-table td, #exchagne-rates-table th {
  border: 1px solid #ddd;
  padding: 8px;
}

#exchagne-rates-table tr:nth-child(even){background-color: #f2f2f2;}

#exchagne-rates-table tr:hover {background-color: #ddd;}

#exchagne-rates-table th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}

.big-font {
    text-transform: uppercase;
}
</style>
