//
//  PwdView.m
//  aaa
//
//  Created by 刘家男 on 16/7/8.
//  Copyright © 2016年 刘家男. All rights reserved.
//

#import "PSWView.h"

@interface PSWView ()<UITextFieldDelegate>

@property (nonatomic, strong)NSMutableArray *labelMArr;

@property (nonatomic, strong)UITextField *numTextField;

@property BOOL isShow;

@end

@implementation PSWView

- (UITextField *)numTextField
{
    if (!_numTextField) {
        _numTextField = [[UITextField alloc]initWithFrame:self.bounds];
        _numTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_numTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        _numTextField.delegate = self;
    }
    return _numTextField;
}

- (NSMutableArray *)labelMArr
{
    if (!_labelMArr) {
        _labelMArr = [NSMutableArray array];
    }
    return _labelMArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame labelNum:1 showPSW:YES];
}

- (instancetype)initWithFrame:(CGRect)frame labelNum:(NSInteger)num showPSW:(BOOL)isShow
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.numTextField];
        self.isShow = isShow;
        for (int i = 0; i < num; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width/num) *i, 0, self.frame.size.width / num, self.frame.size.height)];
            label.backgroundColor = [UIColor whiteColor];
            [self.labelMArr addObject:label];
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.borderWidth = 1;
            label.layer.cornerRadius = 7;
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouch:)];
            [label addGestureRecognizer:tap];
            [self addSubview:label];
        }
        
    }
    return self;
}

- (void)labelTouch:(UIGestureRecognizer *)tap
{
    [self.numTextField becomeFirstResponder];
}

- (void)textFieldChange:(id)sender
{
    for (int i = 0; i < self.labelMArr.count; i++) {
        UILabel *label = self.labelMArr[i];
        if (i < self.numTextField.text.length) {
            //显示密码
            if(self.isShow){
                label.text = [NSString stringWithFormat:@"%c", [self.numTextField.text characterAtIndex:i]];
            }else{
            //隐藏密码
                label.text = @"●";
            }
        } else {
            label.text = @"";
        }
    }
    if (self.numTextField.text.length > 6) {
        self.numTextField.text = [self.numTextField.text substringToIndex:6];
    }
    if (self.numTextField.text.length == 6 && [self.delegate respondsToSelector:@selector(pwdNum:)]) {
        [self.delegate pwdNum:(self.numTextField.text)];
    }
    NSLog(@"%@",self.numTextField.text);
}

@end
