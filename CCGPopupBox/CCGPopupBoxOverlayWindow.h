//
//  CCGPopupBoxOverlayWindow.h
//  EMPian
//
//  Created by chengcg on 15/11/2.
//  Copyright © 2015年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCGPopupBoxOverlayWindow;
@protocol CCGPopupBoxOverlayWindowDelegate <NSObject>

@optional
- (void)didHidden:(CCGPopupBoxOverlayWindow *)window;
- (void)didResignKeyWindow:(CCGPopupBoxOverlayWindow *)window;
@end


@interface CCGPopupBoxOverlayWindow : UIWindow

@property (weak, nonatomic) id<CCGPopupBoxOverlayWindowDelegate>ccgDelegate;
@end
