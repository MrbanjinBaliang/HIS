import {createRouter,createWebHashHistory} from 'vue-router'

import Log from '../src/components/log/Log.vue'
import Manager from '../src/components/Manager.vue'
import MainPage from '../src/components/patient/MainPage'
import PreRegister from '../src/components/patient/PreRegister'
import RegisterLog from '../src/components/patient/RegisterLog'
import SearchFee from '../src/components/patient/SearchFee'
import RegisterDetail from '../src/components/patient/RegisterDetail'
import CommitFee from '../src/components/patient/CommitFee'


//医生 系统组件
import MedicalLog from '../src/components/doctor/MedicalLog'
import Diagnosis  from '../src/components/doctor/Diagnosis'
import SearchMedical from '../src/components/doctor/SearchMedical'
import MedicalDetail from '../src/components/doctor/MedicalDetail'

const routes = [
	{
		path:'/',
		name:'log',
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
			},
			{
				name:'pre_register',
				path:'pre_register',
				component:PreRegister
			},
			{
				name:'register_log',
				path:'register_log',
				component:RegisterLog
			},
			{
				name:'search_fee',
				path:'search_fee',
				component:SearchFee
			},
			{
				name:'register_detail',
				path:'register_detail',
				component:RegisterDetail
			},
			{
				name:'commit_fee',
				path:'commit_fee',
				component:CommitFee
			},
			//医生 系统组件
			{
				name:'medical_log',
				path:'medical_log',
				component:MedicalLog
			},
			{
				name:'diagnosis',
				path:'diagnosis',
				component:Diagnosis
			},
			{
				name:'search_medical',
				path:'search_medical',
				component:SearchMedical
			},
			{
				name:'medical_detail',
				path:'medical_detail',
				component:MedicalDetail
			}
		]
	}
]

var router=createRouter({
	history:createWebHashHistory(),
	routes
})

router.beforeEach(function(to,from,next){
	
	console.log('tttttttttttttttttt',to.path);
	console.log('ffffffffffffffffff',from.path);
	console.log('nnnnnnnnnnnnnnnnnn',next.path);
	
	const patternStr = "main";
	// 使用RegExp构造函数创建正则表达式，并添加修饰符"i"来忽略大小写
	const pattern = new RegExp(patternStr, "i");
	const isMain = pattern.test(to.path);
	if (isMain) {
	  if(window.localStorage.getItem('username')!=null){
		  console.log('pppp  已登陆')
	  }
	  else{
		   console.log('pppp  未登陆')
		   router.push({
		   		  name:''
		   })
	  }
	  
	} else {
	  next()
	}
	
	
})

export default router
