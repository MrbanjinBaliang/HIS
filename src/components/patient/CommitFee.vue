<template>
	<div class="registerDetail">
		<div class="con">
			<div class="title">
				<h2>请缴费 !</h2>
			</div>
			<div class="detail">
				<span class="info">
					<span class="row">
						<div>
							<span>就诊人 : </span>
							<span> {{name}} </span>
						</div>
						<div>
							<span>单号 : </span>
							<span> {{num}} </span>
						</div>
					</span>
					<hr>
					<span class="row">
						<div>
							<span>就诊医院 : </span>
							<span> {{hospital}} </span>
						</div>
						<div>
							<span>预约科室 : </span>
							<span> {{room}} </span>
						</div>
						<div>
							<span>预约医生 : </span>
							<span> {{doctor}} </span>
						</div>
						<div>
							<span>预约时间 : </span>
							<span> {{date}} </span>
						</div>
						<div>
							<span>就诊费用 : </span>
							<span> <label>{{fee}} 元</label>  </span>
						</div>
					</span>
					<hr>
					<span class="row">
						<div>
							<span>共需支付 : </span>
							<span> <label>{{fee}} 元</label> </span>
						</div>
						<div>
							<span>支付方式 : </span>
							<span>
								<select name="" id="" v-model="feeWay">
									<option value="wx" selected>微信</option>
									<option value="zfb">支付宝</option>
								</select>
							</span>
						</div>
					</span>
					<hr>
					<span class="row">
						<div class="feeCode">
							<span>
								<img v-if="feeWay=='wx'" src="../../assets/wx.png" alt="">
								<img v-else src="../../assets/zfb.jpg" alt="">
							</span>
						</div>
					</span>
					<hr>
					<span class="row">
						<div class="feeC">
							<span>
								<el-button v-if="feeStaus==0" disabled type="primary" @click="FeeCommit">支 &nbsp;&nbsp;&nbsp;&nbsp;付</el-button>
								<el-button v-else  type="primary" @click="FeeCommit">支 &nbsp;&nbsp;&nbsp;&nbsp;付</el-button>
							</span>
						</div>
					</span>
				</span>
			</div>
		</div>
	</div>
</template>

<script>
	//引入相关库
	import {h,inject,onBeforeMount,onMounted,ref,useRoute,watch} from 'vue'
	import {useRouter} from 'vue-router'
	import eventBus from '../../eventBus.js'
	//引入组件
	
	export default{
		name:'CommitFee',
		setup() {
			//*********************************** 数据区
			let num = ref('12111')
			let name = ref('Tom')
			let hospital = ref('医院xx')
			let room = ref('科室1')
			let doctor = ref('医生1')
			let date = ref('')
			let fee = ref('6.00')
			let feeWay = ref('wx')
			let feeStaus = ref('')
			
			let medicalID  = ref('')
			
			const route = useRouter()
			const axios = inject('$axios');
			//route.currentRoute.value.query
			//*********************************** 生命钩子区
			onBeforeMount(()=>{
				num.value = route.currentRoute.value.query.num
				axios({
					url:'/registered/oneInfo',
					method:'GET',
					params:{
						id:num.value
					}
				}).then((res)=>{
					console.log('llllllllllllllllll',res.data)
					num.value = res.data.data.id
					name.value = res.data.data.patientName
					room.value = res.data.data.department
					doctor.value = res.data.data.doctor
					fee.value = res.data.data.money
					date.value=res.data.data.bookTime.substr(0,10)+" "+res.data.data.bookTime.substr(11,8)
					feeStaus.value = res.data.data.status
					
					medicalID.value = res.data.data.medicalId
				}).catch((error)=>{
				})
			})
			//***********************************  监听属性
			//***********************************  方法区
			function FeeCommit(){
				axios({
					url:'/registered/paid',
					method:'GET',
					params:{
						id:num.value
					}
				}).then((res)=>{
					console.log('dddddddddddddddddddddd')
					axios({
						url:'/MedicalRecord/Update',
						method:'POST',
						data:{
							id:medicalID.value,
							status : '0'
						}
					}).then((res)=>{
						console.log('jjjjjjjjjjjjjjjjjjj',res.data)
						
						
					}).catch((error)=>{
						console.log(error)
					})
				}).catch((error)=>{
				})
				
				ElMessageBox({
				    title: '支付',
				    message: h('p', null, [
				      h('span', null, '支付已完成 !'),
				      h('i', { style: 'color: teal' }, ''),
				    ]),
				  })
				route.push({
					name:'search_fee'
				})
			}
			//*********************************** 返回区域
			return{
				num,
				name,
				hospital,
				room,
				doctor,
				date,
				fee,
				feeWay,
				feeStaus,
				medicalID,
				
				FeeCommit
			}
		}
	}
</script>

<style scoped>
	.registerDetail{
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		width: 100%;
		height: 100%;
	}
	.con{
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		width: 80%;
		height: 100%;
	}
	.title{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		width: 80%;
		flex: 1;
		border-bottom: 2px gray solid;
	}
	.detail{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		width: 80%;
		flex: 12;
	}
	.info{
		width: 450px;
		height: 500px;
		border-radius: 5px 5px;
		border: 1px black solid;
		padding: 10px;
	}
	.row{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	.row div{
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		width: 100%;
	}
	.row div span{
		margin-top: 5px;
	}
	label{
		color: coral;
	}
	.feeCode{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 150px;
	}
	.feeCode span{
		width: 100%;
		height: 100%;
	}
	.feeCode span img{
		height: 100%;
	}
	.feeC{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 40px;
	}
	.feeC span{
		width: 50%;
		height: 100%;
		margin-left: 120px;
	}
	.feeC span button{
		width: 100%;
		height: 100%;
	}
</style>