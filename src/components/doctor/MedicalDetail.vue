<template>
	<div class="registerDetail">
		<div class="con">
			<div class="title">xxx 医院病历</div>
			<div class="detail">
				<div class="r1">
					<span>
						单号 : &nbsp;&nbsp;&nbsp;&nbsp; {{num}}
					</span>
				</div>
				<div class="r2">
					<span>
						姓名 : &nbsp;&nbsp;&nbsp;&nbsp; {{name}}
					</span>
					<span>
						性别 : &nbsp;&nbsp;&nbsp;&nbsp; {{sex}}
					</span>
					<span>
						年龄 : &nbsp;&nbsp;&nbsp;&nbsp; {{age}}
					</span> 
					<span>
						科别 : &nbsp;&nbsp;&nbsp;&nbsp; {{root}}
					</span>
				</div>
				<div class="r">
					<div class="tt">既往史 : </div>
					<div class="content">{{historySymptoms}}</div>
				</div>
				<div class="r">
					<div class="tt">现在史 : </div>
					<div class="content">{{currentSymptoms}}</div>
				</div>
				<div class="r">
					<div class="tt">主诉 : </div>
					<div class="content">{{mainDescribe}}</div>
				</div>
				<div class="r">
					<div class="tt">检查 : </div>
					<div class="content">{{bodyInspect}}</div>
				</div>
				<div class="r">
					<div class="tt">诊断 : </div>
					<div class="content">{{diagnosis}}</div>
				</div>
				<div class="r">
					<div class="tt">治疗 : </div>
					<div class="content">{{treat}}</div>
				</div>
				<div class="r">
					<div class="tt">医嘱 : </div>
					<div class="content">{{suggestion}}</div>
				</div>
				<div class="dr">
					<span>
						门诊医生 : {{doctor}}
					</span>
					<span>
						日期 : {{date}}
					</span>
				</div>
			</div>
			
			<div class="pr">
				<span>
					<el-button @click="Cancel">取消</el-button>
					<el-button type="primary" @click="Print">打印</el-button>
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
	
	export default{
		name:'MedicalDetail',
		setup() {
			//*********************************** 数据区
			let num = ref('12111')
			let name = ref('Tom')
			let sex = ref('男')
			let age = ref(20)
			let root = ref('骨科')
			let historySymptoms = ref('a')
			let currentSymptoms = ref('b')
			let mainDescribe = ref('c')
			let bodyInspect = ref('d')
			let diagnosis = ref('e')
			let treat = ref('f')
			let suggestion = ref('g')
			let doctor = ref('xxx 医生')
			let date = ref('2023-3-4')
			
			const route = useRouter()
			const axios = inject('$axios');
			//route.currentRoute.value.query
			//*********************************** 生命钩子区
			onBeforeMount(()=>{
				//病历单号
				num.value = route.currentRoute.value.query.num
				name.value = route.currentRoute.value.query.name
				axios({
					url:'/MedicalRecord/Search',
					method:'POST',
					data:{
						id:num.value
					}
				}).then((res)=>{
					sex.value = res.data.data[0].sex
					age.value = res.data.data[0].year
					root.value = res.data.data[0].dept_name
					historySymptoms.value = res.data.data[0].medical_history
					currentSymptoms.value = res.data.data[0].now_medical_history
					mainDescribe.value = res.data.data[0].chief_complaint
					bodyInspect.value = res.data.data[0].patient_check
					diagnosis.value = res.data.data[0].diagnosis
					treat.value = res.data.data[0].remedy
					suggestion.value = res.data.data[0].orders
					doctor.value = res.data.data[0].doctor_name
					date.value = res.data.data[0].create_time.substr(0,10)
				}).catch((error)=>{
				})
			})
			//***********************************  监听属性
			//***********************************  方法区
			function Cancel(){
				route.back()
			}
			function Print(){
				ElMessageBox({
				    title: '病历单打印',
				    message: h('p', null, [
				      h('span', null, '打印成功 !'),
				      h('i', { style: 'color: teal' }, ''),
				    ]),
				  })
			}
			//*********************************** 返回区域
			return{
				num,
				name,
				sex,
				age,
				root,				
				historySymptoms,
				currentSymptoms,
				mainDescribe,
				bodyInspect,
				diagnosis,
				treat,
				suggestion,
				doctor,
				date,
				
				Cancel,
				Print
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
		width: 60%;
		height: 100%;
		border-radius: 5px 5px;
		border: 1px black solid;
		padding: 10px;
	}
	.title{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		width: 80%;
		flex: 1;
	}
	.detail{
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		flex: 14;
		padding: 10px;
	}
	.r1{
		display: flex;
		flex-direction: row;
		justify-content: flex-start;
		align-items: center;
		width: 100%;
		
		border-bottom: 1px gray solid;
		margin-bottom: 5px;
	}
	.r2{
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		border-bottom: 1px gray solid;
		margin-bottom: 5px;
	}
	.r{
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		width: 100%;
		height: 120px;
		
		border-bottom: 1px gray solid;
		margin-bottom: 5px;
	}
	.tt{
		display: flex;
		flex-direction: row;
		justify-content: flex-start;
		align-items: center;
		width: 100%;
		flex: 1;
	}
	.content{
		display: flex;
		flex-direction: row;
		justify-content: flex-start;
		align-items: flex-start;
		width: 90%;
		flex: 5;
	}
	.dr{
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		padding-left: 10px;
		padding-right: 10px;
	}
</style>