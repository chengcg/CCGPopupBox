//
//  PopupItemData.m
//  EMPian
//
//  Created by chengcg on 15/11/3.
//  Copyright © 2015年 com. All rights reserved.
//

#import "PopupItemData.h"

@implementation PopupItemData

-(id)initWithText:(NSString*)text Data:(id)data
{
    self = [super init];
    if (self) {
        _text = text;
        _data = data;
    }
    return self;
}

@end
