<template>
	<el-main>
		<bread-crumbs :title="title" class="bread-crumbs"></bread-crumbs>
		<div v-if="loadError" class="error-message">
			<h3>加载出错</h3>
			<p>{{errorMessage}}</p>
			<el-button type="primary" @click="refreshView">重新加载</el-button>
		</div>
		<router-view v-else class="router-view" @error="handleComponentError"></router-view>
	</el-main>
</template>
<script>
	import menu from "@/utils/menu";
	export default {
		data() {
			return {
				menuList: [],
				role: "",
				currentIndex: -2,
				itemMenu: [],
				title: '',
				loadError: false,
				errorMessage: ''
			};
		},
		mounted() {
			console.log('===== IndexMain组件挂载 =====');
			let menus = menu.list();
			this.menuList = menus;
			this.role = this.$storage.get("role");
			
			// 添加路由视图变化监听
			this.$router.afterEach((to, from) => {
				console.log('路由变化:', from.path, '->', to.path);
				console.log('路由参数:', to.params);
				this.loadError = false;
			});
		},
		methods: {
			refreshView() {
				this.loadError = false;
				this.$router.go(0); // 刷新当前页面
			},
			handleComponentError(error) {
				console.error('组件加载错误:', error);
				this.loadError = true;
				this.errorMessage = error.message || '组件加载失败';
			},
			menuHandler(menu) {
				console.log('菜单处理:', menu);
				this.$router.push({
					name: menu.tableName
				}).catch(err => {
					console.error('路由跳转错误:', err);
					if(err.name !== 'NavigationDuplicated') {
						this.loadError = true;
						this.errorMessage = err.message;
					}
				});
				this.title = menu.menu;
			},
			titleChange(index, menus) {
				this.currentIndex = index
				this.itemMenu = menus;
				console.log('标题变更:', menus);
			},
			homeChange(index) {
				this.itemMenu = [];
				this.title = ""
				this.currentIndex = index
				this.$router.push({
					name: 'home'
				}).catch(err => {
					console.error('首页跳转错误:', err);
					if(err.name !== 'NavigationDuplicated') {
						this.loadError = true;
						this.errorMessage = err.message;
					}
				});
			},
			centerChange(index) {
				this.itemMenu = [{
					"buttons": ["新增", "查看", "修改", "删除"],
					"menu": "修改密码",
					"tableName": "updatePassword"
				}, {
					"buttons": ["新增", "查看", "修改", "删除"],
					"menu": "个人信息",
					"tableName": "center"
				}];
				this.title = ""
				this.currentIndex = index
				this.$router.push({
					name: 'home'
				}).catch(err => {
					console.error('中心页跳转错误:', err);
					if(err.name !== 'NavigationDuplicated') {
						this.loadError = true;
						this.errorMessage = err.message;
					}
				});
			}
		}
	};
</script>
<style lang="scss" scoped>
	a {
		text-decoration: none;
		color: #555;
	}

	a:hover {
		background: #00c292;
	}

	.nav-list {
		width: 100%;
		margin: 0 auto;
		text-align: left;
		margin-top: 20px;

		.nav-title {
			display: inline-block;
			font-size: 15px;
			color: #333;
			padding: 15px 25px;
			border: none;
		}

		.nav-title.active {
			color: #555;
			cursor: default;
			background-color: #fff;
		}
	}

	.nav-item {
		margin-top: 20px;
		background: #FFFFFF;
		padding: 15px 0;

		.menu {
			padding: 15px 25px;
		}
	}

	.el-main {
		background-color: #F6F8FA;
		padding: 0 24px;
		// padding-top: 60px;
	}

	.router-view {
		padding: 10px;
		margin-top: 10px;
		background: #FFFFFF;
		box-sizing: border-box;
	}

	.bread-crumbs {
		width: 100%;
		// border-bottom: 1px solid #e9eef3;
		// border-top: 1px solid #e9eef3;
		margin-top: 10px;
		box-sizing: border-box;
	}
	
	.error-message {
		padding: 20px;
		margin-top: 10px;
		background: #FFFFFF;
		box-sizing: border-box;
		text-align: center;
		color: #f56c6c;
		
		h3 {
			margin-bottom: 15px;
		}
		
		p {
			margin-bottom: 20px;
		}
	}
</style>
