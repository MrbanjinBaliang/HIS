<template>
	<div class="main_container">
		<span class="main_left">
			<span class="main_left_top">
				<span class="flowD">
					<el-carousel v-if="role=='registor'" indicator-position="outside" arrow="always">
						<el-carousel-item>
							<img src="../../assets/img2.png" alt="">
						</el-carousel-item>
						<el-carousel-item>
							<img src="../../assets/img3.png" alt="">
						</el-carousel-item>
					</el-carousel>
					<el-carousel v-else indicator-position="outside" arrow="always">
						<el-carousel-item>
							<img src="../../assets/img6.png" alt="">
						</el-carousel-item>
						<el-carousel-item>
							<img src="../../assets/img7.png" alt="">
						</el-carousel-item>
					</el-carousel>
				</span>
			</span>
			<span class="main_left_bottom">
				<el-carousel v-if="role=='registor'" indicator-position="outside" arrow="always">
					<el-carousel-item>
						<img src="../../assets/img4.png" alt="">
					</el-carousel-item>
					<el-carousel-item>
						<img src="../../assets/img5.png" alt="">
					</el-carousel-item>
				</el-carousel>
				<el-carousel v-else indicator-position="outside" arrow="always">
					<el-carousel-item>
						<img src="../../assets/img8.png" alt="">
					</el-carousel-item>
					<el-carousel-item>
						<img src="../../assets/img9.png" alt="">
					</el-carousel-item>
				</el-carousel>
			</span>
		</span>
		
	
		<span v-if="role=='registor'" class="main_right">
			<span id='r1' class="button btn1"  @click="toPreRegister">快速预约</span>
			<span id='r2' class="button btn2"   @click="toSearchFee">缴费查询</span>
			<span id='r3' class="button btn3"   @click="telligentCure">智慧医疗</span>
			<span id='r4' class="button1"   @click="CommunicateOnline">在线沟通</span>
		</span>
		<span v-else class="main_right">
			<span class="button btn1"  @click="toMedical">快速诊断</span>
			<span class="button btn2"  @click="toSearchMedical">病例查询</span>
			<span class="button btn3"  @click="telligentCure">智慧医疗</span>
			<span class="button1"  @click="CommunicateOnline">在线沟通</span>
		</span>
		
	</div>
</template>

<script>
	//引入相关库
	import {h,inject,onBeforeMount,onMounted,ref,useRoute} from 'vue'
	import {useRouter} from 'vue-router'
	import eventBus from '../../eventBus.js'
	//引入组件
	
	export default{
		name:'MainPage',
		setup() {
			//*********************************** 数据区
			let role = ref('')
			let btnHoverBack = ref('')
			
			const route = useRouter()
			//route.currentRoute.value.query
			
			//*********************************** 生命钩子区
			onBeforeMount(()=>{
				role.value = route.currentRoute.value.query.role
			})
			
			//***********************************  方法区
			function toPreRegister(){
				eventBus.emit('modifyNavigTitleEvent',{title:'预约挂号'})
				eventBus.emit('modifyMainActiveEvent',{noActive:false})
				
				route.push({
					name:'pre_register'
				})
			}
			function toSearchFee(){
				eventBus.emit('modifyNavigTitleEvent',{title:'缴费查询'})
				eventBus.emit('modifyMainActiveEvent',{noActive:false})
				
				route.push({
					name:'search_fee'
				})
			}
			function toMedical(){
				eventBus.emit('modifyMainActiveEvent',{noActive:false})
				eventBus.emit('modifyNavigTitleEvent',{title:'门诊病历'})
				route.push({
					name:'medical_log'
				})
			}
			function toSearchMedical(){
				eventBus.emit('modifyMainActiveEvent',{noActive:false})
				eventBus.emit('modifyNavigTitleEvent',{title:'病例查询'})
				this.$router.push({
					name:'search_medical'
				})
			}
			function telligentCure(){
				eventBus.emit('modifyMainActiveEvent',{noActive:false})
				window.location.href = 'http://www.karrytech.cn/zhihuiyiliao.html?sdclkid=ASDGxrDixLApA5gl'
			}
			function CommunicateOnline(){
				eventBus.emit('modifyMainActiveEvent',{noActive:false})
				window.location.href='https://expert.baidu.com/med/pclp/template/#/wz/expert?vn=med&sf_ref=pc-sigma&word=%E9%97%AE%E5%8C%BB%E7%94%9F&query='
			}
			
			//*********************************** 返回区域
			return{
				role,
				btnHoverBack,
				
				toPreRegister,
				toSearchFee,
				toMedical,
				toSearchMedical,
				telligentCure,
				CommunicateOnline
			}
		}
	}
</script>

<style scoped>
	.main_container{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		
		width: 95%;
		height: 100%;
	}
	.main_left{
		flex: 2;
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		height: 100%;
	}
	.main_left_bottom{
		margin-top: 20px;
		width: 100%;
		height: 200px;
	}
	.main_left_top{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		
		width: 100%;
		height: 300px;
	}
	.flowD{
		width: 700px;
		height: 100%;
	}
	.flowD img{
		width: 100%;
		height: 100%;
	}
	.main_left_bottom img{
		height: 100%;
	}
	
	
	.main_right{
		display: flex;
		flex-direction: column;
		justify-content: space-around;
		align-items: center;
		
		flex: 1;
		height: 100%;
		margin-left: 10px;
	}
	.button{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		width: 270px;
		height: 90px;
		color: white;
		font-size: 30px;
		border-radius: 5px 5px;
	}
	.btn1{
		background-color: #14539a;
	}
	.btn2{
		background-color: #e06c75;
	}
	.btn3{
		background-color:  #14539a;
	}
	.btn4{
		background-color:  #e06c75;
	}
	.button1{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		width: 270px;
		height: 160px;
		color: white;
		font-size: 30px;
		background-color: #e06c75;
		border-radius: 5px 5px;
	}
	
	.btnHoverBack{
		background-color: orange;
	}
</style>