//
//  PwdView.m
//  aaa
//
//  Created by 刘家男 on 16/7/8.
//  Copyright © 2016年 刘家男. All rights reserved.
//

#import "PwdView.h"
@interface PwdView()<UITextFieldDelegate>
@property (nonatomic,copy)NSMutableString * pwdNum;
@property (nonatomic,assign)NSInteger num;
@property (nonatomic,strong)NSString * str;
@property (nonatomic,assign)NSInteger oldLength;
@property UITapGestureRecognizer *tap;
@end
@implementation PwdView
-(instancetype)initWithFrame:(CGRect)frame withFieldNum:(NSInteger)num showPwd:(BOOL)isShow{
    self = [super initWithFrame:frame ];
    if (self) {
        /**
         *  a 表示单个field的高 ; b 表示单个field的宽 
         */
        CGFloat a = self.frame.size.height;
        CGFloat b = self.frame.size.width/num;
        self.num = num;
        for (int i = 0; i<num; i++) {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(i*b, 0, b, a)];
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.borderStyle=UITextBorderStyleRoundedRect;
            textField.layer.borderColor=[[UIColor blackColor] CGColor];
            textField.layer.borderWidth= 0.5f;
            textField.textAlignment = NSTextAlignmentCenter;
            /**
             *  是否隐藏密码
             */
            if(isShow){
                textField.secureTextEntry = NO;
            }else{
                textField.secureTextEntry = YES;
            }
          
            textField.delegate = self;
            textField.tag=i+1;
            _pwdNum=[[NSMutableString alloc]init];
            [self addSubview:textField];
            
        }
        /**
         添加一透明view覆盖在field上
         */
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 6*b, a)];
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch)];
        self.tap.numberOfTapsRequired=1;
        self.tap.numberOfTouchesRequired=1;
        [view addGestureRecognizer:self.tap];
        [self addSubview:view];
    }
    /**
     获取键盘消失状态
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    /**
     获取键盘出现状态
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillShow:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
   
    return self;
}

- (void)keyboardWillShow:(NSNotification*)aNotification

{
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch1)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    [self.subviews[self.num]addGestureRecognizer:tap];
}


- (void)keyboardWasShown:(NSNotification*)aNotification

{
    /**
     *  键盘消失时清空field显示信息
     */
    for(int i = 0 ;i<self.num;i++){
    UITextField* text = self.subviews[i];
    text.text = nil;
    }
    _pwdNum = [[NSMutableString alloc]init];
    self.str = nil;
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    [self.subviews[self.num]addGestureRecognizer:tap];

}

-(void)touch{
    /**
     *  获取第一个field的响应
     */
    [self.subviews[0] becomeFirstResponder];
}
-(void)touch1{
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    /**
     * 焦点移动时将值显示在新field上
     */
    if((unsigned long)self.pwdNum.length<=self.num&&(unsigned long)self.pwdNum.length>=self.oldLength){
        textField.text =self.str;
    }
    self.oldLength=(unsigned long)self.pwdNum.length;
    return YES;
}// return NO to disallow editing.


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"+++%ldd",(long)self.oldLength);
    /**
     *  向前输入时自动转移field响应
     */
    if (range.location>0) {
        self.str=string;

        if(textField.tag<self.num){
            [self.subviews[textField.tag] becomeFirstResponder];
            [self.pwdNum appendString:string];
        }
        if(self.pwdNum.length ==self.num){
            if ([self.delegate respondsToSelector:@selector(pwdNum:)]) {
                [self.delegate pwdNum:(self.pwdNum )];
            }
        }
     
        NSLog(@"%@----",self.pwdNum);
            

        return NO;
    }else if(string.length==0){
        /**
         *  向后输入时自动转移field响应
         */
        
        textField.text=nil;
        
        if (self.pwdNum.length>0) {
            NSRange range ={self.pwdNum.length-1,1};
            [self.pwdNum deleteCharactersInRange: range];
            if(self.pwdNum.length==0){
                self.str =nil;
            }else{
                 NSRange range ={self.pwdNum.length-1,1};
                self.str=[self.pwdNum substringWithRange:range];
            }
        }
        
        if(textField.tag-2>0-1){
            [self.subviews[textField.tag-2] becomeFirstResponder];
        }
        
         NSLog(@"%@----",self.pwdNum);
        return NO;
    }else{
        [self.pwdNum appendString:string];
        return YES;
    }
    
    
}// return NO to not change text


@end
