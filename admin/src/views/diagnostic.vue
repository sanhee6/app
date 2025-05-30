<template>
  <div class="diagnostic-page">
    <h2>系统组件诊断</h2>
    
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>组件加载状态</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="runDiagnostic">重新诊断</el-button>
      </div>
      
      <el-table :data="componentStatus" style="width: 100%">
        <el-table-column prop="name" label="组件名称" width="180"></el-table-column>
        <el-table-column prop="status" label="状态">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status ? 'success' : 'danger'">
              {{ scope.row.status ? '正常' : '异常' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="message" label="详细信息"></el-table-column>
      </el-table>
    </el-card>
    
    <el-card class="box-card" style="margin-top: 20px;">
      <div slot="header" class="clearfix">
        <span>系统环境信息</span>
      </div>
      
      <el-descriptions border>
        <el-descriptions-item label="Vue版本">{{ vueVersion }}</el-descriptions-item>
        <el-descriptions-item label="浏览器">{{ browserInfo }}</el-descriptions-item>
        <el-descriptions-item label="Token状态">
          <el-tag :type="hasToken ? 'success' : 'danger'">
            {{ hasToken ? '存在' : '不存在' }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="基础URL">{{ baseUrl }}</el-descriptions-item>
        <el-descriptions-item label="当前角色">{{ role }}</el-descriptions-item>
      </el-descriptions>
    </el-card>
    
    <el-card class="box-card" style="margin-top: 20px;">
      <div slot="header" class="clearfix">
        <span>问题模块测试</span>
      </div>
      
      <el-tabs v-model="activeModule" type="card">
        <el-tab-pane label="文件上传组件" name="fileUpload">
          <div class="test-component">
            <h3>文件上传组件测试</h3>
            <file-upload
              id="test-file-upload"
              tip="测试上传文件"
              action="file/upload"
              :limit="1"
              :multiple="false"
              @change="handleFileChange"
            ></file-upload>
            <div class="test-result" v-if="testResults.fileUpload">
              <p>测试结果: {{ testResults.fileUpload }}</p>
            </div>
          </div>
        </el-tab-pane>
        
        <el-tab-pane label="富文本编辑器" name="editor">
          <div class="test-component">
            <h3>富文本编辑器测试</h3>
            <editor 
              id="test-editor"
              v-model="editorContent" 
              action="file/upload"
              class="test-editor"
            ></editor>
            <div class="test-result" v-if="testResults.editor">
              <p>测试结果: {{ testResults.editor }}</p>
            </div>
          </div>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import Vue from 'vue'
import ComponentChecker from '@/utils/component-checker'

export default {
  data() {
    return {
      // 组件状态信息
      componentStatus: [
        { name: 'Vue实例', status: true, message: 'Vue已正确加载' },
        { name: '文件上传组件', status: null, message: '未检测' },
        { name: '富文本编辑器', status: null, message: '未检测' },
        { name: 'Token验证', status: null, message: '未检测' }
      ],
      // 系统环境信息
      vueVersion: Vue.version,
      browserInfo: navigator.userAgent,
      hasToken: !!this.$storage.get('Token'),
      baseUrl: this.$base.url,
      role: this.$storage.get('role') || '未登录',
      // 测试相关
      activeModule: 'fileUpload',
      editorContent: '<p>这是一个测试内容</p>',
      testResults: {
        fileUpload: '',
        editor: ''
      }
    }
  },
  mounted() {
    console.log('诊断页面已挂载');
    this.runDiagnostic();
  },
  methods: {
    // 运行诊断
    async runDiagnostic() {
      console.log('开始运行诊断...');
      
      // 检查全局组件注册
      const globalComponents = Vue.options.components;
      const fileUploadRegistered = !!globalComponents['file-upload'];
      const editorRegistered = !!globalComponents['editor'];
      
      this.componentStatus[1].status = fileUploadRegistered;
      this.componentStatus[1].message = fileUploadRegistered ? 
        '组件已全局注册' : '组件未在全局注册，请检查main.js';
      
      this.componentStatus[2].status = editorRegistered;
      this.componentStatus[2].message = editorRegistered ? 
        '组件已全局注册' : '组件未在全局注册，请检查main.js';
      
      // 检查Token
      const token = this.$storage.get('Token');
      this.componentStatus[3].status = !!token;
      this.componentStatus[3].message = token ? 
        `Token存在: ${token.substring(0, 10)}...` : 'Token不存在，请重新登录';
      
      // 检查DOM中的组件
      setTimeout(async () => {
        try {
          const fileUploadExists = await ComponentChecker.checkFileUploadLoaded();
          if (fileUploadExists) {
            this.testResults.fileUpload = '组件已成功加载到DOM';
          } else {
            this.testResults.fileUpload = '组件未能加载到DOM，请检查控制台错误';
          }
          
          const editorExists = await ComponentChecker.checkEditorLoaded();
          if (editorExists) {
            this.testResults.editor = '组件已成功加载到DOM';
          } else {
            this.testResults.editor = '组件未能加载到DOM，请检查控制台错误';
          }
        } catch (err) {
          console.error('诊断过程出错:', err);
        }
      }, 1000);
    },
    
    // 文件上传测试
    handleFileChange(fileUrl) {
      console.log('文件上传测试:', fileUrl);
      this.testResults.fileUpload = `文件上传成功: ${fileUrl}`;
    }
  }
}
</script>

<style scoped>
.diagnostic-page {
  padding: 20px;
}
.box-card {
  margin-bottom: 20px;
}
.test-component {
  padding: 20px;
  border: 1px solid #ebeef5;
  border-radius: 4px;
}
.test-result {
  margin-top: 20px;
  padding: 10px;
  background-color: #f5f7fa;
  border-radius: 4px;
}
.test-editor {
  margin-top: 20px;
  margin-bottom: 20px;
}
</style> 