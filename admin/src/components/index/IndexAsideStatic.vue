<template>
  <el-aside class="index-aside" height="100vh" width="280px">
    <div class="index-aside-inner menulist" style="height:100%">
      <div v-for="item in filteredMenuList" :key="item.roleName" class="menulist-item" style="height:100%;broder:0;background-color:#24C2CD">
        <div class="menulistImg" style="backgroundColor:#ff0000;padding:25px 0" v-if="false && menulistStyle == 'vertical'">
          <el-image v-if="'http://codegen.caihongy.cn/20201021/cc7d45d9c8164b58b18351764eba9be1.jpg'" src="http://codegen.caihongy.cn/20201021/cc7d45d9c8164b58b18351764eba9be1.jpg" fit="cover" />
        </div>
        <el-menu mode="vertical" :unique-opened="true" class="el-menu-demo" style="height:100%;" background-color="#24C2CD" text-color="#FFFFFF" active-text-color="#FFFFFF" default-active="0">
          <el-menu-item index="0" :style="menulistBorderBottom" @click="menuHandler('')"><i v-if="false" class="el-icon-s-home" />首页</el-menu-item>
          <el-submenu index="1" :style="menulistBorderBottom">
            <template slot="title">
              <i v-if="false" class="el-icon-user-solid" />
              <span>个人中心</span>
            </template>
            <el-menu-item index="1-1" @click="menuHandler('updatePassword')">修改密码</el-menu-item>
            <el-menu-item index="1-2" @click="menuHandler('center')">个人信息</el-menu-item>
          </el-submenu>
          <el-submenu :style="menulistBorderBottom" v-for=" (menu,index) in item.backMenu" :key="menu.menu" :index="(index+2).toString()">
            <template slot="title">
              <i v-if="false" :class="icons[index]" />
              <span>{{ menu.menu }}</span>
            </template>
            <el-menu-item v-for=" (child,sort) in menu.child" :key="sort" :index="(index+2)+'-'+sort.toString()" @click="menuHandler(child.tableName)">{{ child.menu }}</el-menu-item>
          </el-submenu>
        </el-menu>

      </div>
    </div>
  </el-aside>
