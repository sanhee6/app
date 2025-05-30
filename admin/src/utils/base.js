/**
 * 基础配置
 */
const base = {
    get() {
        const baseUrl = '/springboot0b6e5';
        console.log('Base: 获取基础URL:', baseUrl);
        return {
            url : baseUrl,
            name: "springboot0b6e5",
            projectName: '在线课程管理系统',
            // 退出到首页链接
            indexUrl: 'http://localhost:8080/springboot0b6e5/front/index.html'
        };
    },
    getProjectName(){
        const projectName = '在线课程管理系统';
        console.log('Base: 获取项目名称:', projectName);
        return projectName;
    }
}
export default base
