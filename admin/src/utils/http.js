import axios from 'axios'
import router from '@/router/router-static'
import storage from '@/utils/storage'
import base from '@/utils/base'

console.log('===== HTTP模块初始化 =====');
console.log('baseURL:', base.get().url);

const http = axios.create({
    timeout: 1000 * 86400,
    withCredentials: true,
    baseURL: base.get().url,
    headers: {
        'Content-Type': 'application/json; charset=utf-8'
    }
})
// 请求拦截
http.interceptors.request.use(config => {
    // 调试日志：记录请求信息
    console.log('HTTP请求开始:', config.url);
    
    let token = storage.get('Token');
    if (token) {
        console.log('Token存在:', token.substring(0, 10) + '...');
        config.headers['Token'] = token;
    } else {
        console.warn('Token不存在，请求可能会失败');
        // 如果是需要Token的API但没有Token，可以尝试重新获取Token
        if (!config.url.includes('login') && !config.url.includes('register')) {
            console.warn('尝试重定向到登录页');
            // 延迟执行，避免阻塞当前请求
            setTimeout(() => {
                router.push({ name: 'login' });
            }, 100);
        }
    }
    
    return config
}, error => {
    console.error('请求拦截器错误:', error);
    return Promise.reject(error)
})
// 响应拦截
http.interceptors.response.use(response => {
    // 调试日志：记录响应信息
    console.log('HTTP响应成功:', response.config.url, response.status);
    
    if (response.data && response.data.code === 401) { // 401, token失效
        console.warn('Token失效，需要重新登录');
        // 清除无效的Token
        storage.remove('Token');
        router.push({ name: 'login' });
    }
    
    return response
}, error => {
    console.error('HTTP响应错误:', error.config ? error.config.url : '未知URL', error.message);
    
    if (!error.response) {
        console.error('网络错误或服务器未响应');
        // 显示全局错误提示
        if (window.Vue && window.Vue.prototype.$message) {
            window.Vue.prototype.$message.error('网络连接失败，请检查您的网络');
        }
        return Promise.reject(error);
    }
    
    switch (error.response.status) {
        case 401: // 401, token失效
            console.warn('Token失效，需要重新登录 (401)');
            // 清除无效的Token
            storage.remove('Token');
            router.push({ name: 'login' });
            break;
        case 403: // 403, 没有权限
            console.warn('没有访问权限 (403)');
            router.push({ name: 'login' });
            break;
        case 404: // 404, 资源不存在
            console.warn('请求的资源不存在 (404)');
            // 可以考虑跳转到404页面
            break;
        case 500: // 500, 服务器错误
            console.error('服务器错误 (500)');
            if (window.Vue && window.Vue.prototype.$message) {
                window.Vue.prototype.$message.error('服务器错误，请稍后再试');
            }
            break;
        default:
            console.error('其他错误:', error.response.status);
    }
    
    return Promise.reject(error)
})

// 添加一个验证Token的方法
http.validateToken = function() {
    const token = storage.get('Token');
    if (!token) {
        console.warn('Token不存在，无法验证');
        return Promise.resolve(false);
    }
    
    return http.get('validate-token', {
        headers: { 'Token': token }
    }).then(res => {
        return res.data && res.data.code === 0;
    }).catch(() => {
        console.error('Token验证失败');
        return false;
    });
};

export default http