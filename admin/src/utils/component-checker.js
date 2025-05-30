/**
 * 组件加载检查工具
 * 用于诊断组件加载问题
 */

// 检查DOM中是否存在指定元素
export function checkElementExists(selector, timeout = 2000) {
  return new Promise((resolve) => {
    const startTime = new Date().getTime();
    
    // 立即检查一次
    if (document.querySelector(selector)) {
      console.log(`元素 ${selector} 已找到`);
      resolve(true);
      return;
    }
    
    // 设置定时检查
    const interval = setInterval(() => {
      if (document.querySelector(selector)) {
        console.log(`元素 ${selector} 已找到，耗时 ${new Date().getTime() - startTime}ms`);
        clearInterval(interval);
        resolve(true);
        return;
      }
      
      // 超时处理
      if (new Date().getTime() - startTime > timeout) {
        console.warn(`元素 ${selector} 查找超时`);
        clearInterval(interval);
        resolve(false);
      }
    }, 100);
  });
}

// 检查富文本编辑器是否加载
export function checkEditorLoaded(timeout = 2000) {
  return checkElementExists('.ql-editor', timeout);
}

// 检查文件上传组件是否加载
export function checkFileUploadLoaded(timeout = 2000) {
  return checkElementExists('.el-upload--picture-card', timeout);
}

// 检查Token是否存在
export function checkToken(storage) {
  const token = storage.get('Token');
  if (token) {
    console.log('Token存在:', token.substring(0, 10) + '...');
    return true;
  } else {
    console.warn('Token不存在');
    return false;
  }
}

// 检查Vue实例是否正确加载
export function checkVueInstance(Vue) {
  if (Vue && Vue.version) {
    console.log('Vue实例正常:', Vue.version);
    return true;
  } else {
    console.error('Vue实例异常');
    return false;
  }
}

// 检查HTTP模块是否正常
export function checkHttpModule(http) {
  if (http && typeof http.get === 'function' && typeof http.post === 'function') {
    console.log('HTTP模块正常');
    return true;
  } else {
    console.error('HTTP模块异常');
    return false;
  }
}

// 检查路由是否正常
export function checkRouter(router) {
  if (router && router.currentRoute) {
    console.log('路由模块正常，当前路径:', router.currentRoute.path);
    return true;
  } else {
    console.error('路由模块异常');
    return false;
  }
}

// 执行全面诊断
export function diagnose(Vue, context = {}) {
  console.group('===== 系统组件诊断开始 =====');
  
  const results = {
    vue: checkVueInstance(Vue),
    http: context.http ? checkHttpModule(context.http) : '未提供',
    router: context.router ? checkRouter(context.router) : '未提供',
    token: context.storage ? checkToken(context.storage) : '未提供',
    editor: null,
    fileUpload: null
  };
  
  // 异步检查DOM组件
  setTimeout(async () => {
    results.editor = await checkEditorLoaded();
    results.fileUpload = await checkFileUploadLoaded();
    
    console.log('诊断结果:', results);
    
    // 诊断结论
    if (results.vue && results.http !== false && results.router !== false && results.token !== false) {
      if (results.editor && results.fileUpload) {
        console.log('诊断结论: 系统组件加载正常');
      } else if (!results.editor && !results.fileUpload) {
        console.warn('诊断结论: 富文本编辑器和文件上传组件均未加载，可能是Token问题或组件注册问题');
      } else if (!results.editor) {
        console.warn('诊断结论: 富文本编辑器未加载，可能是组件注册问题');
      } else {
        console.warn('诊断结论: 文件上传组件未加载，可能是组件注册问题');
      }
    } else {
      console.error('诊断结论: 系统核心组件异常，请检查控制台错误');
    }
    
    console.groupEnd();
    return results;
  }, 1000);
}

// 修复常见问题
export function fixCommonIssues(Vue, context = {}) {
  console.group('===== 尝试修复常见问题 =====');
  
  // 1. 尝试修复Token问题
  if (context.storage) {
    const token = context.storage.get('Token');
    if (!token) {
      console.warn('Token不存在，尝试重定向到登录页');
      if (context.router) {
        context.router.push('/login');
      }
    }
  }
  
  // 2. 尝试修复组件注册问题
  if (Vue && !Vue.options.components['file-upload']) {
    console.warn('文件上传组件未全局注册，尝试修复');
    // 这里只是提示，实际修复需要在main.js中进行
  }
  
  if (Vue && !Vue.options.components['editor']) {
    console.warn('富文本编辑器未全局注册，尝试修复');
    // 这里只是提示，实际修复需要在main.js中进行
  }
  
  console.groupEnd();
}

export default {
  checkElementExists,
  checkEditorLoaded,
  checkFileUploadLoaded,
  checkToken,
  checkVueInstance,
  checkHttpModule,
  checkRouter,
  diagnose,
  fixCommonIssues
} 