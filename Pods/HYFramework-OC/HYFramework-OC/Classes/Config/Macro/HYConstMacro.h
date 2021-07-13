//
//  HYConstMacro.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/1/16.
//

#ifndef HYConstMacro_h
#define HYConstMacro_h

#pragma mark - 屏幕相关
#define HYSCREEN_Bounds [UIScreen mainScreen].bounds
#define HYSCREEN_Size   HYSCREEN_Bounds.size
#define HYSCREEN_Width  HYSCREEN_Bounds.size.width
#define HYSCREEN_Height HYSCREEN_Bounds.size.height

// 屏幕适配
// iPhone 4/iPhone 4s：                  3.5英寸 320x480pt @2x 640x960px
// iPhone 5/5s/5c：                      4.0英寸 320x568pt @2x 640x1136px
// iPhone 6/6s/7/8：                     4.7英寸 375x667pt @2x 750x1334px
// iPhone 6 Plus/6s Plus/7 Plus/8 Plus： 5.5英寸 414x736pt @3x 1242x2208px
// iPhone SE：                           4.0英寸 320x568pt @2x 640x1136px
// iPhone X：                            5.8英寸 375x812pt @3x 1125x2436px
// iPhone Xs：                           5.8英寸 375x812pt @3x 1125x2436px
// iPhone XR：                           6.1英寸 414x896pt @2x 828x1792px
// iPhone Xs Max：                       6.5英寸 414x896pt @3x 1242x2688px
// iPhone 11：                           6.1英寸 414x896pt @2x 828x1792px
// iPhone 11 Pro：                       5.8英寸 375x812pt @3x 1125x2436px
// iPhone 11 Pro Max：                   6.5英寸 414x896pt @3x 1242x2688px
// iPhone 12：                           6.1英寸 390x844pt @3x 1170x2532px
// iPhone 12 mini：                      5.4英寸 360x780pt @3x 1080x2340px
// iPhone 12 Pro：                       6.1英寸 390x844pt @3x 1170x2532px
// iPhone 12 Pro Max：                   6.7英寸 428x926pt @3x 1284x2778px
#define HYDEVICE_Type(deviceSize) ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(deviceSize, [[UIScreen mainScreen] currentMode].size) : NO)
#define HYDEVICE_IS_IPHONE_X        HYDEVICE_Type(CGSizeMake(1125, 2436))
#define HYDEVICE_IS_IPHONE_Xr       HYDEVICE_Type(CGSizeMake(828, 1792))
#define HYDEVICE_IS_IPHONE_Xs_Max   HYDEVICE_Type(CGSizeMake(1242, 2688))
#define HYDEVICE_IS_iPhone12_mini   HYDEVICE_Type(CGSizeMake(1080, 2340))
#define HYDEVICE_IS_iPhone12        HYDEVICE_Type(CGSizeMake(1170, 2532))
#define HYDEVICE_IS_iPhone12_Max    HYDEVICE_Type(CGSizeMake(1284, 2778))

// 是否有刘海
#define HYDEVICE_Has_Bang (HYDEVICE_IS_IPHONE_X == YES || HYDEVICE_IS_IPHONE_Xr == YES || HYDEVICE_IS_IPHONE_Xs_Max == YES || HYDEVICE_IS_iPhone12_mini == YES || HYDEVICE_IS_iPhone12 == YES || HYDEVICE_IS_iPhone12_Max == YES)

// 状态栏高度
#define HYSCREEN_Statusbar_Height [[UIApplication sharedApplication] statusBarFrame].size.height
// 导航栏高度
#define HYSCREEN_Navbar_Height 44.f
// 导航栏+状态栏高度
#define HYSCREEN_Statusbar_Nav_Height (HYSCREEN_Navbar_Height + HYSCREEN_Statusbar_Height)
// 屏幕底部安全区域高度
#define HYSCREEN_Bottom_Safe_Height (HYDEVICE_Has_Bang ? 34.f : 0.f)
// tabbar高度
#define HYSCREEN_Tabbar_Height (HYDEVICE_Has_Bang ? (49.f + 34.f) : (49.f))

#pragma mark - 系统相关
// 系统版本


#pragma mark - 颜色相关
// RGB表示颜色
#define HYColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HYColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 16进制表示颜色
#define HYColorHex(string) [UIColor colorWithHexString:string]

