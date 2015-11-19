//
//  MultiItemsPopupBox.h
//  EMPian
//
//  Created by chengcg on 15/11/3.
//  Copyright © 2015年 com. All rights reserved.
//

#import "CCGPopupBox.h"
#import "PopupItemData.h"

typedef void(^PopupItemSelectBlock)(PopupItemData* data);
@interface MultiItemsPopupBox : CCGPopupBox

- (id)initWithTitle:(NSString*)title
              items:(NSArray*)items
        scrollIndex:(NSInteger)scrollindex
         complation:(PopupItemSelectBlock)complate;

@end
