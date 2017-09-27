//
//  ViewController.m
//  JLWaterfallFlow
//
//  Created by gaojianlong on 2017/9/18.
//  Copyright © 2017年 JLB. All rights reserved.
//

#import "ViewController.h"
#import "JLWaterfallController.h"

@interface ViewController ()

@property (nonatomic, strong) UIBarButtonItem *rightBarButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
    
    [self sendLocalNotification];
}

- (void)sendLocalNotification
{
    if ([UIApplication instanceMethodForSelector:@selector(registerUserNotificationSettings:)] != nil) {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    }
    
    // 1.创建一个本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    
    // 1.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
    // 1.2.设置通知内容
    localNote.alertBody = @"这是一个推送这是一个推送";
    
    // 1.3.设置锁屏时,字体下方显示的一个文字
    localNote.alertAction = @"赶紧!!!!!";
    localNote.hasAction = YES;
    
    // 1.4.设置启动图片(通过通知打开的)
    //localNote.alertLaunchImage = @"../Documents/IMG_0024.jpg";
    
    // 1.5.设置通知到来的声音
    localNote.soundName = UILocalNotificationDefaultSoundName;
    
    // 1.6.设置应用图标左上角显示的数字
    localNote.applicationIconBadgeNumber = 999;
    
    // 1.7.设置一些额外的信息
    localNote.userInfo = @{@"qq" : @"704711253", @"msg" : @"success"};
    
    // 2.执行通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}


- (void)popWaterfallView
{
    [self.navigationController pushViewController:[[JLWaterfallController alloc] init] animated:YES];
}

- (UIBarButtonItem *)rightBarButton
{
    if (!_rightBarButton) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"瀑布流" style:UIBarButtonItemStylePlain target:self action:@selector(popWaterfallView)];
    }
    return _rightBarButton;
}

@end
