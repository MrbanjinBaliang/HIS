<template>
	<div class="preRegister"> 
		<form action="">
			<div class="formTitle">
				<h2>预约挂号</h2>
			</div>
			<div class="form_body">
				<div class="item">
					<span class="itemName">姓 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</span>
					<span class="itemInput">
						<input type="text" class="input" name="patientName" placeholder="输入患者姓名" v-model="patientName">
					</span>
				</div>
				<div class="item">
					<span class="itemName">身份证号</span>
					<span class="itemInput">
						<input type="text" class="input" name="idNum" placeholder="输入18位身份证号" v-model="idNum">
					</span>
				</div>
				<div class="item">
					<span class="itemName">电话号码</span>
					<span class="itemInput">
						<input type="text" class="input" name="phoneNum" placeholder="输入电话号码" v-model="phoneNum">
					</span>
				</div>
				<div class="item">
					<span class="itemName">性 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</span>
					<span class="itemInput">
						<select name="doctor" v-model="sex">
						  <option value="0" selected>男</option>
						  <option value="1">女</option>
						</select>
					</span>
				</div>
				<div class="item">
					<span class="itemName">年 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄</span>
					<span class="itemInput">
						<input type="text" class="input" name="age" placeholder="输入年龄" v-model="age">
					</span>
				</div>
				<div class="item">
					<span class="itemName">选择科室</span>
					<span class="itemInput">
						<select name="room" v-model="selectRoom"> 	 	
						  <option v-for="(item,index) in room" :key="item.id"  :value="item.categoryName">
							  {{item.categoryName}}
						  </option>
						</select>
					</span>
				</div>
				<div class="item">
					<span class="itemName">选择医生</span>
					<span class="itemInput">
						<select name="doctor" v-model="selectDoctor">
						  <option v-for="(item,index) in doctor" :key="item.id" :value="item.name">
							  {{item.name}}
						  </option>
						</select>
					</span>
				</div>
				<div class="item">
					<span class="itemName">预约时间</span>
					<span class="itemInput">
						<input type="date" v-model="date">
						<input type="time" v-model="time" @input="checkTimeRange">
					</span>
				</div>
			</div>
			<div class="sub">
				<el-button @click="Cancel">取消预约</el-button>
				<el-button type="primary" @click="Register">确定预约</el-button>
			</div>
		</form>
	</div>
</template>

<script>
	//引入相关库
	import {h,inject,onBeforeMount,onMounted,ref,useRoute,watch} from 'vue'
	import {useRouter} from 'vue-router'
	import eventBus from '../../eventBus.js'
	//引入组件
	
	export default{
		name:'PreRegister',
		setup() {
			//*********************************** 数据区
			let patientID = ref('')
			let patientName = ref('')
			let idNum = ref('')
			let phoneNum = ref('')
			let sex = ref('')
			let age = ref(0)
			let room = ref('')
			let selectRoom = ref('')
			let doctor = ref('')
			let selectDoctor = ref('')
			let selectDoctorID  =ref('')
			let money = ref('')
			let date = ref('')
			let time = ref('')
			
			const route = useRouter()
			const axios = inject('$axios');
			//*********************************** 生命钩子区
			onBeforeMount(()=>{
				axios({
					url:'/registered/deptInfo',
					method:'GET'
				}).then((res)=>{
					room.value = res.data.data
				}).catch((error)=>{
				})
			})
			
			//***********************************  监听属性 
			watch(selectRoom, (newValue, oldValue) => {
			     selectRoom.value = newValue
			     let deptId = 0;
			     for(var ele of room.value){
			     	if(ele.categoryName==selectRoom.value)deptId = ele.id
			     }
			     axios({
			     	url:'/registered/docInfo',
			     	method:'GET',
			     	params:{
			     		deptId:deptId
			     	}
			     }).then((res)=>{
			     	doctor.value = res.data.data
			     }).catch((error)=>{
			     })
			})
			watch(selectDoctor, (newValue, oldValue) => {
				selectDoctor.value = newValue
				for(var ele of doctor.value){
					if(ele.name==selectDoctor.value){
						money.value = ele.fee
						selectDoctorID.value = ele.id
					}
				}
			})
			watch(idNum, (newValue, oldValue) => {
				if(newValue.length==18){
					
					axios({
						url:'/registered/patInfo',
						method:'GET',
						params:{
							idCard:idNum.value
						}
					}).then((res)=>{
						patientID.value = res.data.data.id
						idNum.value = res.data.data.idCard
						patientName.value = res.data.data.name
						sex.value = res.data.data.sex
						phoneNum.value = res.data.data.telephone
						age.value = res.data.data.year
					}).catch((error)=>{
					})
				}
			})
				
			//***********************************  方法区
		    function checkTimeRange() {
			     
			}
			function Cancel(){
				route.back()
			}
			function Register(){				
				axios({
					url:'/registered/insertInfo',
					method:'POST',
					data:{
						patientId:patientID.value,
						department:selectRoom.value,
						doctor:selectDoctor.value,
						bookTime:date.value+" "+time.value+":00",
						money:money.value,
						registrarId:window.localStorage.getItem('countID'),
					}
				}).then((res)=>{
					console.log('ggggggggggggggggggggg',res.data)
					if(res.data.resultCode==200){
						axios({
						  url:'/MedicalRecord/Create',
						  method:'POST',
						  params:{
							patientId:patientID.value,
							doctorId:selectDoctorID.value,
						    rid:res.data.data.id
						  }
						}).then((res)=>{
							ElMessageBox({
							    title: '挂号预约',
							    message: h('p', null, [
							      h('span', null, '预约成功 !'),
							      h('i', { style: 'color: teal' }, ''),
							    ]),
							  })
							route.push({
								name:'register_log'
							})
						}).catch((error)=>{
						})
					}else{
						ElMessageBox({
						    title: '预约异常',
						    message: h('p', null, [
						      h('span', null, res.data.message+"!"),
						      h('i', { style: 'color: teal' }, ''),
						    ]),
						  })
					}	
				}).catch((error)=>{
				})
			}
			
			//*********************************** 返回区域
			return{
				patientID,
				patientName,
				idNum,
				phoneNum,
				sex,
				age,
				room,
				selectRoom,
				doctor,
				selectDoctor,
				money,
				date,
				time,
				//
				checkTimeRange,
				Cancel,
				Register
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
		background-color: #14539a;
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
	el-button{
		width: 200px;
		height: 40px;
	}
</style>