import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Log from '../src/components/log/Log.vue'
import Manager from '../src/components/Manager.vue'
import MainPage from '../src/components/patient/MainPage'

var router=new VueRouter({
	mode:'history',
	routes:[
		{
			path:'/log',
			component:Log
		},
		{
		   	path:'/main',
			component:Manager,
			children:[
				{
					name:'main',
					path:'',
					component:MainPage
				}
			]
		}
	]
})

export default router
