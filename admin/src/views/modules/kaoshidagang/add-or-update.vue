<template>
  <div class="addEdit-block">
    <!-- 调试信息 -->
    <div class="debug-info" style="background: #f0f0f0; padding: 10px; margin-bottom: 10px; border: 1px solid #ddd;">
      <h3>组件调试信息</h3>
      <p>组件已加载: 是</p>
      <p>表单状态: {{ruleForm ? '已初始化' : '未初始化'}}</p>
      <p>类型: {{type}}</p>
      <p>ID: {{id}}</p>
      <p>当前路径: {{$route.path}}</p>
      <button @click="refreshComponent">刷新组件</button>
    </div>
    
    <el-form
      class="detail-form-content"
      ref="ruleForm"
      :model="ruleForm"
      :rules="rules"
      label-width="80px"
	  :style="{backgroundColor:addEditForm.addEditBoxColor}"
    >
      <el-row>
      <el-col :span="12">
        <el-form-item class="input" v-if="type!='info'" label="课程名称" prop="kechengmingcheng" for="kechengmingcheng">
          <el-input v-model="ruleForm.kechengmingcheng" 
              placeholder="课程名称" clearable :readonly="ro.kechengmingcheng" id="kechengmingcheng"></el-input>
        </el-form-item>
        <div v-else>
          <el-form-item class="input" label="课程名称" prop="kechengmingcheng" for="kechengmingcheng-info">
              <el-input v-model="ruleForm.kechengmingcheng" 
                placeholder="课程名称" readonly id="kechengmingcheng-info"></el-input>
          </el-form-item>
        </div>
      </el-col>
      <el-col :span="12">
        <el-form-item class="input" v-if="type!='info'" label="科目类型" prop="kemuleixing" for="kemuleixing">
          <el-input v-model="ruleForm.kemuleixing" 
              placeholder="科目类型" clearable :readonly="ro.kemuleixing" id="kemuleixing"></el-input>
        </el-form-item>
        <div v-else>
          <el-form-item class="input" label="科目类型" prop="kemuleixing" for="kemuleixing-info">
              <el-input v-model="ruleForm.kemuleixing" 
                placeholder="科目类型" readonly id="kemuleixing-info"></el-input>
          </el-form-item>
        </div>
      </el-col>
      <el-col :span="24">  
        <el-form-item class="upload" v-if="type!='info' && !ro.kechengtupian" label="课程图片" prop="kechengtupian" for="kechengtupian">
          <file-upload
          tip="点击上传课程图片"
          action="file/upload"
          :limit="3"
          :multiple="true"
          :fileUrls="ruleForm.kechengtupian?ruleForm.kechengtupian:''"
          @change="kechengtupianUploadChange"
          id="kechengtupian"
          ></file-upload>
        </el-form-item>
        <div v-else>
          <el-form-item v-if="ruleForm.kechengtupian" label="课程图片" prop="kechengtupian">
            <img style="margin-right:20px;" v-bind:key="index" v-for="(item,index) in ruleForm.kechengtupian.split(',')" :src="item" width="100" height="100">
          </el-form-item>
        </div>
      </el-col>
      <el-col :span="12">
        <el-form-item class="input" v-if="type!='info'" label="教师工号" prop="jiaoshigonghao" for="jiaoshigonghao">
          <el-input v-model="ruleForm.jiaoshigonghao" 
              placeholder="教师工号" clearable :readonly="ro.jiaoshigonghao" id="jiaoshigonghao"></el-input>
        </el-form-item>
        <div v-else>
          <el-form-item class="input" label="教师工号" prop="jiaoshigonghao" for="jiaoshigonghao-info">
              <el-input v-model="ruleForm.jiaoshigonghao" 
                placeholder="教师工号" readonly id="jiaoshigonghao-info"></el-input>
          </el-form-item>
        </div>
      </el-col>
      <el-col :span="12">
        <el-form-item class="input" v-if="type!='info'" label="教师姓名" prop="jiaoshixingming" for="jiaoshixingming">
          <el-input v-model="ruleForm.jiaoshixingming" 
              placeholder="教师姓名" clearable :readonly="ro.jiaoshixingming" id="jiaoshixingming"></el-input>
        </el-form-item>
        <div v-else>
          <el-form-item class="input" label="教师姓名" prop="jiaoshixingming" for="jiaoshixingming-info">
              <el-input v-model="ruleForm.jiaoshixingming" 
                placeholder="教师姓名" readonly id="jiaoshixingming-info"></el-input>
          </el-form-item>
        </div>
      </el-col>
      </el-row>
          <el-row>
            <el-col :span="24">
              <el-form-item class="textarea" v-if="type!='info'" label="考点内容" prop="kaodianneirong" for="kaodianneirong">
                <el-input
                  style="min-width: 200px; max-width: 600px;"
                  type="textarea"
                  :rows="8"
                  placeholder="考点内容"
                  v-model="ruleForm.kaodianneirong"
                  id="kaodianneirong">
                </el-input>
              </el-form-item>
              <div v-else>
                <el-form-item v-if="ruleForm.kaodianneirong" label="考点内容" prop="kaodianneirong">
                    <span>{{ruleForm.kaodianneirong}}</span>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="24">
              <el-form-item class="textarea" v-if="type!='info'" label="注意事项" prop="zhuyishixiang" for="zhuyishixiang">
                <el-input
                  style="min-width: 200px; max-width: 600px;"
                  type="textarea"
                  :rows="8"
                  placeholder="注意事项"
                  v-model="ruleForm.zhuyishixiang"
                  id="zhuyishixiang">
                </el-input>
              </el-form-item>
              <div v-else>
                <el-form-item v-if="ruleForm.zhuyishixiang" label="注意事项" prop="zhuyishixiang">
                    <span>{{ruleForm.zhuyishixiang}}</span>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="24">
              <el-form-item v-if="type!='info'" label="考点分析" prop="kaodianfenxi" for="kaodianfenxi">
                <editor 
                    style="min-width: 200px; max-width: 600px;"
                    v-model="ruleForm.kaodianfenxi" 
                    class="editor" 
                    action="file/upload"
                    id="kaodianfenxi">
                </editor>
              </el-form-item>
              <div v-else>
                <el-form-item v-if="ruleForm.kaodianfenxi" label="考点分析" prop="kaodianfenxi">
                    <span v-html="ruleForm.kaodianfenxi"></span>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
      <el-form-item class="btn">
        <el-button v-if="type!='info'" type="primary" class="btn-success" @click="onSubmit">提交</el-button>
        <el-button v-if="type!='info'" class="btn-close" @click="back()">取消</el-button>
        <el-button v-if="type=='info'" class="btn-close" @click="back()">返回</el-button>
      </el-form-item>
    </el-form>
    

  </div>
