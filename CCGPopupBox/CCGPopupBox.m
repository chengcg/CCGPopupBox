//
//  CCGPopupBox.m
//  EMPian
//
//  Created by chengcg on 15/11/2.
//  Copyright © 2015年 com. All rights reserved.
//

#import "CCGPopupBox.h"
#import "CCGPopupBoxViewController.h"
#import "CCGPopupBoxOverlayWindow.h"

@interface CCGPopupBox()
@property(nonatomic,strong) CCGPopupBoxOverlayWindow* oldWindow;
@end

@implementation CCGPopupBox

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _suportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _suportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
        self.backgroundColor = [UIColor whiteColor];
    } 
    return self;
}

- (void)layoutSubviews
{
    if (self.superview) {
        self.center = CGPointMake( CGRectGetMidX( self.superview.bounds ), CGRectGetMidY( self.superview.bounds ) );
        self.frame = CGRectIntegral( self.frame );
        [_oldWindow setNeedsDisplay];
    }
   [super layoutSubviews];
}

- (void)genWindow:(BOOL)modal
{
    [[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode beforeDate:[NSDate date]];
    
    CCGPopupBoxViewController* vc = [[CCGPopupBoxViewController alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];
    vc.suportedInterfaceOrientations = self.suportedInterfaceOrientations;
    vc.modalType = modal;
    
    _oldWindow = [[CCGPopupBoxOverlayWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    _oldWindow.alpha = 0.0;
    _oldWindow.backgroundColor = [UIColor clearColor];
    _oldWindow.rootViewController = vc;
    [_oldWindow makeKeyAndVisible];
    
    [UIView animateWithDuration: 0.2 animations: ^{
        _oldWindow.alpha = 1;
    }];
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius = 8.0f;
    [self setAutoresizingMask:UIViewAutoresizingNone];
    [vc.view addSubview: self];
    self.center = CGPointMake( CGRectGetMidX( vc.view.bounds ), CGRectGetMidY( vc.view.bounds ) );
    self.frame = CGRectIntegral( self.frame );
    [self pulse];
}

- (void) pulse
{
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration: 0.2
                     animations: ^{
                         self.transform = CGAffineTransformIdentity;
                     }];
}

- (void)show
{
    [self genWindow:NO];
}

- (void)showModal
{
    [self genWindow:YES];
}

- (void)dismissFromWindowTouch
{
    [self dismissWithAnimated:YES];
}
- (void)dismissWithAnimated:(BOOL)animated
{
    if (animated)
    {
        self.window.backgroundColor = [UIColor clearColor];
        self.window.alpha = 1;
        
        [UIView animateWithDuration: 0.2
                         animations: ^{
                             [self.window resignKeyWindow];
                             self.window.alpha = 0;
                         }
                         completion: ^(BOOL finished) {
                             [self releaseWindow];
                             [self removeFromSuperview];
                         }];
    }
    else
    {
        [self.window resignKeyWindow];
        [self releaseWindow];
        [self removeFromSuperview];
    }
}

- (void)releaseWindow
{
    //回调代理方法，通知代理关闭窗口
    if ([self.delegate respondsToSelector:@selector(popupBoxDismiss:)]) {
        [self.delegate popupBoxDismiss:self];
    }
    _oldWindow = nil;
}

@end
