<template>
	<div class="registerDetail">
		<div class="con">
			<div class="title">挂单详情</div>
			<div class="detail">
				<span class="info">
					<span class="row">
						<div>
							<span>挂单编号 : </span>
							<span> {{num}} </span>
						</div>
						<div>
							<span>患者姓名 : </span>
							<span> {{name}} </span>
						</div>
					</span>
					<hr>
					<span class="row">
						<div>
							<span>就诊医院 : </span>
							<span> {{hospital}} </span>
						</div>
						<div>
							<span>就诊科室 : </span>
							<span> {{room}} </span>
						</div>
						<div>
							<span>看诊医生 : </span>
							<span> {{doctor}} </span>
						</div>
					</span>
					<hr>
					<span class="row">
						<div>
							<span>预约挂号 : </span>
							<span> <label>{{fee}}</label> 元 </span>
						</div>
						<div>
							<span>订单状态 : </span>
							<span> <label>{{feeState}}</label> </span>
						</div>
						<div>
							<span>流水号 : </span>
							<span> {{flowNum}} </span>
						</div>
						<div>
							<span>就诊条码 : </span>
							<span> 
								<img src="../../assets/codeIcon.png" alt="">
							</span>
						</div>
					</span>
					<hr>
					<span class="row">
						<div>
							<span>就诊日期 : </span>
							<span> {{date}} </span>
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
		name:'RegisterDetail',
		setup() {
			//*********************************** 数据区
			let num = ref('12111')
			let name = ref('Tom')
			let hospital = ref('医院xx')
			let room = ref('科室1')
			let doctor = ref('医生1')
			let fee = ref('6.00')
			let feeState = ref('未支付')
			let flowNum = ref('203322')
			let date = ref('2023-2-1')
			
			const route = useRouter()
			const axios = inject('$axios');
			//*********************************** 生命钩子区
			onBeforeMount(()=>{
				num.value= route.currentRoute.value.query.num
				name.value = route.currentRoute.value.query.name
				
				axios({
					url:'/registered/oneInfo',
					method:'GET',
					params:{
						id:num.value
					}
				}).then((res)=>{
					num.value = res.data.data.id,
					name.value = res.data.data.patientName,
					room.value = res.data.data.department,
					doctor.value = res.data.data.doctor,
					fee.value = res.data.data.money,
					feeState.value = res.data.data.status=='1'?'未支付':'已支付',
					flowNum.value='203322-'+num.value,
					date.value=res.data.data.bookTime
				}).catch((error)=>{
				})
			})
			//***********************************  监听属性
			//***********************************  方法区
			//*********************************** 返回区域
			return{
				num,
				name,
				hospital,
				room,
				doctor,
				fee,
				feeState,
				flowNum,
				date
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
		height: 450px;
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
</style>