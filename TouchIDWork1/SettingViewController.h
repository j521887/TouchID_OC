//
//  SettingViewController.h
//  TouchIDWork1
//
//  Created by Des on 16/5/13.
//  Copyright © 2016年 WJC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@property (assign,nonatomic) BOOL isOpen;
@property (weak, nonatomic) IBOutlet UISwitch *switc;
- (IBAction)switchClick:(UISwitch *)sender;

@end
