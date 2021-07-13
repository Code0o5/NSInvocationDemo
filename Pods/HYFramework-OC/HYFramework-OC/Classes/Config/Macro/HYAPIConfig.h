//
//  HYAPIConfig.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/1/16.
//

#ifndef HYAPIConfig_h
#define HYAPIConfig_h

#pragma mark - Base
// 服务器地址
#define HYAPI_BASE_URL @""

// 完整url,前面拼接baseUrl
#define HYAPI_FULL_URL(suffix) [NSString stringWithFormat:@"%@/%@",HYAPI_BASE_URL,suffix]

#pragma mark - 上传图片/文件
// 上传文件
//#define HYAPI_UploadFile @"Api/UploadFile"

// 上传图片
//#define HYAPI_UploadImage @""

/**
 * 登录
 */
//#define HYAPI_loginUrl [NSString stringWithFormat:@"%@/login/loginByPhone",HYAPI_BaseUrl]


#pragma mark - 周记
// 获取我的周记
//#define HYAPI_Weekly_GetList @"ApiActivityWeekly/GetMyWeeklyList"
// 获取周记配置字段
//#define HYAPI_Weekly_GetConfList @"ApiActivityWeekly/GetWeeklyConfig"
// 新增周记
//#define HYAPI_Weekly_Add @"ApiActivityWeekly/Submit"
// 修改周记
//#define HYAPI_Weekly_Modify @"ApiActivityWeekly/Modify"
// 获取周记详情
//#define HYAPI_Weekly_Detail @"ApiActivityWeekly/GetByID"
// 删除周记
//#define HYAPI_Weekly_Delete @"ApiActivityWeekly/Delete"
// 批阅周记
//#define HYAPI_Weekly_Check @"ApiActivityWeekly/Check"
// 驳回周记
//#define HYAPI_Weekly_TeaSubmit @"ActivityWeekly/TeaSubmit"
// 撤销审核
//#define HYAPI_Weekly_UnCheck @"ActivityWeekly/UnCheck"
// 获取未审核/已审核周记列表
//#define HYAPI_Weekly_GetWeeklyList @"ApiActivityWeekly/GetWeeklyList"
// 获取未提交周记列表
//#define HYAPI_Weekly_GetNoSubmitList @"ApiActivityWeekly/MyStudentWeeklyNoSubmitList"
// 获取周记审批常用语
//#define HYAPI_Weekly_GetSysDictionesChild @"ApiSystem/GetSysDictionesChild"


#endif /* HYAPIConfig_h */
