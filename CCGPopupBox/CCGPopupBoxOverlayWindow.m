//
//  CCGPopupBoxOverlayWindow.m
//  EMPian
//
//  Created by chengcg on 15/11/2.
//  Copyright © 2015年 com. All rights reserved.
//

#import "CCGPopupBoxOverlayWindow.h"

@interface CCGPopupBoxOverlayWindow()
@property (nonatomic,weak) UIWindow* oldKeyWindow;
@end

@implementation CCGPopupBoxOverlayWindow


- (void)makeKeyAndVisible
{
    self.oldKeyWindow = [UIApplication sharedApplication].keyWindow;
    self.windowLevel = UIWindowLevelAlert;
    [super makeKeyAndVisible];
}

- (void)resignKeyWindow
{
    [super resignKeyWindow];
    [self.oldKeyWindow makeKeyWindow];
    if (self.ccgDelegate && [self.ccgDelegate respondsToSelector:@selector(didResignKeyWindow:)]) {
        [self.ccgDelegate didResignKeyWindow:self];
    }
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    if (hidden) {
        if (self.ccgDelegate && [self.ccgDelegate respondsToSelector:@selector(didHidden:)]) {
            [self.ccgDelegate didHidden:self];
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    CGFloat width			= self.frame.size.width +20;
    CGFloat height			= self.frame.size.height +15;
    CGFloat locations[3]	= { 0.0, 0.5, 1.0 };
    CGFloat components[12]	= {	1, 1, 1, 0.5,
        0, 0, 0, 0.5,
        0, 0, 0, 0.7	};
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef backgroundGradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 3);
    CGColorSpaceRelease(colorspace);
    
    CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(),
                                backgroundGradient,
                                CGPointMake(width/2, height/2), 0,
                                CGPointMake(width/2, height/2), width,
                                0);
    
    CGGradientRelease(backgroundGradient);
}

- (void)dealloc
{
    self.oldKeyWindow = nil;
}



@end