</template>
<script>
import menu from '@/utils/menu'
export default {
  data() {
    return {
      menuList: [],
      dynamicMenuRoutes: [],
      role: '',
      icons: [
        'el-icon-s-cooperation',
        'el-icon-s-order',
        'el-icon-s-platform',
        'el-icon-s-fold',
        'el-icon-s-unfold',
        'el-icon-s-operation',
        'el-icon-s-promotion',
        'el-icon-s-release',
        'el-icon-s-ticket',
        'el-icon-s-management',
        'el-icon-s-open',
        'el-icon-s-shop',
        'el-icon-s-marketing',
        'el-icon-s-flag',
        'el-icon-s-comment',
        'el-icon-s-finance',
        'el-icon-s-claim',
        'el-icon-s-custom',
        'el-icon-s-opportunity',
        'el-icon-s-data',
        'el-icon-s-check',
        'el-icon-s-grid',
        'el-icon-menu',
        'el-icon-chat-dot-square',
        'el-icon-message',
        'el-icon-postcard',
        'el-icon-position',
        'el-icon-microphone',
        'el-icon-close-notification',
        'el-icon-bangzhu',
        'el-icon-time',
        'el-icon-odometer',
        'el-icon-crop',
        'el-icon-aim',
        'el-icon-switch-button',
        'el-icon-full-screen',
        'el-icon-copy-document',
        'el-icon-mic',
        'el-icon-stopwatch',
      ],
      menulistStyle: 'vertical',
	  menulistBorderBottom: {},
    }
  },
  computed: {
    filteredMenuList() {
      return this.menuList.filter(item => item.roleName === this.role);
    }
  },
  mounted() {
    const menus = menu.list()
    this.menuList = menus
    this.role = this.$storage.get('role')
  },
  created(){
    setTimeout(()=>{
      this.menulistStyleChange()
    },10)
    this.icons.sort(()=>{
      return (0.5-Math.random())
    })
	this.lineBorder()
  },
  methods: {
	lineBorder() {
		let style = 'vertical'
		let w = '0px'
		let s = 'solid'
		let c = '#ccc'
		if(style == 'vertical') {
			this.menulistBorderBottom = {
				borderBottomWidth: w,
				borderBottomStyle: s,
				borderBottomColor: c
			}
		} else {
			this.menulistBorderBottom = {
				borderRightWidth: w,
				borderRightStyle: s,
				borderRightColor: c
			}
		}
	},
    menuHandler(name) {
      console.log('===== 菜单点击 =====');
      console.log('跳转路径:', name);
      
      let router = this.$router;
      let path = '/' + name;
      
      console.log('目标路径:', path);
      console.log('当前路径:', router.currentRoute.path);
      
      // 如果是点击当前路径，不进行强制刷新，避免组件加载异常
      if(router.currentRoute.path === path && name) {
        console.log('检测到相同路径，不进行强制刷新');
        return; // 直接返回，不执行任何跳转
      } else {
        // 添加路由跳转前的准备工作
        try {
          // 检查Token是否存在
          const token = this.$storage.get('Token');
          if (!token && !['login', 'register', ''].includes(name)) {
            console.warn('Token不存在，重定向到登录页');
            router.push('/login');
            return;
          }
          
          // 正常路由跳转
          router.push(path).catch(err => {
            console.log('路由错误:', err);
            if (err.name !== 'NavigationDuplicated') {
              console.error('路由跳转失败:', err);
              // 尝试使用replace方法
              router.replace(path).catch(replaceErr => {
                console.error('路由replace也失败:', replaceErr);
              });
            }
          }).then(() => {
            console.log('路由跳转成功到:', path);
            
            // 添加跳转后的检查，确保组件正确加载
            setTimeout(() => {
              // 检查页面是否正确渲染
              if (document.querySelector('.el-main').children.length === 0) {
                console.warn('页面可能未正确渲染，尝试重新加载');
                router.go(0); // 刷新页面
              }
            }, 500);
          });
        } catch (err) {
          console.error('菜单处理错误:', err);
        }
      }
    },
    // 菜单
    setMenulistHoverColor(){
      let that = this
      this.$nextTick(()=>{
        document.querySelectorAll('.menulist .el-menu-item').forEach(el=>{
          el.addEventListener("mouseenter", e => {
            e.stopPropagation()
            el.style.backgroundColor = "rgba(24, 160, 169, 1)"
          })
          el.addEventListener("mouseleave", e => {
            e.stopPropagation()
            el.style.backgroundColor = "#24C2CD"
          })
          el.addEventListener("focus", e => {
            e.stopPropagation()
            el.style.backgroundColor = "rgba(24, 160, 169, 1)"
          })
        })
        document.querySelectorAll('.menulist .el-submenu__title').forEach(el=>{
          el.addEventListener("mouseenter", e => {
            e.stopPropagation()
            el.style.backgroundColor = "rgba(24, 160, 169, 1)"
          })
          el.addEventListener("mouseleave", e => {
            e.stopPropagation()
            el.style.backgroundColor = "#24C2CD"
          })
        })
      })
    },
    setMenulistIconColor() {
      this.$nextTick(()=>{
        document.querySelectorAll('.menulist .el-submenu__title .el-submenu__icon-arrow').forEach(el=>{
          el.style.color = "rgba(255, 255, 255, 1)"
        })
      })
    },
    menulistStyleChange() {
      this.setMenulistIconColor()
      this.setMenulistHoverColor()
      this.setMenulistStyleHeightChange()
      let str = "vertical"
      if("horizontal" === str) {
        this.$nextTick(()=>{
          document.querySelectorAll('.el-container .el-container').forEach(el=>{
            el.style.display = "block"
            el.style.paddingTop = "70px" // header 高度
          })
          document.querySelectorAll('.el-aside').forEach(el=>{
            el.style.width = "100%"
            el.style.height = "60px"
            el.style.paddingTop = '0'
          })
          document.querySelectorAll('.index-aside .index-aside-inner').forEach(el=>{
            el.style.paddingTop = '0'
          })
        })
      }
      if("vertical" === str) {
        this.$nextTick(()=>{
          document.querySelectorAll('.index-aside .index-aside-inner').forEach(el=>{
            el.style.paddingTop = "70px"
          })
        })
      }
    },
    setMenulistStyleHeightChange() {
      this.$nextTick(()=>{
        document.querySelectorAll('.menulist-item>.el-menu--horizontal>.el-menu-item').forEach(el=>{
          el.style.height = "60px"
          el.style.lineHeight = "60px"
        })
        document.querySelectorAll('.menulist-item>.el-menu--horizontal>.el-submenu>.el-submenu__title').forEach(el=>{
          el.style.height = "60px"
          el.style.lineHeight = "60px"
        })
      })
    },
  }
}
</script>
<style lang="scss" scoped>
  .index-aside {
    position: relative;
    overflow: hidden;

    .menulistImg {
      padding: 24px 0;
      box-sizing: border-box;

      .el-image {
        margin: 0 auto;
        width: 100px;
        height: 100px;
        border-radius: 100%;
        display: block;
      }
    }

    .index-aside-inner {
      height: 100%;
      margin-right: -17px;
      margin-bottom: -17px;
      overflow: scroll;
      overflow-x: hidden !important;
      padding-top: 60px;
      box-sizing: border-box;

      &:focus {
        outline: none;
      }

      .el-menu {
        border: 0;
      }
    }
  }
</style>
