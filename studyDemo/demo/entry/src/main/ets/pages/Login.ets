import router from '@ohos.router';
import userService from '../services/UserService';

@Entry
@Component
struct Login {
  @State username: string = '';
  @State password: string = '';
  @State isLoading: boolean = false;
  @State showError: boolean = false;
  @State errorMessage: string = '';

  build() {
    Column() {
      // Logo

      // 标题
      Text('欢迎登录')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 50 })
      
      // 用户名输入框
      TextInput({ placeholder: '请输入用户名' })
        .width('80%')
        .height(50)
        .margin({ bottom: 20 })
        .onChange((value: string) => {
          this.username = value;
          this.showError = false;
        })
      
      // 密码输入框
      TextInput({ placeholder: '请输入密码' })
        .width('80%')
        .height(50)
        .margin({ bottom: 30 })
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value;
          this.showError = false;
        })
      
      // 错误提示
      if (this.showError) {
        Text(this.errorMessage)
          .fontSize(14)
          .margin({ bottom: 10 })
      }
      
      // 登录按钮
      Button('登录')
        .width('80%')
        .height(50)
        .onClick(async () => {
          if (this.username === '' || this.password === '') {
            this.showError = true;
            this.errorMessage = '用户名和密码不能为空';
            return;
          }
          
          this.isLoading = true;
          try {
            // 调用用户服务进行登录
            const isSuccess = await userService.login(this.username, this.password);
            if (isSuccess) {
              // 登录成功，跳转到主页
              router.pushUrl({ url: "pages/hhPages"
              });
            } else {
              // 登录失败
              this.showError = true;
              this.errorMessage = '用户名或密码错误';
            }
          } catch (error) {
            // 处理异常
            this.showError = true;
            this.errorMessage = '登录失败，请稍后重试';
            console.error('登录异常:', error);
          } finally {
            this.isLoading = false;
          }
        })
      
      // 加载指示器
      if (this.isLoading) {
        LoadingProgress()
          .width(30)
          .height(30)
          .margin({ top: 20 })
      }
      
      // 注册链接
      Text('还没有账号？立即注册')
        .fontSize(14)

        .margin({ top: 30 })
        .onClick(() => {
          // 跳转到注册页面的逻辑
          // router.pushUrl({ url: Constants.ROUTES.REGISTER });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
} 