//
//  PwdView.h
//  aaa
//
//  Created by 刘家男 on 16/7/8.
//  Copyright © 2016年 刘家男. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DelegatePwd <NSObject>

-(void)pwdNum :(NSString *)pwdNum;

@end

@interface PwdView : UIView

@property (nonatomic,weak) id <DelegatePwd>delegate;

-(instancetype)initWithFrame:(CGRect)frame withFieldNum:(NSInteger)num showPwd:(BOOL)isShow;

@end
