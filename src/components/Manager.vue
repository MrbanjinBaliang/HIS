<template>
	<div class="manager_container">
		<div class="head">
			<span class="logo">
				<img src="../assets/icon/logo.png" alt="">
				<label for="">
					HIS
				</label>
			</span>
			<span v-if="role=='registor'" class="title">
				预约挂号系统
			</span>
			<span v-else class="title">
				病历管理系统
			</span>
			<span class="headInfo">
				<span class="nickname">
					<el-dropdown @command="handleMenuItemClick">
					    <span class="el-dropdown-link">
							{{username}}
					      <el-icon class="el-icon--right">
					        <arrow-down />
					      </el-icon>
					    </span>
					    <template #dropdown>
					      <el-dropdown-menu>
					        <el-dropdown-item command="exit">退出登录</el-dropdown-item>
					      </el-dropdown-menu>
					    </template>
					  </el-dropdown>
				</span>
				<span class="headphoto">
					<img src="../assets/icon/me_active.png" alt="">
				</span>
			</span>
		</div>
		<div class="body">
			<!-- 挂号系统左部导航 -->
			<span v-if="role=='registor'" class="left">
				<el-menu
					active-text-color="#ffd04b"
					background-color="#0d3562"
					class="el-menu-vertical-demo"
					default-active="2"
					text-color="#fff"
					@open="handleOpen"
					@close="handleClose"
				  >
					<el-menu-item index="2" @click="toMainPage">
					   <el-icon><icon-menu /></el-icon>
					   <span class="mP">
						   <img v-if="mainPageActive" src="../assets/icon/m_ac.png" alt="">
						   <img v-else src="../assets/icon/m_na.png" alt="">
						   首 &nbsp;&nbsp;&nbsp;页
					   </span>
					</el-menu-item>
				  
					<el-sub-menu index="1">
					  <template #title>
						<el-icon><location /></el-icon>
						<span>门诊挂号收费</span>
					  </template>
					  
					  <el-menu-item-group>
						<el-menu-item index="1-1" @click="toPreRegister">
							预约挂号
						</el-menu-item>
						<el-menu-item index="1-2" @click="toRegisteLog">
							挂号记录
						</el-menu-item>
						<el-menu-item index="1-3" @click="toSearchFee">
							费用查询
						</el-menu-item>
					  </el-menu-item-group>

					</el-sub-menu>
					
				  </el-menu>
			</span>
			
			<!-- 医生系统左部导航 -->
			<span v-else class="left">
				<el-menu
					active-text-color="#ffd04b"
					background-color="#0d3562"
					class="el-menu-vertical-demo"
					default-active="2"
					text-color="#fff"
					@open="handleOpen"
					@close="handleClose"
				  >
					<el-menu-item index="2" @click="toMainPage">
					   <el-icon><icon-menu /></el-icon>
					   <span class="mP">
						   <img v-if="mainPageActive" src="../assets/icon/m_ac.png" alt="">
						   <img v-else src="../assets/icon/m_na.png" alt="">
						   首 &nbsp;&nbsp;&nbsp;页
					   </span>
					</el-menu-item>
				  
					<el-sub-menu index="1">
					  <template #title>
						<el-icon><location /></el-icon>
						<span>门诊医生工作</span>
					  </template>
					  
					  <el-menu-item-group>
						<el-menu-item index="1-1" @click="toMedical">
							门诊病历
						</el-menu-item>
						<el-menu-item index="1-2" @click="toSearchMedical">
							病历查询
						</el-menu-item>
					  </el-menu-item-group>
			
					</el-sub-menu>
					
				  </el-menu>
			</span>
			
			<span class="right">
				<div class="navg">
					<span class="icon" @click="Back">
						<img :src="imgPath" alt="返回上一级">
						<label>返回</label>
					</span>
					<span class="Ntitle">{{navigTitle}}</span>
				</div>
				<div class="body">
					<router-view></router-view>
				</div>
			</span>
			
		</div>
	</div>
</template>

