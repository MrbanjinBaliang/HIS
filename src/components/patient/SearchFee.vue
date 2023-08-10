<template>
	<div class="registerLog">
		<div class="con">
			<div class="title">

			</div>
			<div class="op">
				<input type="text" class="opC" placeholder="挂单编号"  v-model="num" >
				<input type="text" class="opC" placeholder="姓名"  v-model="name" >
				<select name="isValid" class="opC" v-model="isConclude">
				  <option value="2" selected>全部</option>	
				  <option value="0">已支付</option>
				  <option value="1">未支付</option>
				</select>
				<select name="isValid" class="opC" v-model="isOvertime">
					<option value="2" selected>全部</option>
				  <option value="1">逾期</option>
				  <option value="0">未逾期</option>
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
					<el-table-column prop="satus" label="是否已付费" >
						 <template #default="scope">
							<!-- 根据 money 的值显示不同的结果 -->
							<span v-if="scope.row.status == 0" style="color: green;font-weight: 100px;">已支付</span>
							<span v-else style="color: red;">未支付</span>
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
		name:'SearchFee',
		setup() {
			//*********************************** 数据区
			let num = ref(null)
			let name = ref(null)
			let isConclude = ref('2')
			let isOvertime = ref('2')
			let nullConditionNum = ref(4)
			
			let tableData = ref([])
			let fp = ref('')
			
			const route = useRouter()
			const axios = inject('$axios')
			//route.currentRoute.value.query
			//*********************************** 生命钩子区
			onBeforeMount(()=>{
				fp.value = tableData.value
				axios({
					url:'/registered/selInfo',
					method:'POST',
					data:{
						id:num.value,
						patientName:name.value,
						status:isConclude.value,
						passTime:isOvertime.value
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
			watch(isConclude, (newValue, oldValue) => {
				if(oldValue=='2'&&newValue!='2')nullConditionNum.value = nullConditionNum.value-1;
				else if(oldValue!='2'&&newValue=='2') nullConditionNum.value = nullConditionNum.value+1;
				if(nullConditionNum.value==4)tableData.value = fp.value
			})
			watch(isOvertime, (newValue, oldValue) => {
				if(oldValue==''&&newValue!='')nullConditionNum.value = nullConditionNum.value-1;
				else if(oldValue!=''&&newValue=='') nullConditionNum.value = nullConditionNum.value+1;
				if(nullConditionNum.value==4)tableData.value = fp.value
			})
			//***********************************  方法区
			function handleRowClick(row, event, column) {
				  route.push({
					  name:'commit_fee',
					  query:{
						  num:row.id
					  }
				  })
			}
			function Search(){
				axios({
					url:'/registered/selInfo',
					method:'POST',
					data:{
						id:num.value,
						patientName:name.value,
						status:isConclude.value,
						passTime:isOvertime.value
					}
				}).then((res)=>{
					tableData.value = res.data.data
					fp.value = tableData.value
				}).catch((error)=>{
				})
			}
			//*********************************** 返回区域
			return{
				num,
				name,
				isConclude,
				isOvertime,
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
		width: 150px;
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