</template>
<script>
// 数字，邮件，手机，url，身份证校验
import { isNumber,isIntNumer,isEmail,isPhone, isMobile,isURL,checkIdCard } from "@/utils/validate";
export default {
  data() {
    let self = this
    var validateIdCard = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!checkIdCard(value)) {
        callback(new Error("请输入正确的身份证号码"));
      } else {
        callback();
      }
    };
    var validateUrl = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isURL(value)) {
        callback(new Error("请输入正确的URL地址"));
      } else {
        callback();
      }
    };
    var validateMobile = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isMobile(value)) {
        callback(new Error("请输入正确的手机号码"));
      } else {
        callback();
      }
    };
    var validatePhone = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isPhone(value)) {
        callback(new Error("请输入正确的电话号码"));
      } else {
        callback();
      }
    };
    var validateEmail = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isEmail(value)) {
        callback(new Error("请输入正确的邮箱地址"));
      } else {
        callback();
      }
    };
    var validateNumber = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isNumber(value)) {
        callback(new Error("请输入数字"));
      } else {
        callback();
      }
    };
    var validateIntNumber = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isIntNumer(value)) {
        callback(new Error("请输入整数"));
      } else {
        callback();
      }
    };
    return {
	  addEditForm: {"btnSaveFontColor":"#fff","selectFontSize":"14px","btnCancelBorderColor":"#DCDFE6","inputBorderRadius":"4px","inputFontSize":"14px","textareaBgColor":"#fff","btnSaveFontSize":"14px","textareaBorderRadius":"4px","uploadBgColor":"#fff","textareaBorderStyle":"solid","btnCancelWidth":"88px","textareaHeight":"120px","dateBgColor":"#fff","btnSaveBorderRadius":"4px","uploadLableFontSize":"14px","textareaBorderWidth":"1px","inputLableColor":"#606266","addEditBoxColor":"#fff","dateIconFontSize":"14px","btnSaveBgColor":"rgba(36, 194, 205, 1)","uploadIconFontColor":"#8c939d","textareaBorderColor":"#DCDFE6","btnCancelBgColor":"#ecf5ff","selectLableColor":"#606266","btnSaveBorderStyle":"solid","dateBorderWidth":"1px","dateLableFontSize":"14px","dateBorderRadius":"4px","btnCancelBorderStyle":"solid","selectLableFontSize":"14px","selectBorderStyle":"solid","selectIconFontColor":"#C0C4CC","btnCancelHeight":"44px","inputHeight":"40px","btnCancelFontColor":"#606266","dateBorderColor":"#DCDFE6","dateIconFontColor":"#C0C4CC","uploadBorderStyle":"solid","dateBorderStyle":"solid","dateLableColor":"#606266","dateFontSize":"14px","inputBorderWidth":"1px","uploadIconFontSize":"28px","selectHeight":"40px","inputFontColor":"#606266","uploadHeight":"148px","textareaLableColor":"#606266","textareaLableFontSize":"14px","btnCancelFontSize":"14px","inputBorderStyle":"solid","btnCancelBorderRadius":"4px","inputBgColor":"#fff","inputLableFontSize":"14px","uploadLableColor":"#606266","uploadBorderRadius":"4px","btnSaveHeight":"44px","selectBgColor":"#fff","btnSaveWidth":"88px","selectIconFontSize":"14px","dateHeight":"40px","selectBorderColor":"#DCDFE6","inputBorderColor":"#DCDFE6","uploadBorderColor":"#DCDFE6","textareaFontColor":"#606266","selectBorderWidth":"1px","dateFontColor":"#606266","btnCancelBorderWidth":"1px","uploadBorderWidth":"1px","textareaFontSize":"14px","selectBorderRadius":"4px","selectFontColor":"#606266","btnSaveBorderColor":"#409EFF","btnSaveBorderWidth":"0px"},
      id: '',
      type: '',
      ro:{
	kechengmingcheng : false,
	kemuleixing : false,
	kaodianneirong : false,
	zhuyishixiang : false,
	kaodianfenxi : false,
	kechengtupian : false,
	jiaoshigonghao : false,
	jiaoshixingming : false,
      },
      ruleForm: {
        kechengmingcheng: '',
        kemuleixing: '',
        kaodianneirong: '',
        zhuyishixiang: '',
        kaodianfenxi: '',
        kechengtupian: '',
        jiaoshigonghao: '',
        jiaoshixingming: '',
      },
      rules: {
          kechengmingcheng: [
          ],
          kemuleixing: [
          ],
          kaodianneirong: [
          ],
          zhuyishixiang: [
          ],
          kaodianfenxi: [
          ],
          kechengtupian: [
          ],
          jiaoshigonghao: [
          ],
          jiaoshixingming: [
          ],
      }
    };
  },
  props: ["parent"],
  computed: {
  },
  created() {
    console.log('考试大纲添加/更新组件已创建');
	this.addEditStyleChange()
	this.addEditUploadStyleChange()
  },
  mounted() {
    console.log('考试大纲添加/更新组件已挂载');
  },
  methods: {
    refreshComponent() {
      console.log('手动刷新组件');
      this.addEditStyleChange();
      this.addEditUploadStyleChange();
    },
    // 下载
    download(file){
      window.open(`${file}`)
    },
    // 初始化
    init(id,type) {
      console.log('初始化组件:', id, type);
      if (id) {
        this.id = id;
        this.type = type;
      }
      if(this.type=='info'||this.type=='else'){
        this.info(id);
      }else if(this.type=='cross'){
        var obj = this.$storage.getObj('crossObj');
        console.log('cross对象:', obj);
        for (var o in obj){
          if(o=='kechengmingcheng'){
            this.ruleForm.kechengmingcheng = obj[o];
	    this.ro.kechengmingcheng = true;
            continue;
          }
          if(o=='kemuleixing'){
            this.ruleForm.kemuleixing = obj[o];
	    this.ro.kemuleixing = true;
            continue;
          }
          if(o=='kaodianneirong'){
            this.ruleForm.kaodianneirong = obj[o];
	    this.ro.kaodianneirong = true;
            continue;
          }
          if(o=='zhuyishixiang'){
            this.ruleForm.zhuyishixiang = obj[o];
	    this.ro.zhuyishixiang = true;
            continue;
          }
          if(o=='kaodianfenxi'){
            this.ruleForm.kaodianfenxi = obj[o];
	    this.ro.kaodianfenxi = true;
            continue;
          }
          if(o=='kechengtupian'){
            this.ruleForm.kechengtupian = obj[o];
	    this.ro.kechengtupian = true;
            continue;
          }
          if(o=='jiaoshigonghao'){
            this.ruleForm.jiaoshigonghao = obj[o];
	    this.ro.jiaoshigonghao = true;
            continue;
          }
          if(o=='jiaoshixingming'){
            this.ruleForm.jiaoshixingming = obj[o];
	    this.ro.jiaoshixingming = true;
            continue;
          }
        }
      }
      // 获取用户信息
      this.$http({
        url: `${this.$storage.get('sessionTable')}/session`,
        method: "get"
      }).then(({ data }) => {
        console.log('获取用户信息成功:', data);
        if (data && data.code === 0) {
          var json = data.data;
		if(json.jiaoshigonghao!=''&&json.jiaoshigonghao){
              		this.ruleForm.jiaoshigonghao = json.jiaoshigonghao
		}
		if(json.jiaoshixingming!=''&&json.jiaoshixingming){
              		this.ruleForm.jiaoshixingming = json.jiaoshixingming
		}
        } else {
          this.$message.error(data.msg);
        }
      }).catch(err => {
        console.error('获取用户信息失败:', err);
      });
    },
    // 多级联动参数
    info(id) {
      console.log('获取详情信息:', id);
      
      // 检查Token是否存在
      const token = this.$storage.get('Token');
      if (!token) {
        console.error('获取详情信息失败: Token不存在');
        this.$message.error('您的登录已过期，请重新登录');
        setTimeout(() => {
          this.$router.push({ path: '/login' });
        }, 1500);
        return;
      }
      
      this.$http({
        url: `kaoshidagang/info/${id}`,
        method: "get"
      }).then(({ data }) => {
        console.log('获取详情成功:', data);
        if (data && data.code === 0) {
        this.ruleForm = data.data;
	//解决前台上传图片后台不显示的问题
	let reg=new RegExp('../../../upload','g')//g代表全部
	this.ruleForm.kaodianfenxi = this.ruleForm.kaodianfenxi.replace(reg,'../../../springboot0b6e5/upload');
        } else {
          this.$message.error(data.msg);
        }
      }).catch(err => {
        console.error('获取详情失败:', err);
      });
    },
    // 提交
    onSubmit() {
      // ${column.compare}
      // ${column.compare}
      // ${column.compare}
      // ${column.compare}
      // ${column.compare}
      // ${column.compare}
      // ${column.compare}
      // ${column.compare}








      this.$refs["ruleForm"].validate(valid => {
        if (valid) {
          this.$http({
            url: `kaoshidagang/${!this.ruleForm.id ? "save" : "update"}`,
            method: "post",
            data: this.ruleForm
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({
                message: "操作成功",
                type: "success",
                duration: 1500,
                onClose: () => {
                  this.parent.showFlag = true;
                  this.parent.addOrUpdateFlag = false;
                  this.parent.kaoshidagangCrossAddOrUpdateFlag = false;
                  this.parent.search();
                  this.parent.contentStyleChange();
                }
              });
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    },
    // 获取uuid
    getUUID () {
      return new Date().getTime();
    },
    // 返回
    back() {
      this.parent.showFlag = true;
      this.parent.addOrUpdateFlag = false;
      this.parent.kaoshidagangCrossAddOrUpdateFlag = false;
      this.parent.contentStyleChange();
    },
    kechengtupianUploadChange(fileUrls) {
	this.ruleForm.kechengtupian = fileUrls;
			this.addEditUploadStyleChange()
    },
	addEditStyleChange() {
	  this.$nextTick(()=>{
	    // input
	    document.querySelectorAll('.addEdit-block .input .el-input__inner').forEach(el=>{
	      el.style.height = this.addEditForm.inputHeight
	      el.style.color = this.addEditForm.inputFontColor
	      el.style.fontSize = this.addEditForm.inputFontSize
	      el.style.borderWidth = this.addEditForm.inputBorderWidth
	      el.style.borderStyle = this.addEditForm.inputBorderStyle
	      el.style.borderColor = this.addEditForm.inputBorderColor
	      el.style.borderRadius = this.addEditForm.inputBorderRadius
	      el.style.backgroundColor = this.addEditForm.inputBgColor
	    })
	    document.querySelectorAll('.addEdit-block .input .el-form-item__label').forEach(el=>{
	      el.style.lineHeight = this.addEditForm.inputHeight
	      el.style.color = this.addEditForm.inputLableColor
	      el.style.fontSize = this.addEditForm.inputLableFontSize
	    })
	    // select
	    document.querySelectorAll('.addEdit-block .select .el-input__inner').forEach(el=>{
	      el.style.height = this.addEditForm.selectHeight
	      el.style.color = this.addEditForm.selectFontColor
	      el.style.fontSize = this.addEditForm.selectFontSize
	      el.style.borderWidth = this.addEditForm.selectBorderWidth
	      el.style.borderStyle = this.addEditForm.selectBorderStyle
	      el.style.borderColor = this.addEditForm.selectBorderColor
	      el.style.borderRadius = this.addEditForm.selectBorderRadius
	      el.style.backgroundColor = this.addEditForm.selectBgColor
	    })
	    document.querySelectorAll('.addEdit-block .select .el-form-item__label').forEach(el=>{
	      el.style.lineHeight = this.addEditForm.selectHeight
	      el.style.color = this.addEditForm.selectLableColor
	      el.style.fontSize = this.addEditForm.selectLableFontSize
	    })
	    document.querySelectorAll('.addEdit-block .select .el-select__caret').forEach(el=>{
	      el.style.color = this.addEditForm.selectIconFontColor
	      el.style.fontSize = this.addEditForm.selectIconFontSize
	    })
	    // date
	    document.querySelectorAll('.addEdit-block .date .el-input__inner').forEach(el=>{
	      el.style.height = this.addEditForm.dateHeight
	      el.style.color = this.addEditForm.dateFontColor
	      el.style.fontSize = this.addEditForm.dateFontSize
	      el.style.borderWidth = this.addEditForm.dateBorderWidth
	      el.style.borderStyle = this.addEditForm.dateBorderStyle
	      el.style.borderColor = this.addEditForm.dateBorderColor
	      el.style.borderRadius = this.addEditForm.dateBorderRadius
	      el.style.backgroundColor = this.addEditForm.dateBgColor
	    })
	    document.querySelectorAll('.addEdit-block .date .el-form-item__label').forEach(el=>{
	      el.style.lineHeight = this.addEditForm.dateHeight
	      el.style.color = this.addEditForm.dateLableColor
	      el.style.fontSize = this.addEditForm.dateLableFontSize
	    })
	    document.querySelectorAll('.addEdit-block .date .el-input__icon').forEach(el=>{
	      el.style.color = this.addEditForm.dateIconFontColor
	      el.style.fontSize = this.addEditForm.dateIconFontSize
	      el.style.lineHeight = this.addEditForm.dateHeight
	    })
	    // upload
	    let iconLineHeight = parseInt(this.addEditForm.uploadHeight) - parseInt(this.addEditForm.uploadBorderWidth) * 2 + 'px'
	    document.querySelectorAll('.addEdit-block .upload .el-upload--picture-card').forEach(el=>{
	      el.style.width = this.addEditForm.uploadHeight
	      el.style.height = this.addEditForm.uploadHeight
	      el.style.borderWidth = this.addEditForm.uploadBorderWidth
	      el.style.borderStyle = this.addEditForm.uploadBorderStyle
	      el.style.borderColor = this.addEditForm.uploadBorderColor
	      el.style.borderRadius = this.addEditForm.uploadBorderRadius
	      el.style.backgroundColor = this.addEditForm.uploadBgColor
	    })
	    document.querySelectorAll('.addEdit-block .upload .el-form-item__label').forEach(el=>{
	      el.style.lineHeight = this.addEditForm.uploadHeight
	      el.style.color = this.addEditForm.uploadLableColor
	      el.style.fontSize = this.addEditForm.uploadLableFontSize
	    })
	    document.querySelectorAll('.addEdit-block .upload .el-icon-plus').forEach(el=>{
	      el.style.color = this.addEditForm.uploadIconFontColor
	      el.style.fontSize = this.addEditForm.uploadIconFontSize
	      el.style.lineHeight = iconLineHeight
	      el.style.display = 'block'
	    })
	    // 多文本输入框
	    document.querySelectorAll('.addEdit-block .textarea .el-textarea__inner').forEach(el=>{
	      el.style.height = this.addEditForm.textareaHeight
	      el.style.color = this.addEditForm.textareaFontColor
	      el.style.fontSize = this.addEditForm.textareaFontSize
	      el.style.borderWidth = this.addEditForm.textareaBorderWidth
	      el.style.borderStyle = this.addEditForm.textareaBorderStyle
	      el.style.borderColor = this.addEditForm.textareaBorderColor
	      el.style.borderRadius = this.addEditForm.textareaBorderRadius
	      el.style.backgroundColor = this.addEditForm.textareaBgColor
	    })
	    document.querySelectorAll('.addEdit-block .textarea .el-form-item__label').forEach(el=>{
	      // el.style.lineHeight = this.addEditForm.textareaHeight
	      el.style.color = this.addEditForm.textareaLableColor
	      el.style.fontSize = this.addEditForm.textareaLableFontSize
	    })
	    // 保存
	    document.querySelectorAll('.addEdit-block .btn .btn-success').forEach(el=>{
	      el.style.width = this.addEditForm.btnSaveWidth
	      el.style.height = this.addEditForm.btnSaveHeight
	      el.style.color = this.addEditForm.btnSaveFontColor
	      el.style.fontSize = this.addEditForm.btnSaveFontSize
	      el.style.borderWidth = this.addEditForm.btnSaveBorderWidth
	      el.style.borderStyle = this.addEditForm.btnSaveBorderStyle
	      el.style.borderColor = this.addEditForm.btnSaveBorderColor
	      el.style.borderRadius = this.addEditForm.btnSaveBorderRadius
	      el.style.backgroundColor = this.addEditForm.btnSaveBgColor
	    })
	    // 返回
	    document.querySelectorAll('.addEdit-block .btn .btn-close').forEach(el=>{
	      el.style.width = this.addEditForm.btnCancelWidth
	      el.style.height = this.addEditForm.btnCancelHeight
	      el.style.color = this.addEditForm.btnCancelFontColor
	      el.style.fontSize = this.addEditForm.btnCancelFontSize
	      el.style.borderWidth = this.addEditForm.btnCancelBorderWidth
	      el.style.borderStyle = this.addEditForm.btnCancelBorderStyle
	      el.style.borderColor = this.addEditForm.btnCancelBorderColor
	      el.style.borderRadius = this.addEditForm.btnCancelBorderRadius
	      el.style.backgroundColor = this.addEditForm.btnCancelBgColor
	    })
	  })
	},
	addEditUploadStyleChange() {
		this.$nextTick(()=>{
		  document.querySelectorAll('.addEdit-block .upload .el-upload-list--picture-card .el-upload-list__item').forEach(el=>{
			el.style.width = this.addEditForm.uploadHeight
			el.style.height = this.addEditForm.uploadHeight
			el.style.borderWidth = this.addEditForm.uploadBorderWidth
			el.style.borderStyle = this.addEditForm.uploadBorderStyle
			el.style.borderColor = this.addEditForm.uploadBorderColor
			el.style.borderRadius = this.addEditForm.uploadBorderRadius
			el.style.backgroundColor = this.addEditForm.uploadBgColor
		  })
	  })
	},
  }
};
</script>
<style lang="scss">
.editor{
  height: 500px;
  
  ::v-deep .ql-container {
	  height: 310px;
  }
}
.amap-wrapper {
  width: 100%;
  height: 500px;
}
.search-box {
  position: absolute;
}
.addEdit-block {
	margin: -10px;
}
.detail-form-content {
	padding: 12px;
}
.btn .el-button {
  padding: 0;
}
</style>
