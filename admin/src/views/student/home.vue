<template>
  <div class="student-home">
    <el-row :gutter="20">
      <el-col :span="24">
        <div class="welcome-card">
          <h2>欢迎使用在线课程管理系统</h2>
          <p>学生用户：{{ username }}</p>
        </div>
      </el-col>
    </el-row>
    
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :span="8">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>我的课程</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="goToPage('/wodekecheng')">查看全部</el-button>
          </div>
          <div class="course-list">
            <div v-if="courses.length === 0" class="empty-tip">暂无课程</div>
            <div v-for="(course, index) in courses" :key="index" class="course-item">
              <div class="course-title">{{ course.name }}</div>
              <div class="course-info">{{ course.teacher }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :span="8">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>通知公告</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="goToPage('/tongzhigonggao')">查看全部</el-button>
          </div>
          <div class="notice-list">
            <div v-if="notices.length === 0" class="empty-tip">暂无通知</div>
            <div v-for="(notice, index) in notices" :key="index" class="notice-item">
              <div class="notice-title">{{ notice.title }}</div>
              <div class="notice-date">{{ notice.date }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :span="8">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>在线交流</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="goToPage('/forum')">进入交流</el-button>
          </div>
          <div class="forum-list">
            <div v-if="forums.length === 0" class="empty-tip">暂无交流</div>
            <div v-for="(forum, index) in forums" :key="index" class="forum-item">
              <div class="forum-title">{{ forum.title }}</div>
              <div class="forum-info">{{ forum.author }} - {{ forum.date }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :span="24">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>快速访问</span>
          </div>
          <div class="quick-access">
            <el-button type="primary" @click="goToPage('/wodekecheng')">我的课程</el-button>
            <el-button type="success" @click="goToPage('/kejianxinxi')">课件信息</el-button>
            <el-button type="info" @click="goToPage('/zhishiyaodian')">知识要点</el-button>
            <el-button type="warning" @click="goToPage('/xueshengtiwen')">学生提问</el-button>
            <el-button type="danger" @click="goToPage('/forum')">在线交流</el-button>
            <el-button @click="goToPage('/center')">个人中心</el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: 'StudentHome',
  data() {
    return {
      username: this.$storage.get('adminName') || '同学',
      courses: [],
      notices: [],
      forums: []
    }
  },
  created() {
    console.log('学生首页已创建');
    this.loadData();
  },
  mounted() {
    console.log('学生首页已挂载');
  },
  methods: {
    loadData() {
      // 加载我的课程数据
      this.$http({
        url: 'wodekecheng/list',
        method: 'get',
        params: {
          page: 1,
          limit: 3
        }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.courses = data.data.list.map(item => ({
            name: item.kechengmingcheng || '未命名课程',
            teacher: item.jiaoshixingming || '未知教师'
          }));
        } else {
          console.error('获取课程数据失败:', data.msg);
        }
      }).catch(err => {
        console.error('获取课程数据异常:', err);
      });

      // 加载通知公告数据
      this.$http({
        url: 'tongzhigonggao/list',
        method: 'get',
        params: {
          page: 1,
          limit: 3
        }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.notices = data.data.list.map(item => ({
            title: item.biaoti || '未命名通知',
            date: item.faburiqi || '未知日期'
          }));
        } else {
          console.error('获取通知数据失败:', data.msg);
        }
      }).catch(err => {
        console.error('获取通知数据异常:', err);
      });

      // 加载在线交流数据
      this.$http({
        url: 'forum/list',
        method: 'get',
        params: {
          page: 1,
          limit: 3
        }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.forums = data.data.list.map(item => ({
            title: item.title || '未命名主题',
            author: item.username || '匿名用户',
            date: item.addtime || '未知时间'
          }));
        } else {
          console.error('获取交流数据失败:', data.msg);
        }
      }).catch(err => {
        console.error('获取交流数据异常:', err);
      });
    },
    goToPage(path) {
      console.log('导航到页面:', path);
      this.$router.push(path);
    }
  }
}
</script>

<style scoped>
.student-home {
  padding: 20px;
}

.welcome-card {
  background-color: #ecf5ff;
  padding: 20px;
  border-radius: 4px;
  margin-bottom: 20px;
}

.welcome-card h2 {
  margin-top: 0;
  color: #409EFF;
}

.box-card {
  margin-bottom: 20px;
  height: 300px;
}

.course-list, .notice-list, .forum-list {
  height: 220px;
  overflow-y: auto;
}

.course-item, .notice-item, .forum-item {
  padding: 10px 0;
  border-bottom: 1px solid #EBEEF5;
}

.course-item:last-child, .notice-item:last-child, .forum-item:last-child {
  border-bottom: none;
}

.course-title, .notice-title, .forum-title {
  font-weight: bold;
  margin-bottom: 5px;
}

.course-info, .notice-date, .forum-info {
  font-size: 12px;
  color: #909399;
}

.quick-access {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.empty-tip {
  color: #909399;
  text-align: center;
  padding: 20px 0;
}
</style> 