<script>
	//引入相关库
	import {h,inject,onBeforeMount,onMounted,ref,useRoute} from 'vue'
	import {useRouter} from 'vue-router'
	import eventBus from '../eventBus.js'
	//引入组件
	import MainPage from './patient/MainPage.vue'
	
	export default{
		name:'Manager',
		setup() {
			let role = ref('registor')
			let username =  ref('')
			let navigTitle = ref('首页')
			let imgPath = ref('')
			let mainPageActive = ref(true)
			
			const router = inject('router')
			const route = useRouter()
			//*********************************** 生命钩子区
			onBeforeMount(()=>{
				//获取角色
				role.value = route.currentRoute.value.query.role;
				imgPath.value = require("../assets/icon/back.png")
				username.value = window.localStorage.getItem('username')
			})
			onMounted(()=>{
				//全局事件总线技术
				eventBus.on('modifyNavigTitleEvent',modifyNavigTitle)
				eventBus.on('modifyMainActiveEvent',modifyMainActive)
			})
			
			
			//***********************************  方法区
			function handleMenuItemClick(command) {
			  switch (command) {
				case 'exit':
				  // 退出登录
				  window.localStorage.removeItem('username')
				  route.push({
					  name:'log'
				  })
				  break;
				default:
				  break;
			  }
			}
			function modifyNavigTitle(data){
				navigTitle.value = data.title
			}
			function modifyMainActive(state){
				mainPageActive.value = state.noActive
			}
			function toMainPage(){
				mainPageActive.value = true
				navigTitle.value='首页'
				route.push({
					name:'main',
					query:{
						role:role.value
					}
				})
			}
			//挂号员
			function toPreRegister(){
				mainPageActive.value = false
				navigTitle.value='预约挂号'
				route.push({
					name:'pre_register'
				})
			}
			function toRegisteLog(){
				mainPageActive.value = false
				navigTitle.value='挂号记录'
				route.push({
					name:'register_log'
				})
			}
			function toSearchFee(){
				mainPageActive.value = false
				navigTitle.value='费用查询'
				route.push({
					name:'search_fee'
				})
			}
			//医生
			function toMedical(){
				mainPageActive.value = false
				navigTitle.value='门诊病历'
				route.push({
					name:'medical_log'
				})
			}
			function toSearchMedical(){
				mainPageActive.value = false
				navigTitle.value ='病例查询'
				route.push({
					name:'search_medical'
				})
			}
			function Back(){
				route.back()
			}
			
			
			
			//*********************************** 返回区域
			return{
				role,
				username,
				navigTitle,
				imgPath,
				mainPageActive,
				
				handleMenuItemClick,
				modifyNavigTitle,
				modifyMainActive,
				toMainPage,
				toPreRegister,
				toRegisteLog,
				toSearchFee,
				toMedical,
				toSearchMedical,
				Back
			}
			
		},
		components:{
			MainPage
		}
	}
</script>

<style scoped>
	.manager_container{
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		width: 100%;
		height: 100%;
		/* background-image: url('../assets/img1.png'); */
	}
	.head{
		background-color: #339999;
		width: 100%;
		flex: 1;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		font-size: 40px;
		color: white;
		
		border-radius: 5px 5px;
	}
	.logo{
		display: flex;
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		height: 90%;
	}
	.logo img{
		height: 80px;
	}
	el-dropdown{
		border: none;
	}
	.el-dropdown-link{
		color: white;
	}
	.headInfo{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		height: 90%;
		margin-right: 5px;
	}
	.nickname{
		font-size: 14px;
		margin-right: 10px;
	}
	.headphoto{
		width: 50px;
		height: 50px;
		border-radius: 50% 50%;
		border: 2px white solid;
	}
	.headphoto img{
		height: 85%;
	}
	.body{
		width: 100%;
		flex: 10;
		
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		
		margin-top: 5px;
		background-color: transparent;
	}
	
	.left{
		height: 100%;
		flex: 1;
		background-color: #0d3562;
	}
	.mP{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
	}
	.mP img{
		height: 25px;
		margin-right: 20px;
	}
	.el-menu-item a{
		color: white;
		text-decoration: none;
	} 
	.right{
		height: 100%;
		flex: 7;
		margin-left: 5px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items:center;
	}
	.navg{
		display: flex;
		flex-direction: row;
		justify-content: flex-start;
		align-items: center;
		
		width: 100%;
		height: 40px;
		font-size: 25px;
		background-color: #0d3562;
		border-bottom: 4px orange solid;
	}
	.icon{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		height: 100%;
		color: white;
	}
	.icon img{
		height: 90%;
	}
	.Ntitle{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		height: 100%;
		width: 80%;
		font-size: 20px;
		color: #f7c94e;
	}
</style>