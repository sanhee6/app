<template>
  <div>
    <!-- 上传文件组件 -->
    <el-upload
      ref="upload"
      :action="getActionUrl"
      list-type="picture-card"
      :multiple="multiple"
      :limit="limit"
      :headers="myHeaders"
      :file-list="fileList"
      :on-exceed="handleExceed"
      :on-preview="handleUploadPreview"
      :on-remove="handleRemove"
      :on-success="handleUploadSuccess"
      :on-error="handleUploadErr"
      :before-upload="handleBeforeUpload"
    >
      <i class="el-icon-plus"></i>
      <div slot="tip" class="el-upload__tip" style="color:#838fa1;">{{tip}}</div>
    </el-upload>
    <el-dialog :visible.sync="dialogVisible" size="tiny" append-to-body>
      <img width="100%" :src="dialogImageUrl" alt>
    </el-dialog>
  </div>
</template>
<script>
import storage from "@/utils/storage";
import base from "@/utils/base";
export default {
  data() {
    return {
      // 查看大图
      dialogVisible: false,
      // 查看大图
      dialogImageUrl: "",
      // 组件渲染图片的数组字段，有特殊格式要求
      fileList: [],
      fileUrlList: [],
      myHeaders:{}
    };
  },
  props: ["tip", "action", "limit", "multiple", "fileUrls"],
  created() {
    console.log('FileUpload组件已创建', this.action, this.fileUrls);
  },
  mounted() {
    console.log('FileUpload组件已挂载', this.action, this.fileUrls);
    this.init();
    // 修复Token处理，确保使用正确的Token字段
    const token = storage.get("Token");
    this.myHeaders = {
      'Token': token
    }
    console.log('FileUpload组件Headers:', this.myHeaders);
  },
  watch: {
    fileUrls: function(val, oldVal) {
      console.log("FileUpload fileUrls变化: %s -> %s", oldVal, val);
      this.init();
    }
  },
  computed: {
    // 计算属性的 getter
    getActionUrl: function() {
      // 修复上传URL构建方式
      const url = `/${this.$base.name}/` + this.action;
      console.log('FileUpload上传URL:', url);
      return url;
    }
  },
  methods: {
    // 初始化
    init() {
      console.log('FileUpload初始化，fileUrls:', this.fileUrls);
      if (this.fileUrls) {
        this.fileUrlList = this.fileUrls.split(",");
        let fileArray = [];
        this.fileUrlList.forEach(function(item, index) {
          var url = item;
          var name = index;
          var file = {
            name: name,
            url: url
          };
          fileArray.push(file);
        });
        this.setFileList(fileArray);
        console.log('FileUpload初始化完成，fileList:', this.fileList);
      }
    },
    handleBeforeUpload(file) {
      console.log('FileUpload准备上传文件:', file);
      // 检查Token是否存在，如果不存在则重新获取
      if (!this.myHeaders.Token) {
        const token = storage.get("Token");
        if (token) {
          this.myHeaders.Token = token;
          console.log('FileUpload上传前更新Token:', token);
        } else {
          console.error('FileUpload上传前Token不存在');
        }
      }
    },
    // 上传文件成功后执行
    handleUploadSuccess(res, file, fileList) {
      console.log('FileUpload上传成功:', res);
      if (res && res.code === 0) {
        fileList[fileList.length - 1]["url"] =
          this.$base.url + "upload/" + file.response.file;
        this.setFileList(fileList);
        this.$emit("change", this.fileUrlList.join(","));
      } else {
        this.$message.error(res.msg);
      }
    },
    // 图片上传失败
    handleUploadErr(err, file, fileList) {
      console.error('FileUpload上传失败:', err);
      this.$message.error("文件上传失败");
    },
    // 移除图片
    handleRemove(file, fileList) {
      console.log('FileUpload移除文件:', file);
      this.setFileList(fileList);
      this.$emit("change", this.fileUrlList.join(","));
    },
    // 查看大图
    handleUploadPreview(file) {
      console.log('FileUpload预览文件:', file);
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },
    // 限制图片数量
    handleExceed(files, fileList) {
      console.warn('FileUpload超出限制:', files, fileList);
      this.$message.warning(`最多上传${this.limit}张图片`);
    },
    // 重新对fileList进行赋值
    setFileList(fileList) {
      var fileArray = [];
      var fileUrlArray = [];
      // 有些图片不是公开的，所以需要携带token信息做权限校验
      var token = storage.get("Token");
      fileList.forEach(function(item, index) {
        var url = item.url.split("?")[0];
        var name = item.name;
        var file = {
          name: name,
          url: url + (token ? "?token=" + token : "")
        };
        fileArray.push(file);
        fileUrlArray.push(url);
      });
      this.fileList = fileArray;
      this.fileUrlList = fileUrlArray;
      console.log('FileUpload设置fileList完成:', this.fileList);
    }
  }
};
</script>
<style lang="scss" scoped>
</style>
