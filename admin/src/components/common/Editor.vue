<template>
  <div>
    <!-- 图片上传组件辅助-->
    <el-upload
      class="avatar-uploader"
      :action="getActionUrl"
      name="file"
      :headers="header"
      :show-file-list="false"
      :on-success="uploadSuccess"
      :on-error="uploadError"
      :before-upload="beforeUpload"
    ></el-upload>

    <quill-editor
      class="editor"
      v-model="value"
      ref="myQuillEditor"
      :options="editorOption"
      @blur="onEditorBlur($event)"
      @focus="onEditorFocus($event)"
      @change="onEditorChange($event)"
    ></quill-editor>
  </div>
</template>
<script>
// 工具栏配置
const toolbarOptions = [
  ["bold", "italic", "underline", "strike"], // 加粗 斜体 下划线 删除线
  ["blockquote", "code-block"], // 引用  代码
  [{ header: 1 }, { header: 2 }], // 1级标题
  [{ list: "ordered" }, { list: "bullet" }], // 有序、无序列
  [{ script: "sub" }, { script: "super" }], // 上标/下标
  [{ indent: "-1" }, { indent: "+1" }], // 缩进
  // [{'direction': 'rtl'}],                         // 文本方向
  [{ size: ["small", false, "large", "huge"] }], // 字体大小
  [{ header: [1, 2, 3, 4, 5, 6, false] }], // 标题
  [{ color: [] }, { background: [] }], // 字体颜色、字体背景颜色
  [{ font: [] }], // 字体种类
  [{ align: [] }], // 对齐方式
  ["clean"], // 清除文本格式
  ["link", "image", "video"] // 链接、图片、视频
];

import { quillEditor } from "vue-quill-editor";
import "quill/dist/quill.core.css";
import "quill/dist/quill.snow.css";
import "quill/dist/quill.bubble.css";

export default {
  props: {
    /*编辑器的内容*/
    value: {
      type: String
    },
    action: {
      type: String
    },
    /*图片大小*/
    maxSize: {
      type: Number,
      default: 4000 //kb
    }
  },

  components: {
    quillEditor
  },
  
  created() {
    console.log('Editor组件已创建', this.action, this.value ? this.value.substring(0, 20) + '...' : '无内容');
  },

  data() {
    return {
      content: this.value,
      quillUpdateImg: false, // 根据图片上传状态来确定是否显示loading动画，刚开始是false,不显示
      editorOption: {
        placeholder: "",
        theme: "snow", // or 'bubble'
        modules: {
          toolbar: {
            container: toolbarOptions,
            // container: "#toolbar",
            handlers: {
              image: function(value) {
                if (value) {
                  // 触发input框选择图片文件
                  document.querySelector(".avatar-uploader input").click();
                } else {
                  this.quill.format("image", false);
                }
              }
              // link: function(value) {
              //   if (value) {
              //     var href = prompt('请输入url');
              //     this.quill.format("link", href);
              //   } else {
              //     this.quill.format("link", false);
              //   }
              // },
            }
          }
        }
      },
      header: {
        'Token': ''
      }, // 有的图片服务器要求请求头需要有token
    };
  },
  
  mounted() {
    console.log('Editor组件已挂载', this.action);
    // 确保在挂载时获取最新的Token
    this.updateToken();
    
    // 添加错误处理，防止编辑器初始化失败导致整个页面崩溃
    try {
      if (this.$refs.myQuillEditor) {
        console.log('Editor组件引用:', this.$refs.myQuillEditor);
      } else {
        console.warn('Editor组件引用不存在，可能未正确初始化');
        // 尝试延迟初始化
        setTimeout(() => {
          if (this.$refs.myQuillEditor) {
            console.log('Editor组件延迟初始化成功');
          } else {
            console.error('Editor组件延迟初始化失败');
          }
        }, 500);
      }
    } catch (err) {
      console.error('Editor组件初始化错误:', err);
    }
  },
  
  computed: {
    // 计算属性的 getter
    getActionUrl: function() {
      const url = `/${this.$base.name}/` + this.action;
      console.log('Editor上传URL:', url);
      return url;
    }
  },
  methods: {
    // 更新Token方法
    updateToken() {
      const token = this.$storage.get("Token");
      if (token) {
        this.header.Token = token;
        console.log('Editor Token已更新:', token.substring(0, 10) + '...');
      } else {
        console.warn('Editor Token不存在，上传功能可能无法正常工作');
      }
    },
    
    onEditorBlur() {
      //失去焦点事件
      console.log('Editor失去焦点');
    },
    onEditorFocus() {
      //获得焦点事件
      console.log('Editor获得焦点');
    },
    onEditorChange() {
      console.log('Editor内容变化:', this.value ? this.value.substring(0, 20) + '...' : '无内容');
      //内容改变事件
      this.$emit("input", this.value);
    },
    // 富文本图片上传前
    beforeUpload() {
      // 显示loading动画
      console.log('Editor准备上传图片');
      // 上传前检查并更新Token
      this.updateToken();
      this.quillUpdateImg = true;
    },

    uploadSuccess(res, file) {
      console.log('Editor图片上传成功:', res);
      // res为图片服务器返回的数组
      // 获取富文本组件实例
      let quill = this.$refs.myQuillEditor.quill;
      // 如果上传成功
      if (res.code === 0) {
        try {
          // 获取光标所在位置
          let length = quill.getSelection() ? quill.getSelection().index : 0;
          // 插入图片  res.url为服务器返回的图片地址
          quill.insertEmbed(length, "image", this.$base.url+ "upload/" +res.file);
          // 调整光标到最后
          quill.setSelection(length + 1);
        } catch (err) {
          console.error('Editor插入图片错误:', err);
          this.$message.error("图片插入失败: " + err.message);
        }
      } else {
        this.$message.error("图片插入失败");
      }
      // loading动画消失
      this.quillUpdateImg = false;
    },
    // 富文本图片上传失败
    uploadError(err) {
      // loading动画消失
      console.error('Editor图片上传失败:', err);
      this.quillUpdateImg = false;
      this.$message.error("图片插入失败");
    }
  }
};
</script> 

