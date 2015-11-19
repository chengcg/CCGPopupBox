//
//  PopupItemData.h
//  EMPian
//
//  Created by chengcg on 15/11/3.
//  Copyright © 2015年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopupItemData : NSObject

@property (nonatomic, copy) NSString* text;
@property (nonatomic, strong) id data;

-(id)initWithText:(NSString*)text Data:(id)data;

@end
