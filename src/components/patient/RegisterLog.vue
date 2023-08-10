<template>
	<div class="registerLog">
		<div class="con">
			<div class="title">
			</div>
			<div class="op">
				<input type="text" class="opC" placeholder="挂单编号"  v-model="num" >
				<input type="text" class="opC" placeholder="患者姓名"  v-model="name">
				<input type="date" class="opC" placeholder="年/月/日"  v-model="date">
				<select name="isValid" class="opC" v-model="isValid">
				  <option value="2">全部</option>
				  <option value="1">有效</option>
				  <option value="0">无效</option>
				</select>
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
				    <el-table-column prop="id" label="挂单编号" width="180"/>
				    <el-table-column prop="patientName" label="姓名" width="180" />
				    <el-table-column prop="bookTime" label="挂号日期"  />
					<el-table-column prop="id" label="操作">
						<template #default="scope">
							<!-- 根据 money 的值显示不同的结果 -->
							<el-button type="primary" @click.stop="cancelRegister($e,scope.row.id,scope.row.medicalId)">退号</el-button>
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
	//引入组件
	
	export default{
		name:'RegisterLog',
		setup() {
			//*********************************** 数据区
			let date = ref('')
			let num = ref('')
			let name = ref('')
			let isValid = ref('2')
			let nullConditionNum = ref(4)
			
			let tableData = ref([])
			let fp = ref('')
			
			const route = useRouter()
			const axios = inject('$axios');
			//*********************************** 生命钩子区
			onBeforeMount(()=>{
				axios({
					url:'/registered/secInfo',
					method:'POST',
					data:{
						num:num.value,
						name:name.value,
						date:date.value,
						isValid:isValid.value
					}
				}).then((res)=>{
					tableData.value = res.data.data
					fp.value = tableData.value
				}).catch((error)=>{
				})
			})
			
			//***********************************  监听属性
			watch(num, (newValue, oldValue) => {
				if(oldValue==''&&newValue!='')nullConditionNum.value = nullConditionNum.value-1;
				else if(oldValue!=''&&newValue=='') nullConditionNum.value = nullConditionNum.value+1;
				if(nullConditionNum.value==4)tableData.value = fp.value
			})
			watch(name, (newValue, oldValue) => {
				if(oldValue==''&&newValue!='')nullConditionNum.value = nullConditionNum.value-1;
				else if(oldValue!=''&&newValue=='') nullConditionNum.value = nullConditionNum.value+1;
				if(nullConditionNum.value==4)tableData.value = fp.value
			})
			watch(date, (newValue, oldValue) => {
				if(oldValue==''&&newValue!='')nullConditionNum.value = nullConditionNum.value-1;
				else if(oldValue!=''&&newValue=='') nullConditionNum.value = nullConditionNum.value+1;
				if(nullConditionNum.value==4)tableData.value = fp.value
			})
			watch(isValid, (newValue, oldValue) => {
				if(oldValue=='2'&&newValue!='2')nullConditionNum.value = nullConditionNum.value-1;
				else if(oldValue!='2'&&newValue=='2') nullConditionNum.value = nullConditionNum.value+1;
				if(nullConditionNum.value==4)tableData.value = fp.value
			})
			//***********************************  方法区
			function handleRowClick(row, event, column) {
				  route.push({
					  name:'register_detail',
					  query:{
						  num:row.id,
						  name:row.patientName
					  }
				  })
			}
			function cancelRegister(e,id,medicalId){
				axios({
					url:'/registered/deInfo',
					method:'GET',
					params:{
						id:id
					}
				}).then((res)=>{
					if(res.data.resultCode==200){
						console.log('ccccccccccc',medicalId)
						axios({
							url:'/MedicalRecord/Delete',
							method:'GET',
							params:{
								id:medicalId
							}
						}).then((res)=>{
							console.log('bbbbbbbbbbb',res.data)
							window.location.reload()
						}).catch((error)=>{
						})
					}else{
					}
				}).catch((error)=>{
				})
			}
			function Search(){
				axios({
					url:'/registered/secInfo',
					method:'POST',
					data:{
						id:num.value,
						patientName:name.value,
						bookTime:date.value,
						passTime:isValid.value
					}
				}).then((res)=>{
					tableData.value = res.data.data
					fp.value = tableData.value
				}).catch((error)=>{
				})
			}
			
			//*********************************** 返回区域
			return{
				date, 
				num, 
				name, 
				isValid,
				nullConditionNum,
				tableData, 
				fp,
				 
				handleRowClick,
				cancelRegister,
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
		width: 150px;
	}
	.data{
		margin-top: 10px;
		width: 100%;
		height: 540px;
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