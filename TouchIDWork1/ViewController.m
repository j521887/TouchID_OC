//
//  ViewController.m
//  TouchIDWork1
//
//  Created by Des on 16/5/12.
//  Copyright © 2016年 WJC. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"

@import LocalAuthentication;

@interface ViewController ()
{
    BOOL isLock;
}
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    isLock=[[[NSUserDefaults standardUserDefaults] objectForKey:@"isOpen"] boolValue];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor grayColor];
    
    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    [but setTitle:@"设置" forState:UIControlStateNormal];
    but.frame=CGRectMake(0, 0, 50, 40);
    [but addTarget:self action:@selector(settingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbut=[[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.rightBarButtonItem=barbut;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"openLoak" object:nil];
    
}

-(void)notification:(NSNotification *)not
{
    if(isLock==YES && [not.object integerValue]==1)
    {
        [self creatLock];
    }

}

-(void)creatLock
{
    LAContext *context=[[LAContext alloc] init];
    context.localizedFallbackTitle=@"";
    NSError *err;
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&err]){
        
        NSLog(@"该设备支持Touch ID");
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        view.backgroundColor=[UIColor blackColor];
        view.alpha=0.5;
        [self.view addSubview:view];
        
        [context isCredentialSet:LACredentialTypeApplicationPassword];
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"指纹验证" reply:^(BOOL success, NSError * _Nullable error) {
            
            if(success)
            {
                NSLog(@"识别成功");
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [view removeFromSuperview];
                    
                });
                
            
            }
            else
            {
                if(error.code==kLAErrorUserFallback)
                {
                     NSLog(@"Fallback按钮被点击");
                }
                else if (error.code==kLAErrorUserCancel)
                {
                
                    NSLog(@"取消按钮被点击");
                }
                else if (error.code==kLAErrorAppCancel)
                {
                    NSLog(@"按home键推出");
                }
                else
                {
                    NSLog(@"指纹识别失败%ld",error.code);
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [view removeFromSuperview];
                });
                
                
            }
            
        }];
    
    }else{
        
        NSLog(@"设备不支持Touch ID");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备不支持Touch ID" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            isLock=NO;
        }];
        [alert addAction:action];

        
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingBtnClick:(id)sender {
    
    SettingViewController *vc=[[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    vc.title=@"设置";
    vc.isOpen=isLock;
    [self.navigationController pushViewController:vc  animated:YES];
    
}
@end
