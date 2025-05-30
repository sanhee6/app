import Vue from 'vue'
import App from '@/App.vue'
// element ui 完全引入
import ElementUI from 'element-ui'
import '@/assets/css/element-variables.scss'
import '@/assets/css/style.scss'
// 加载路由
// import router from '@/router/router-static.js';
import router from '@/router/router-static.js';
// 面包屑导航，注册为全局组件
import BreadCrumbs from '@/components/common/BreadCrumbs'
// 引入echart
import echarts from 'echarts'
// 引入echart主题
// import  '@/assets/js/echarts-theme-macarons.js'
import 'echarts/theme/macarons.js'
// ajax
import http from '@/utils/http.js'
// 基础配置
import base from '@/utils/base'
// 工具类
import { isAuth, getCurDate, getCurDateTime } from '@/utils/utils'
// storage 封装
import storage from "@/utils/storage";
// 上传组件
import FileUpload from "@/components/common/FileUpload";
// 富文本编辑组件
import Editor from "@/components/common/Editor";
// api 接口
import api from '@/utils/api'
// 数据校验
import * as validate from '@/utils/validate.js'
// 组件诊断工具
import ComponentChecker from '@/utils/component-checker'
//excel导出
import JsonExcel from 'vue-json-excel'
//打印
import printJS from 'print-js'
//MD5
import md5 from 'js-md5';

// 添加全局调试日志
console.log('===== 应用初始化开始 =====');
console.log('当前环境:', process.env.NODE_ENV);
console.log('基础URL:', base.get().url);
console.log('Token状态:', storage.get('Token') ? '已存在' : '不存在');
console.log('当前角色:', storage.get('role'));
console.log('会话表:', storage.get('sessionTable'));

// 增强调试：检查组件是否正确注册
console.log('FileUpload组件状态:', FileUpload ? '已加载' : '未加载');
console.log('Editor组件状态:', Editor ? '已加载' : '未加载');

// 错误处理
Vue.config.errorHandler = function(err, vm, info) {
  console.error('Vue错误:', err);
  console.error('错误信息:', info);
  // 可以在这里添加全局错误处理，比如错误上报
};

// 注册全局组件
Vue.component('bread-crumbs', BreadCrumbs);
Vue.component('file-upload', FileUpload);
Vue.component('editor', Editor);

console.log('全局组件注册状态:');
console.log('- bread-crumbs:', !!Vue.options.components['bread-crumbs']);
console.log('- file-upload:', !!Vue.options.components['file-upload']);
console.log('- editor:', !!Vue.options.components['editor']);

// 添加全局变量
Vue.prototype.$http = http; // ajax请求方法
Vue.prototype.$echarts = echarts;
Vue.prototype.$base = base.get();
Vue.prototype.$project = base.getProjectName();
Vue.prototype.$storage = storage;
Vue.prototype.$api = api;

// 添加全局方法
Vue.prototype.isAuth = isAuth; // 验证是否有权限
Vue.prototype.getCurDate = getCurDate; // 获取当前日期
Vue.prototype.getCurDateTime = getCurDateTime; // 获取当前日期时间

// 初始化ElementUI
Vue.use(ElementUI);

// 路由守卫
router.beforeEach((to, from, next) => {
  console.log('路由跳转:', from.path, '->', to.path);
  
  // 检查是否需要登录
  const token = storage.get('Token');
  if (to.meta.isAuth && !token) {
    console.warn('需要登录但Token不存在，重定向到登录页');
    next({ path: '/login' });
    return;
  }
  
  next();
});

// 路由跳转后
router.afterEach((to) => {
  console.log('路由加载完成:', to.path);
  
  // 添加延迟检查，确保组件正确加载
  setTimeout(() => {
    // 检查页面是否正确渲染
    if (document.querySelector('.el-main') && 
        document.querySelector('.el-main').children.length === 0) {
      console.warn('页面可能未正确渲染，尝试诊断问题');
      ComponentChecker.diagnose(Vue, {
        storage: storage,
        http: http,
        router: router
      });
      
      // 针对学生页面的特殊处理
      if (storage.get('role') === '学生' && to.path.includes('student')) {
        console.log('尝试修复学生页面加载问题');
        // 如果是学生页面，尝试重新加载
        setTimeout(() => {
          if (document.querySelector('.el-main').children.length === 0) {
            console.warn('学生页面未正确加载，尝试重新加载');
            window.location.reload();
          }
        }, 2000);
      }
    }
  }, 1000);
});

// 初始化Vue实例
const app = new Vue({
  router,
  render: h => h(App)
}).$mount('#app');

// 全局诊断
console.log('===== 应用初始化完成 =====');
ComponentChecker.diagnose(Vue, {
  storage: storage,
  http: http,
  router: router
});
