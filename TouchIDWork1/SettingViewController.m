//
//  SettingViewController.m
//  TouchIDWork1
//
//  Created by Des on 16/5/13.
//  Copyright © 2016年 WJC. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_isOpen)
    {
       _switc.on=YES;
    }
    else
    {
       _switc.on=NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isOpen"];

    }
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)switchClick:(UISwitch *)sender {
    
    if(_switc.on)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isOpen"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isOpen"];
    }
    
    
}
@end