<style>
.editor {
  line-height: normal !important;
}
.ql-snow .ql-tooltip[data-mode="link"]::before {
  content: "请输入链接地址:";
}
.ql-snow .ql-tooltip.ql-editing a.ql-action::after {
  border-right: 0px;
  content: "保存";
  padding-right: 0px;
}

.ql-snow .ql-tooltip[data-mode="video"]::before {
  content: "请输入视频地址:";
}
.ql-container {
	height: 400px;
}

.ql-snow .ql-picker.ql-size .ql-picker-label::before,
.ql-snow .ql-picker.ql-size .ql-picker-item::before {
  content: "14px";
}
.ql-snow .ql-picker.ql-size .ql-picker-label[data-value="small"]::before,
.ql-snow .ql-picker.ql-size .ql-picker-item[data-value="small"]::before {
  content: "10px";
}
.ql-snow .ql-picker.ql-size .ql-picker-label[data-value="large"]::before,
.ql-snow .ql-picker.ql-size .ql-picker-item[data-value="large"]::before {
  content: "18px";
}
.ql-snow .ql-picker.ql-size .ql-picker-label[data-value="huge"]::before,
.ql-snow .ql-picker.ql-size .ql-picker-item[data-value="huge"]::before {
  content: "32px";
}

.ql-snow .ql-picker.ql-header .ql-picker-label::before,
.ql-snow .ql-picker.ql-header .ql-picker-item::before {
  content: "文本";
}
.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="1"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="1"]::before {
  content: "标题1";
}
.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="2"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="2"]::before {
  content: "标题2";
}
.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="3"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="3"]::before {
  content: "标题3";
}
.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="4"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="4"]::before {
  content: "标题4";
}
.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="5"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="5"]::before {
  content: "标题5";
}
.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="6"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="6"]::before {
  content: "标题6";
}

.ql-snow .ql-picker.ql-font .ql-picker-label::before,
.ql-snow .ql-picker.ql-font .ql-picker-item::before {
  content: "标准字体";
}
.ql-snow .ql-picker.ql-font .ql-picker-label[data-value="serif"]::before,
.ql-snow .ql-picker.ql-font .ql-picker-item[data-value="serif"]::before {
  content: "衬线字体";
}
.ql-snow .ql-picker.ql-font .ql-picker-label[data-value="monospace"]::before,
.ql-snow .ql-picker.ql-font .ql-picker-item[data-value="monospace"]::before {
  content: "等宽字体";
}
</style>
