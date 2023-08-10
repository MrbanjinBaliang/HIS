<template>
	<!-- 页面结构 -->
	
		<!-- v-model 用于将输入框元素的 value 值(输入值) 绑定给 Vue 组件中的对应 变量(双向绑定) -->
		
		<!-- v-if="表达式" -->
			<!-- v-if="表达式" -->
		<!-- v-else -->
			<!-- v-if="表达式" -->
		
		<!-- @事件名="函数名" : 将元素的对应事件函数绑定到组件的函数上,触发时执行对应函数-->
			
	<!-- 页面结构 -->
</template>

<script>
	//引入相关库
	import {h,inject,onBeforeMount,onMounted,ref,useRoute,watch} from 'vue'
	import {useRouter} from 'vue-router'
	import eventBus from '../eventBus.js'
	//引入组件
	
	export default{
		name:'Vue3Standard',
		setup() {
			//*********************************** 数据区
			let a = ref( 初始值 ) //Vue3 响应式数据的写法(才能双向绑定)
			
			const route = useRouter() //获取当前组件的路由对象，用于跳转、获取路径参数等
			const axios = inject('$axios');//获取绑定在根组件 App 上的请求库变量 $axios
			//route.currentRoute.value.query
			//*********************************** 生命钩子区
			
			//***********************************  监听属性
			watch(key, (newValue, oldValue) => {
				//监听数据区中的属性 key ,发生变化时执行该函数
				//newValue : 改变后的值
				//oldValue ：改变前的值
			})
			//***********************************  方法区
			//自定义方法
			function f(){
				//函数体
			}
			//*********************************** 返回区域
			//要想在页面能获取 Vue 组件变量和方法
			//就必须返回
			return{
				a,//变量返回
				f //方法返回
			}
		}
	}
</script>

<style>
</style>