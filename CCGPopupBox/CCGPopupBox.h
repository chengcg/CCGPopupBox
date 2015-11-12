//
//  CCGPopupBox.h
//  EMPian
//
//  Created by chengcg on 15/11/2.
//  Copyright © 2015年 com. All rights reserved.
//

/*
 参考了 TSAlertView KxMenu
 */

#import <UIKit/UIKit.h>

@class CCGPopupBox;

@protocol CCGPopupBoxDelegate <NSObject>
@optional
-(void)popupBoxDismiss:(CCGPopupBox *)popupBox;

@end


@class CCGPopupBoxOverlayWindow;

@interface CCGPopupBox : UIView

@property (nonatomic, strong) id<CCGPopupBoxDelegate> delegate;
@property (nonatomic, assign) NSUInteger suportedInterfaceOrientations;

-(void)show;
-(void)showModal;

- (void)dismissFromWindowTouch;
-(void)dismissWithAnimated:(BOOL)animated;

@end
