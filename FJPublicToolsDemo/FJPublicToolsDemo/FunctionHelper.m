//
//  FunctionHelper.m
//  FJPublicToolsDemo
//
//  Created by XY on 2017/3/17.
//  Copyright © 2017年 KFJ. All rights reserved.
//

#import "FunctionHelper.h"
#import <FJPublicTools/FJPublicTools.h>
#import "AppID.h"

#define FJInstance   [FJPublicHelper shareInstance]

@implementation FunctionHelper
+(void)didselectWithFuncId:(funcID)funcId andVC:(UIViewController *)vc{
    
    switch (funcId) {
        case SENDEMAIL:
            [self sendEmail:vc];
            break;
            
        case OPENAPP:
            [FJInstance openAppWithIdentifier:@"1189702803" andVC:vc];
            break;
            
        case OPENAPPLIST:
            [FJInstance openAppWithArtistId:[MYARTISTID integerValue] andNavigationCotroller:vc.navigationController completionBlock:^(BOOL result, NSError *error) {
            }];
            break;
            
        case SHARE:
            [self share:vc];
            break;
            
        case EXPORT:
            [self export:vc];
            
            break;
        case CLEARCHACHE:
            [FJFileCleanCache cleanCaches:^(BOOL isSuccess) {
                NSLog(isSuccess?@"成功":@"失败");
            }];
            break;
            
        case ROUTER:
            
            [[FJRouter shareInstance] FJRouterFromVC:vc toVC:@"TestViewController" SBName:@"Main" withParameter:@{@"key1":@"测试咯",@"key2":@"value"} way:PUSH isHideBottom:YES animated:YES];
            
            //            [[FJRouter shareInstance] FJRouterFromVC:vc toVC:@"TestViewController" SBName:nil withParameter:@{@"key1":@"测试咯",@"key2":@"value"} way:PUSH isHideBottom:YES animated:YES];
            
            
            break;
        case COMMENT:
        {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&action=write-review",KAppStoreUrl]];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
            break;
        default:
            break;
    }
    
}
+ (void)sendEmail:(UIViewController *)vc{
    
    FJInstance.toRecipients = @[@"392843367@qq.com"];
    
    FJInstance.isShowAppInfo = NO;
    
    [FJInstance sendEmailWithViewCotroller:vc result:^(MFMailComposeResult result, NSError *error) {
        switch (result)
        {
                
            case MFMailComposeResultCancelled:
                
                NSLog(@"取消发送mail");
                
                break;
                
            case MFMailComposeResultSaved:
                
                NSLog(@"保存邮件");
                
                break;
                
            case MFMailComposeResultSent:
                
                NSLog(@"发送邮件");
                
                break;
                
            case MFMailComposeResultFailed:
                
                NSLog(@"邮件发送失败: %@...", [error localizedDescription]);
                break;
                
            default:
                
                break;
                
        }
        
    }];
    
}

+ (void)share:(UIViewController *)vc{
    NSString *textToShare = @"SkimTumblog—最好用的tumblr中文客户端，支持手势密码";
    UIImage *imageToShare = [UIImage imageNamed:@"1024*1024"];
    NSURL *urlToShare = [NSURL URLWithString:KAppStoreUrl];
    NSArray *activityItems = @[urlToShare,textToShare,imageToShare];
    [FJInstance createActivityViewController:activityItems andExcludedActivityTypes:nil withVC:vc];
    
}

+ (void)export:(UIViewController *)vc{
    
    NSURL *url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"TableViewList" ofType:@"plist"]];
    
    [FJInstance exportFileWithUrl:url andView:vc.view];
    
}
@end
