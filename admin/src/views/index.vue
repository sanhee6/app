<template>
	<el-container>
		<index-header></index-header>
		<el-container>
			<index-aside></index-aside>
			<index-main ref="mainContent"></index-main>
		</el-container>
		<div v-if="debug" class="debug-panel">
			<h3>调试模式 <el-button size="mini" type="danger" @click="closeDebug">关闭</el-button></h3>
			<div class="debug-info">
				<p><strong>当前路径:</strong> {{currentPath}}</p>
				<p><strong>组件状态:</strong> {{componentStatus}}</p>
				<p><strong>Token:</strong> {{hasToken ? '存在' : '不存在'}}</p>
				<p><strong>角色:</strong> {{userRole}}</p>
				<p><strong>错误:</strong> {{errorInfo}}</p>
				<div class="debug-actions">
					<el-button size="mini" @click="refreshPage">刷新页面</el-button>
					<el-button size="mini" @click="clearLocalStorage">清除缓存</el-button>
					<el-button size="mini" @click="goToHome">回主页</el-button>
				</div>
			</div>
		</div>
		<div v-if="!debug" class="debug-toggle">
			<el-button size="mini" type="primary" @click="openDebug">调试</el-button>
		</div>
	</el-container>
</template>
<script>
	import IndexHeader from '@/components/index/IndexHeader'
	import IndexAside from '@/components/index/IndexAsideStatic'
	import IndexMain from '@/components/index/IndexMain'
	import storage from '@/utils/storage'
	
	export default {
		components: {
			IndexHeader,
			IndexAside,
			IndexMain
		},
		data() {
			return {
				debug: false,
				currentPath: '',
				componentStatus: '正常',
				hasToken: false,
				userRole: '',
				errorInfo: '无'
			}
		},
		mounted() {
			console.log('===== 主页面挂载 =====');
			this.updateDebugInfo();
			
			// 注册全局错误处理
			window.addEventListener('error', this.handleGlobalError);
			window.addEventListener('unhandledrejection', this.handlePromiseError);
			
			// 路由变化监听
			this.$router.afterEach((to) => {
				this.currentPath = to.path;
				this.updateDebugInfo();
			});
			
			// 定时更新调试信息
			setInterval(this.updateDebugInfo, 2000);
		},
		beforeDestroy() {
			window.removeEventListener('error', this.handleGlobalError);
			window.removeEventListener('unhandledrejection', this.handlePromiseError);
		},
		methods: {
			updateDebugInfo() {
				this.hasToken = !!storage.get('Token');
				this.userRole = storage.get('role') || '未登录';
				this.currentPath = this.$route ? this.$route.path : '未知';
			},
			handleGlobalError(event) {
				console.error('全局错误:', event);
				this.errorInfo = `${event.message} (${event.filename})`;
				this.componentStatus = '错误';
			},
			handlePromiseError(event) {
				console.error('Promise错误:', event);
				this.errorInfo = `Promise错误: ${event.reason}`;
				this.componentStatus = '错误';
			},
			openDebug() {
				this.debug = true;
				this.updateDebugInfo();
			},
			closeDebug() {
				this.debug = false;
			},
			refreshPage() {
				window.location.reload();
			},
			clearLocalStorage() {
				localStorage.clear();
				this.updateDebugInfo();
				this.$message.success('本地存储已清除');
			},
			goToHome() {
				this.$router.push('/').catch(err => {
					if(err.name !== 'NavigationDuplicated') {
						console.error('导航错误:', err);
					}
				});
			}
		}
	}
</script>

<style lang="scss" scoped>
	// 铺满全屏
	.el-container {
		position: absolute;
		width: 100%;
		top: 0;
		left: 0;
		bottom: 0;
	}
	
	.debug-panel {
		position: fixed;
		right: 10px;
		bottom: 10px;
		width: 300px;
		background-color: rgba(0, 0, 0, 0.8);
		color: #fff;
		padding: 10px;
		border-radius: 5px;
		z-index: 9999;
		
		h3 {
			margin: 0 0 10px 0;
			display: flex;
			justify-content: space-between;
			align-items: center;
		}
		
		.debug-info {
			p {
				margin: 5px 0;
				word-break: break-all;
			}
			
			.debug-actions {
				margin-top: 10px;
				display: flex;
				justify-content: space-between;
			}
		}
	}
	
	.debug-toggle {
		position: fixed;
		right: 10px;
		bottom: 10px;
		z-index: 9999;
	}
</style>
