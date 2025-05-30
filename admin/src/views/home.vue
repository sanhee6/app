<template>
<div class="content">

<div class="text main-text">欢迎使用 {{this.$project.projectName}}</div>

<div v-if="userInfo" class="user-info">
  <h3>当前用户信息</h3>
  <p><strong>用户ID:</strong> {{userInfo.id}}</p>
  <p><strong>用户名:</strong> {{userInfo.username}}</p>
  <p><strong>角色:</strong> {{userInfo.role}}</p>
  <p><strong>表名:</strong> {{userInfo.tableName}}</p>
</div>

<div v-if="!userInfo" class="error-info">
  <h3>用户未登录或会话已失效</h3>
  <p><strong>Token状态:</strong> {{tokenStatus}}</p>
  <p><strong>错误信息:</strong> {{errorMsg}}</p>
  <button @click="reloadPage" class="reload-btn">重新加载</button>
</div>

</div>
</template>
<script>
import router from '@/router/router-static'
export default {
  data() {
    return {
      userInfo: null,
      tokenStatus: '正在检查...',
      errorMsg: ''
    }
  },
  mounted(){
    console.log('===== 首页组件挂载 =====');
    this.init();
  },
  methods:{
    reloadPage() {
      window.location.reload();
    },
    init(){
        console.log('===== 首页初始化 =====');
        const token = this.$storage.get('Token');
        console.log('当前Token:', token);
        
        this.tokenStatus = token ? '已存在' : '不存在';
        
        if(token){
          console.log('Token存在，发送session请求');
          this.$http({
              url: `/session`,
              method: "get"
          }).then(({ data }) => {
              console.log('session响应:', data);
              if (data && data.code === 0) {
                  console.log('session请求成功，用户信息:', data.data);
                  this.userInfo = data.data;
              } else {
                  console.warn('session请求失败，需要重新登录');
                  this.errorMsg = data.msg || '会话无效';
                  if(this.$router.currentRoute.name !== 'login') {
                      console.log('跳转到登录页');
                      this.$router.push({ name: 'login' }).catch(err => {
                          // 忽略重复导航的错误
                          if(err.name !== 'NavigationDuplicated') {
                              throw err;
                          }
                          console.log('忽略重复导航错误');
                      })
                  }
              }
          }).catch(error => {
              console.error('session请求异常:', error);
              this.errorMsg = error.message || '网络请求异常';
              if(this.$router.currentRoute.name !== 'login') {
                  console.log('跳转到登录页');
                  this.$router.push({ name: 'login' }).catch(err => {
                      // 忽略重复导航的错误
                      if(err.name !== 'NavigationDuplicated') {
                          throw err;
                      }
                      console.log('忽略重复导航错误');
                  })
              }
          });
        } else {
            console.warn('Token不存在，需要登录');
            this.errorMsg = 'Token不存在，请先登录';
            if(this.$router.currentRoute.name !== 'login') {
                console.log('跳转到登录页');
                this.$router.push({ name: 'login' }).catch(err => {
                    // 忽略重复导航的错误
                    if(err.name !== 'NavigationDuplicated') {
                        throw err;
                    }
                    console.log('忽略重复导航错误');
                })
            }
        }
    }
  }
};
</script>

<style lang="scss" scoped>
.content {
  display: flex;
  align-items: center;
  flex-direction: column;
  width: 100%;
  height: 100%;
  min-height: 500px;
  text-align: center;
  .main-text{
    font-size: 38px;
    font-weight: bold;
    margin-top: 15%;
    margin-bottom: 30px;
  }
  .text {
    font-size: 24px;
    font-weight: bold;
    color: #333;
  }
  
  .user-info, .error-info {
    width: 400px;
    margin: 20px auto;
    padding: 20px;
    border-radius: 5px;
    text-align: left;
    
    h3 {
      text-align: center;
      margin-bottom: 15px;
    }
    
    p {
      margin: 10px 0;
    }
  }
  
  .user-info {
    background-color: #f0f9eb;
    border: 1px solid #e1f3d8;
  }
  
  .error-info {
    background-color: #fef0f0;
    border: 1px solid #fde2e2;
    
    .reload-btn {
      display: block;
      margin: 15px auto 0;
      padding: 8px 15px;
      background-color: #409eff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
  }
}
</style>
