//
//  ViewController.m
//  NSInvocationDemo
//
//  Created by MrChen on 2021/7/13.
//

#import "ViewController.h"
#import "NSObject+performSelector.h"

@interface ViewController ()

// 列表显示数据
@property (nonatomic, copy) NSArray *listData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 设置子视图
- (void)setupSubviews
{
    [super setupSubviews];
    
    self.title = @"不直接调用方法Demo";
    
    // 添加tableView
    [self setupTableView];
    
    WeakSelf
    self.textLabelContentBlock = ^NSString * _Nonnull(NSIndexPath * _Nonnull indexPath) {
        return Weakself.listData[indexPath.row];
    };
    self.tableView.hyDataSource.didSelectRowAtIndexPath = ^(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath) {
        HYShowToast(@"代码已经执行,请注意控制台输出");
        
        switch (indexPath.row) {
            case 0:{
                if ([Weakself respondsToSelector:@selector(func1)]) {
                    [Weakself performSelector:@selector(func1)];
                }
            }
                break;
            case 1:{
                if ([Weakself respondsToSelector:@selector(func2:)]) {
                    [Weakself performSelector:@selector(func2:) withObject:@"参数1"];
                }
            }
                break;
            case 2:{
                if ([Weakself respondsToSelector:@selector(func3:par2:)]) {
                    [Weakself performSelector:@selector(func3:par2:) withObject:@"参数1" withObject:@"参数2"];
                }
            }
                break;
            case 3:{
                // 多个参数，把多个参数封装成一个
                if ([Weakself respondsToSelector:@selector(funcTranslator:)]) {
                    [Weakself performSelector:@selector(funcTranslator:) withObject:@[@"参数1",@"参数2",@"参数3"]];
                }
            }
                break;
            case 4:{
                // 多个参数，用NSInvocatio封装perforSelector方法
                if ([Weakself respondsToSelector:@selector(func5:par2:par3:par4:)]) {
                    [Weakself performSelector:@selector(func5:par2:par3:par4:) withObjects:@[@"参数1",@"参数2",@"参数3",@"参数4"]];
                }
            }
                break;
            case 5:{
                if ([Weakself respondsToSelector:@selector(func6:)]) {
                    NSString *res = [Weakself performSelector:@selector(func6:) withObject:@"参数1"];
                    NSLog(@"返回值:%@",res);
                }
            }
                break;
            case 6:{
                // 方法签名(方法的描述)
                NSMethodSignature *signature = [[Weakself class] instanceMethodSignatureForSelector:@selector(test1)];
                if (signature == nil) {
                    // 方法不存在，提示或抛出异常
                    NSLog(@"%@方法不存在",NSStringFromSelector(@selector(test1)));
                    return;
                }
                
                // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                // 设置方法调用者
                invocation.target = Weakself;
                // 方法名，一定要和方法签名类中的一致
                invocation.selector = @selector(test1);
                
                // 调用方法
                [invocation invoke];
            }
                break;
            case 7:{
                // 方法签名(方法的描述)
                NSMethodSignature *signature = [[Weakself class] instanceMethodSignatureForSelector:@selector(test2:par2:par3:)];
                if (signature == nil) {
                    // 方法不存在，提示或抛出异常
                    NSLog(@"%@方法不存在",NSStringFromSelector(@selector(test2:par2:par3:)));
                    return;
                }
                
                // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                // 设置方法调用者
                invocation.target = Weakself;
                // 方法名，一定要和方法签名类中的一致
                invocation.selector = @selector(test2:par2:par3:);
                
                // 设置参数,默认已经有self和_cmd两个参数了
                NSString *par1 = @"参数1";
                NSString *par2 = @"参数2";
                NSString *par3 = @"参数3";
                [invocation setArgument:&par1 atIndex:2];
                [invocation setArgument:&par2 atIndex:3];
                [invocation setArgument:&par3 atIndex:4];
                
                // 调用方法
                [invocation invoke];
            }
                break;
            case 8:{
                // 方法签名(方法的描述)
                NSMethodSignature *signature = [[Weakself class] instanceMethodSignatureForSelector:@selector(test3:par2:par3:)];
                if (signature == nil) {
                    // 方法不存在，提示或抛出异常
                    NSLog(@"%@方法不存在",NSStringFromSelector(@selector(test3:par2:par3:)));
                    return;
                }
                
                // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                // 设置方法调用者
                invocation.target = Weakself;
                // 方法名，一定要和方法签名类中的一致
                invocation.selector = @selector(test3:par2:par3:);
                
                // 设置参数,默认已经有self和_cmd两个参数了
                NSString *par1 = @"参数1";
                NSString *par2 = @"参数2";
                NSString *par3 = @"参数3";
                [invocation setArgument:&par1 atIndex:2];
                [invocation setArgument:&par2 atIndex:3];
                [invocation setArgument:&par3 atIndex:4];
                
                // 调用方法
                [invocation invoke];
                
                // 获取返回值
               id returnValue = nil;
                // 有返回值类型，才去获得返回值
               if (signature.methodReturnLength) {
                   [invocation getReturnValue:&returnValue];
                   NSLog(@"返回值:%@",returnValue);
               }
            }
                break;
            default:
                break;
        }
    };
    [self.tableView.hyDataSource resetDataWithArray:self.listData];
}

