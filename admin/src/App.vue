<template>
  <div id="app" class="">
    <router-view></router-view>
    <div v-if="showDebug" class="debug-panel">
      <h3>调试信息</h3>
      <button @click="toggleDebug">隐藏</button>
      <div class="debug-info">
        <p><strong>环境:</strong> {{environment}}</p>
        <p><strong>路由:</strong> {{currentRoute}}</p>
        <p><strong>Token:</strong> {{hasToken ? '存在' : '不存在'}}</p>
        <p><strong>角色:</strong> {{userRole}}</p>
        <p><strong>会话表:</strong> {{sessionTable}}</p>
        <p><strong>用户名:</strong> {{adminName}}</p>
        <p><strong>请求状态:</strong> {{requestStatus}}</p>
        <p><strong>最近错误:</strong> {{lastError}}</p>
      </div>
    </div>
    <div v-else class="debug-toggle">
      <button @click="toggleDebug">调试</button>
    </div>
  </div>
</template>

<script>
import storage from '@/utils/storage';

export default {
  name: "app",
  data() {
    return {
      showDebug: false,
      environment: process.env.NODE_ENV,
      currentRoute: '',
      hasToken: false,
      userRole: '',
      sessionTable: '',
      adminName: '',
      requestStatus: '未发送请求',
      lastError: '无'
    }
  },
  created() {
    // 初始化调试信息
    this.updateDebugInfo();
    
    // 设置定时更新
    setInterval(this.updateDebugInfo, 1000);
    
    // 监听全局错误
    window.addEventListener('error', (event) => {
      this.lastError = `${event.message} (${event.filename}:${event.lineno})`;
    });
    
    // 监听未捕获的Promise错误
    window.addEventListener('unhandledrejection', (event) => {
      this.lastError = `Promise错误: ${event.reason}`;
    });
    
    // 监听HTTP请求
    const originalFetch = window.fetch;
    window.fetch = async (...args) => {
      this.requestStatus = `请求: ${args[0]}`;
      try {
        const response = await originalFetch(...args);
        this.requestStatus = `响应: ${response.status} ${response.statusText}`;
        return response;
      } catch (error) {
        this.requestStatus = `请求错误: ${error.message}`;
        this.lastError = `请求错误: ${error.message}`;
        throw error;
      }
    };
  },
  watch: {
    '$route'(to) {
      this.currentRoute = to.path;
    }
  },
  methods: {
    toggleDebug() {
      this.showDebug = !this.showDebug;
    },
    updateDebugInfo() {
      this.hasToken = !!storage.get('Token');
      this.userRole = storage.get('role') || '未登录';
      this.sessionTable = storage.get('sessionTable') || '无';
      this.adminName = storage.get('adminName') || '无';
      this.currentRoute = this.$route ? this.$route.path : '未知';
    }
  }
};
</script>

<style lang="scss">
*{
  padding: 0;
  margin:0;
}
html,body{
  width: 100%;
  height: 100%;
}
#app{
  height:100%;
}
body {
  padding: 0;
  margin: 0;
}

.debug-panel {
  position: fixed;
  bottom: 0;
  right: 0;
  width: 300px;
  background-color: rgba(0, 0, 0, 0.8);
  color: #fff;
  padding: 10px;
  font-size: 12px;
  z-index: 9999;
  
  h3 {
    margin-bottom: 5px;
    display: inline-block;
  }
  
  button {
    float: right;
    padding: 2px 5px;
    background: #f00;
    color: #fff;
    border: none;
    cursor: pointer;
  }
  
  .debug-info {
    margin-top: 10px;
    
    p {
      margin: 5px 0;
      word-break: break-all;
    }
  }
}

.debug-toggle {
  position: fixed;
  bottom: 10px;
  right: 10px;
  z-index: 9999;
  
  button {
    padding: 5px 10px;
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
}
</style>
