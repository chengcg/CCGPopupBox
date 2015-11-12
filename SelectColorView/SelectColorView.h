//
//  SelectColorView.h
//  EMPian
//
//  Created by chengcg on 15/11/4.
//  Copyright © 2015年 com. All rights reserved.
//

#import "CCGPopupBox.h"

@interface SelectColorView : CCGPopupBox

- (void)color:(UIColor *)color complationBlock:(void(^)(UIColor* color))complate;

@end
