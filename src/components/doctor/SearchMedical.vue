<template>
	<div class="registerLog">
		<div class="con">
			<div class="title">
				
			</div>
			<div class="op">
				<input type="text" class="opC" placeholder="病历号"  v-model="num" >
				<input type="text" class="opC" placeholder="姓名"  v-model="name" >
				<input type="text" class="opC" placeholder="身份证号"  v-model="idNum" >
				<el-button type="primary" class="opC" @click="Search">查询</el-button>
			</div>
			
			<div class="data">
				<el-table
				    :data="tableData"
					height="540"
				    style="width: 100%"
				    :row-class-name="tableRowClassName"
					@row-click="handleRowClick"
				  >
				    <el-table-column prop="id" label="病历号" width="180"/>
				    <el-table-column prop="patient_name" label="患者姓名" width="180" />
				    <el-table-column prop="status" label="诊断状态">
						<template #default="scope">
							<!-- 根据 money 的值显示不同的结果 -->
							<span v-if="scope.row.status == 0">未诊断</span>
							<span v-else-if="scope.row.status == 1">确诊</span>
							<span v-else>诊毕</span>
						 </template>
					</el-table-column>
					
				  </el-table>
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
		name:'SearchMedical',
		setup() {
			//*********************************** 数据区
			let num = ref(null)
			let name = ref(null)
			let idNum = ref(null)
			let nullConditionNum = ref(3)
			
			let tableData = ref([
				{
					id:'2333',
					patient_name:'cd',
					status:1
				},
				{
					id:'2334',
					patient_name:'cd33',
					status:0
				}
			])
			let fp = ref('')
			
			const route = useRouter()
			const axios = inject('$axios');
			//route.currentRoute.value.query
			//*********************************** 生命钩子区
			onBeforeMount(()=>{
				// ****************************  已测 ***********
				axios({
					url:'/MedicalRecord/Search',
					method:'POST',
					data:{
						id:num.value,
						patient_name:name.value,
						id_card:idNum.value
					}
				}).then((res)=>{
					tableData.value = res.data.data
				}).catch((error)=>{
				})
				fp.value = tableData.value
			})
			//***********************************  监听属性
			//***********************************  方法区
			function handleRowClick(row, event, column) {
				  route.push({
					  name:'medical_detail',
					  query:{
						  num:row.id,
						  name:row.patient_name
					  }
				  })
			}
			function Search(){
				// ****************************  已测 ***********
				axios({
					url:'/MedicalRecord/Search',
					method:'POST',
					data:{
						id:num.value,
						patient_name:name.value,
						id_card:idNum.value
					}
				}).then((res)=>{
					tableData.value = res.data.data
				}).catch((error)=>{
				})
				fp.value = tableData.value
			}
			//*********************************** 返回区域
			return{
				num,
				name,
				idNum,
				nullConditionNum,
				
				tableData,
				fp,
				
				handleRowClick,
				Search
			}
		}
	}
</script>

<style scoped>
	.registerLog{
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		
		width: 100%;
		height: 100%;
	}
	.con{
		width: 80%;
	}
	.title{
		width: 100%;
		height: 40px;
		line-height: 40px;
	}
	.op{
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		width: 100%;
		margin-top: 10px;
	}
	.opC{
		width: 200px;
	}
	.data{
		margin-top: 10px;
		width: 100%;
		overflow-y: auto;
		border: 1px purple solid;
	}
	table{
		width: 100%;
	}
	a{
		text-decoration: none;
	}
</style>