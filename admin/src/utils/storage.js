/**
 * 存储操作封装
 */
const storage = {
    set(key, value) {
        console.log(`Storage: 存储键 "${key}"`, typeof value === 'object' ? '(对象)' : value);
        localStorage.setItem(key, JSON.stringify(value));
    },
    get(key) {
        const value = localStorage.getItem(key);
        if (value === null || value === undefined || value === '') {
            console.log(`Storage: 获取键 "${key}" - 不存在`);
            return null;
        }
        
        try {
            // 尝试解析JSON
            const parsed = JSON.parse(value);
            console.log(`Storage: 获取键 "${key}" - 成功`, typeof parsed === 'object' ? '(对象)' : parsed);
            return parsed;
        } catch (e) {
            console.error(`Storage: 解析键 "${key}" 失败`, e);
            // 如果不是有效的JSON，则直接返回字符串
            return value;
        }
    },
    getObj(key) {
        const value = localStorage.getItem(key);
        if (value === null || value === undefined || value === '') {
            console.log(`Storage: 获取对象键 "${key}" - 不存在`);
            return {};
        }
        
        try {
            const parsed = JSON.parse(value);
            console.log(`Storage: 获取对象键 "${key}" - 成功`);
            return parsed;
        } catch (e) {
            console.error(`Storage: 解析对象键 "${key}" 失败`, e);
            return {};
        }
    },
    remove(key) {
        console.log(`Storage: 删除键 "${key}"`);
        localStorage.removeItem(key);
    },
    clear() {
	localStorage.clear();
    }
}
export default storage;
