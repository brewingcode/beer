import Vue from 'vue'
import BeerList from '~/components/BeerList'
import LoadingBars from '~/components/LoadingBars'
import { TableComponent, TableColumn } from 'vue-table-component'

Vue.component('beer-list', BeerList)
Vue.component('loading-bars', LoadingBars)
Vue.component('table-component', TableComponent)
Vue.component('table-column', TableColumn)