// 常用颜色
// 主题色，多种可选
#define HYColorTheme1 HYColorRGB(42, 81, 243)
#define HYColorTheme2 HYColorRGB(1, 137, 255)
#define HYColorTheme3 HYColorRGB(42,101,212)

// 白色
#define HYColorWhite [UIColor whiteColor]
// 黑色
#define HYColorBlack [UIColor blackColor]
// 红色
#define HYColorRed [UIColor redColor]
// 浅灰色
#define HYColorLightGray [UIColor lightGrayColor]
// 深灰色
#define HYColorDarkGray [UIColor darkGrayColor]
// clear色
#define HYColorClear [UIColor clearColor]
// 蓝色
#define HYColorBlue [UIColor blueColor]
// 绿色
#define HYColorGreen [UIColor greenColor]

// 字体颜色
#define HYColorTextNormal HYColorRGB(51,51,51)

// 背景色(浅灰色,由浅入深)
#define HYColorBgLight1 HYColorRGB(245,245,250)
#define HYColorBgLight2 HYColorRGB(231,231,231)
#define HYColorBgLight3 HYColorRGB(204,204,204)


#pragma mark - 字体相关
#define HYFontSystem(size) [UIFont systemFontOfSize:size]
#define HYFontBold(size) [UIFont boldSystemFontOfSize:size]


#pragma mark - 字符串相关方法
// 比较字符串是否相等
#define HYStringEqual(str1,str2) [str1 isEqualToString:str2]
// 字符串是否是空
#define HYStringEmpty(str) (str == nil || [str isEmpty])
// 字符串转float
#define HYStringToFloat(str) [str floatValue]
// 字符串转double
#define HYStringToDouble(str) [str doubleValue]
// 后台返回特殊字符串处理,null、<null>、(null)等转换成@""
#define HYStringHandle(str) (HYStringEmpty(str) ? @"" : str)
// 对象转string
#define HYStringWithObject(obj) [NSString stringWithFormat:@"%@",obj]


#pragma mark - url
// 字符串转url
#define HYUrlWithString(str) [NSURL URLWithString:str]
// 路径转url
#define HYUrlForFileWithPath(path) [NSURL fileURLWithPath:path]


#pragma mark - 图片
// 设置图片
#define HYImageNamed(name) [UIImage imageNamed:name]

// 判断对象是不是指定的类类型
#define HYObjIsKindOfClass(obj,clas) [obj isKindOfClass:[clas class]]

#pragma mark - toast
// toast
#define HYShowToast(msg) [JRToast showWithText:msg]

#pragma mark - 强、弱引用宏
/*! 弱引用宏 */
#define WeakObj(o)       try{}@finally{} __weak typeof(o) Weak##o = o;
#define WeakSelf         @WeakObj(self)

#pragma mark - MBProgressHUD
#define WAITING         [MBProgressHUD showMessage:@"加载中"];
#define DISMISS         [MBProgressHUD hideHUD];
#define ERRORWith(a)    [MBProgressHUD showError:a];
#define INFOWith(a)     [MBProgressHUD showInfo:a];
#define SUCCESS(a)      [MBProgressHUD showSuccess:a];

#pragma mark - 常用block定义
// 没有参数的block
typedef void (^HYBlockNoneArgument) (void);
// 有参数的block
typedef void (^HYBlockWithArgument) (id value);

// 网络请求block
typedef void (^HYHttpSuccessBlock)        (id responseObject);
typedef void (^HYHttpFailureBlock)        (NSError *error);
typedef void (^HYHttpFaultBlock)          (id error);
typedef void (^HYHttpProgressBlock)       (NSProgress *progress);
typedef void (^HYTheNetworkStatusBlock)   (NSUInteger status);

#pragma mark - 杂项
// 获取用户单利实例
#define HYUserSingletonInstance [HYUserSingleton share]
// 获取appdelegate实例
#define HYAppDelegateSingleton (AppDelegate *)[UIApplication sharedApplication].delegate
// 判断对象是不是空
#define HYObjectEmpty(obj) (obj == nil || [obj isNULL])

#pragma mark - 用户信息
// 账号
#define HYUserAccountKey @"HYUserAccount"
// 用户名
#define HYUserNameKey @"HYUserName"
// token
#define HYUserTokenKey @"HYUserToken"
// 是否已经认证
#define HYUserApprovKey @"HYUserApprov"
// 是否登录
#define HYUserLoginStateKey @"HYUserLoginState"

#endif /* HYConstMacro_h */