#pragma mark - 事件
// performSelector调用无参数无返回值方法
- (void)func1
{
    NSLog(@"调用方法:%s",__FUNCTION__);
}

// performSelector调用有参数无返回值方法（一个参数）
- (void)func2:(NSString *)par1
{
    NSLog(@"调用方法:%s,参数:%@",__FUNCTION__,par1);
}

// performSelector调用有参数无返回值方法（两个参数）
- (void)func3:(NSString *)par1 par2:(NSString *)par2
{
    NSLog(@"调用方法:%s,参数:%@,%@",__FUNCTION__,par1,par2);
}

// performSelector调用有参数无返回值方法（多个参数）过度方法
- (void)funcTranslator:(NSArray *)par
{
    if ([self respondsToSelector:@selector(func4:par2:par3:)]) {
        [self func4:par[0] par2:par[1] par3:par[2]];
    }
}

// performSelector调用有参数无返回值方法（多个参数）
- (void)func4:(NSString *)par1 par2:(NSString *)par2 par3:(NSString *)par3
{
    NSLog(@"调用方法:%s,参数:%@,%@,%@",__FUNCTION__,par1,par2,par3);
}

// performSelector调用有参数无返回值方法（多个参数）
- (void)func5:(NSString *)par1 par2:(NSString *)par2 par3:(NSString *)par3 par4:(NSString *)par4
{
    NSLog(@"调用方法:%s,参数:%@,%@,%@,%@",__FUNCTION__,par1,par2,par3,par4);
}

// performSelector调用有参数有返回值方法
- (NSString *)func6:(NSString *)par1
{
    NSLog(@"调用方法:%s,参数:%@",__FUNCTION__,par1);
    return @"6";
}

// NSInvocation调用无参数无返回值方法
- (void)test1
{
    NSLog(@"调用方法:%s",__FUNCTION__);
}

// NSInvocation调用有参数无返回值方法
- (void)test2:(NSString *)par1 par2:(NSString *)par2 par3:(NSString *)par3
{
    NSLog(@"调用方法:%s,参数:%@,%@,%@",__FUNCTION__,par1,par2,par3);
}

// NSInvocation调用有参数有返回值方法
- (NSString *)test3:(NSString *)par1 par2:(NSString *)par2 par3:(NSString *)par3
{
    NSLog(@"调用方法:%s,参数:%@,%@,%@",__FUNCTION__,par1,par2,par3);
    return @"3";
}

#pragma mark - 懒加载
- (NSArray *)listData
{
    if (_listData == nil) {
        _listData = @[
            @"performSelector调用无参数无返回值方法",
            @"performSelector调用有参数无返回值方法（一个参数）",
            @"performSelector调用有参数无返回值方法（两个参数）",
            @"performSelector调用有参数无返回值方法（多个参数）",
            @"封装performSelector方法（多个参数）",
            @"performSelector调用有参数有返回值方法",
            @"NSInvocation调用无参数无返回值方法",
            @"NSInvocation调用有参数无返回值方法",
            @"NSInvocation调用有参数有返回值方法"
        ];
    }
    return _listData;
}


@end
