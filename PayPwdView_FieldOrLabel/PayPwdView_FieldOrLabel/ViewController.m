//
//  ViewController.m
//  PayPwdView_FieldOrLabel
//
//  Created by 刘家男 on 16/7/12.
//  Copyright © 2016年 刘家男. All rights reserved.
//

#import "ViewController.h"
#import "PwdView.h"
#import "PSWView.h"
@interface ViewController ()<DelegatePwd,DelegatePSW>
@property(nonatomic,strong)PwdView * PayField;
@property(nonatomic,strong)PSWView * PayLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     field样式
     */
    self.PayField =[[PwdView
                      alloc]initWithFrame:CGRectMake(50, 100, 300, 50)withFieldNum:6 showPwd:YES];
    [self.view addSubview:self.PayField];
    
    self.PayField.delegate = self;
    
    
    /**
     * label样式
     */
    self.PayLabel = [[PSWView alloc]initWithFrame:CGRectMake(50, 200, 300, 50) labelNum:6 showPSW:YES];
    [self.view addSubview:self.PayLabel];
    
    self.PayLabel.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.PayField endEditing:YES];
    [self.PayLabel endEditing:YES];
}
-(void)pwdNum:(NSString *)pwdNum{
    NSLog(@"我的密码出来了是%@",pwdNum);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
