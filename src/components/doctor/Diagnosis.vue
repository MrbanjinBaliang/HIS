<template>
	<div class="preRegister">
		<form action="">
			<div class="formTitle">
				<h2>诊断</h2>
			</div>
			<div class="form_body">
				<el-form :model="form" label-width="120px">
				    <el-form-item label="病历号">
				      <el-input v-model="num" disabled />
				    </el-form-item>
				    <el-form-item label="患者姓名">
				      <el-input v-model="patientName" disabled/>
				    </el-form-item>
					<el-form-item label="主诉">
					  <el-input v-model="mainDescribe"/>
					</el-form-item>
					<el-form-item label="现病史">
					  <el-input v-model="currentSymptoms"/>
					</el-form-item>
					<el-form-item label="既往史">
					  <el-input v-model="historySymptoms"/>
					</el-form-item>
					<el-form-item label="体格检查">
					  <el-input v-model="bodyInspect"/>
					</el-form-item>
					<el-form-item label="诊断">
					  <el-input v-model="diagnosis"/>
					</el-form-item>
					<el-form-item label="治疗">
					  <el-input v-model="treat"/>
					</el-form-item>
					<el-form-item label="医生建议">
					  <el-input v-model="suggestion"/>
					</el-form-item>
				    <el-form-item>
					  <el-button @click="cancel">取消</el-button>
					  <el-button type="primary" @click="Save($event,'2')">诊毕</el-button>
				      <el-button type="primary" @click="Save($event,'1')">保存</el-button>
				    </el-form-item>
				  </el-form>
			</div>
		</form>
	</div>
</template>

<script>
	//引入相关库
	import {h,inject,onBeforeMount,onMounted,ref,useRoute,watch} from 'vue'
	import {useRouter} from 'vue-router'
	import eventBus from '../../eventBus.js'
	
	export default{
		name:'Diagnosis',
		setup() {
			//*********************************** 数据区
			let num = ref('12')
			let patientName = ref('banjin')
			let mainDescribe = ref('')
			let currentSymptoms = ref('')
			let historySymptoms = ref('')
			let bodyInspect = ref('')
			let diagnosis = ref('')
			let treat = ref('')
			let suggestion = ref('')
			
			const route = useRouter()
			const axios = inject('$axios')
			//route.currentRoute.value.query
			//*********************************** 生命钩子区
			onBeforeMount(()=>{
				num.value = route.currentRoute.value.query.num
				patientName.value = route.currentRoute.value.query.name
				axios({
					url:'/MedicalRecord/Search',
					method:'POST',
					data:{
						id : num.value
					}
				}).then((res)=>{
					historySymptoms.value = res.data.data[0].medical_history
					currentSymptoms.value = res.data.data[0].now_medical_history
					mainDescribe.value = res.data.data[0].chief_complaint
					bodyInspect.value = res.data.data[0].patient_check
					diagnosis.value = res.data.data[0].diagnosis
					treat.value = res.data.data[0].remedy
					suggestion.value = res.data.data[0].orders
				}).catch((error)=>{
				})
			})
			//***********************************  监听属性
			//***********************************  方法区
			function cancel(){
				route.back()
			}
			function Save(e,status){
				//保存诊断
			  axios({
			  	url:'/MedicalRecord/Update',
			  	method:'POST',
			  	data:{
			  		id : num.value,
			  		chief_complaint:mainDescribe.value,
			  		now_medical_history:currentSymptoms.value,
			  		medical_history:historySymptoms.value,
			  		patient_check:bodyInspect.value,
			  		diagnosis:diagnosis.value,
			  		medical_history:historySymptoms.value,
			  		remedy:treat.value,
					status:status,
			  		orders:suggestion.value
			  	}
			  }).then((res)=>{
			  }).catch((error)=>{
			  })
			}
			//*********************************** 返回区域
			return{
				num,
				patientName,
				mainDescribe,
				currentSymptoms,
				historySymptoms,
				bodyInspect,
				diagnosis,
				treat,
				suggestion,
				
				cancel,
				Save
			}
		}
	}
</script>

<style scoped>
	.preRegister{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		
		width: 100%;
		height: 100%;
	}
	form{
		width: 60%;
		height: 600px;
	}
	.formTitle{
		color: white;
	}
	.form_body{
		display: flex;
		flex-direction: column;
		justify-content: space-evenly;
		align-items: center;
		height: 400px;
	}
	.item{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		padding-left: 30px;
	}
	.itemName{
		display: block;
		margin-right: 20px;
		color: white;
	}
	.itemInput{
		width: 400px;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
	
	}
	.input{
		width: 100%;
	}
	.demo-date-picker{
		width: 150px;
		border: 2px red solid;
	}
	label{
		color: white;
	}
	select{
		width: 100px;
	}
	.block{
		width: 150px;
		border: 2px red solid;
	}
	el-date-picker{
		width: 100%;
	}
	
	
	.sub{
		height: 40px;
		margin-top: 30px;
	}
	.sub input{
		width: 200px;
		height: 40px;
	}
</style>