//
//  CCGPopupBoxViewController.m
//  EMPian
//
//  Created by chengcg on 15/11/2.
//  Copyright © 2015年 com. All rights reserved.
//

#import "CCGPopupBoxViewController.h"
#import "CCGPopupBox.h"

@interface CCGPopupBoxViewController () <UIGestureRecognizerDelegate>

@end

@implementation CCGPopupBoxViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        UITapGestureRecognizer *gestureRecognizer;
        gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(singleTap:)];
        gestureRecognizer.delegate = self;
        [self.view addGestureRecognizer:gestureRecognizer];
    }
    return self;
}

- (void)singleTap:(UITapGestureRecognizer *)recognizer
{
    if(self.modalType)
        return;
    for (UIView* v in self.view.subviews) {
        if ([v isKindOfClass:[CCGPopupBox class]]
            && [v respondsToSelector:@selector(dismissFromWindowTouch)])
        {
            [v performSelector:@selector(dismissFromWindowTouch)];
        }
    }
}
#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch view] != self.view)
        return NO;
    CGPoint p = [touch locationInView:self.view];
    for (UIView* v in self.view.subviews) {
        if (CGRectContainsPoint(v.frame, p))
            return NO;
    }
    return YES;
}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if(self.modalType)
//        return;
//    if (event.type == UIEventTypeTouches) {
//        UIView *view = [[touches anyObject] view];
//        if (view != self.view)
//            return;
//        for (UIView* v in self.view.subviews) {
//            if ([v isKindOfClass:[CCGPopupBox class]]
//                && [v respondsToSelector:@selector(dismissFromWindowTouch)]) {
//                [v performSelector:@selector(dismissFromWindowTouch)];
//            }
//        }
//    }
//}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return _suportedInterfaceOrientations;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
