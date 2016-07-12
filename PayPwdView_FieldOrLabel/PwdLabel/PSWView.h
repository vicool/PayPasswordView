//
//  PwdView.h
//  aaa
//
//  Created by 刘家男 on 16/7/8.
//  Copyright © 2016年 刘家男. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DelegatePSW <NSObject>

-(void)pwdNum :(NSString *)pwdNum;

@end

@interface PSWView : UIView

@property (nonatomic,weak) id <DelegatePSW>delegate;

- (instancetype)initWithFrame:(CGRect)frame labelNum:(NSInteger)num showPSW:(BOOL)isShow;

@end
