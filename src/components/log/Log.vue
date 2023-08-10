<template>
	<!-- 页面结构 -->
	<div class="log_container">
		<span class="loginfoS">
			<span class="title">
				<span class="logo">
					<img src="../../assets/icon/logo.png" alt="">
				</span>
				<h1>欢迎登陆 !</h1>
			</span>
			<span class="body">
				<span class="item">
					<label>用户名 :</label>
					<!-- v-model 用于将输入框元素的 value 值(输入值) 绑定给 Vue 组件中的对应 变量(双向绑定) -->
					<input type="text" name="username" placeholder="输入用户名" v-model="username">
				</span>
				<span class="item">
					<label>密 &nbsp;&nbsp;&nbsp; 码 :</label>
					<input type="text" name="password" placeholder="输入密码" v-model="password">
				</span>
			</span>
			<span class="logBtn">
				<!-- @click 用于将按钮的点击事件函数绑定给 Vue 组件中的方法 -->
				<button @click="Log">登&nbsp;&nbsp;&nbsp;录</button>
			</span>
		</span>
		
	</div>
</template>

<script>
	import {h,inject,ref} from 'vue'
	export default{
		name:'Log',
		setup(){
			//数据区域
			let username = ref('')
			let password = ref('')
			
			const router = inject('router')
			const axios = inject('$axios');
			
			//方法区域
		    function Log(){
				console.log('登录  ',this.username,this.password)
				//登录请求
				axios({
					url:'/main/login',
					method:'POST',
					data:{
						username:this.username,
						password:this.password
					}
				}).then((res)=>{
					console.log(res)
					if(res.data.resultCode==200){
						//模拟角色切换
						const username = this.username;
						const password = this.password;
						
						var role = (res.data.data.type ==1)?'registor':'doctor';
						//存储用户到本地
						window.localStorage.setItem('username',username)
						window.localStorage.setItem('countID',res.data.data.id)			
						router.push({
							name:'main',
							query:{
								role:role
							}	
						})
					}else{
						alert('用户名或密码错误 !')
					}
				}).catch((error)=>{
					console.log(error)
					alert('服务器异常 !')
				})
				
				/* 
				
				//模拟角色切换
				const username = this.username;
				const password = this.password;
				
				var role = (this.username =='reg')?'registor':'doctor';
				//存储用户到本地
				window.localStorage.setItem('username',username)
				window.localStorage.setItem('countID','1')	
							
				this.$router.push({
					name:'main',
					query:{
						role:role
					}	
				})
				 */
				
			}
			
			//返回区
			return{
				username,
				password,
				Log
			}
		}
	}
</script>

<style scoped>
	.log_container{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		height: 100%;
		background-image: url('../../assets/logb.png');
	}
	.loginfoS{
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		border-radius: 5px 5px;
		width: 350px;
		height: 350px;
		background-color: #3d99e4;
		
		padding: 10px;
		box-shadow: 20px 20px 0.95em gray;
	}
	.logo{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		width: 100px;
		height: 100%;
	}
	.logo img{
		width: 100%;
	}
	.title,.logBtn{
		flex: 1;
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		color: white;
	}
	.body{
		flex: 5;
		display: flex;
		flex-direction: column;
		justify-content: space-evenly;
		align-items: center;
		width: 100%;
		color: white;
	}
	button{
		width: 300px;
		height: 40px;
		border: none;
		color: white;
		font-size: 23px;
		background-color: #40b682;
		border-radius: 3px 3px;
	}
	input{
		border:none;
		background: transparent;
		border-bottom: 2px purple solid;
	}
	h1{
		font-family: '幼圆';
	}
</style>