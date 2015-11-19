//
//  MultiItemsPopupBox.m
//  EMPian
//
//  Created by chengcg on 15/11/3.
//  Copyright © 2015年 com. All rights reserved.
//

#import "MultiItemsPopupBox.h"
#import <UIKit/UIKit.h>

#define kEdgeSize 20.0f
#define kItemHeight 44.0f
#define kTitleHeight 50.0f
#define kMinBoxWidth 200.0f

@interface MultiItemsPopupBox() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray *dataItems;
@property (nonatomic,copy) PopupItemSelectBlock completeBlock;
@property (nonatomic,assign) NSInteger scrollIndex;

@property (nonatomic,weak) UITableView *tableContent;
@property (nonatomic,weak) UILabel *lableTitle;
@property (nonatomic,weak) UIView *lineView;
@end

@implementation MultiItemsPopupBox

- (void)dealloc
{
    self.tableContent.delegate = nil;
    self.tableContent.dataSource = nil;
}

- (id)initWithTitle:(NSString*)title
              items:(NSArray*)items
        scrollIndex:(NSInteger)scrollindex
         complation:(PopupItemSelectBlock)complate
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.scrollIndex = scrollindex;
        self.dataItems = items;
        self.completeBlock = complate;
        
        CGFloat boxHeight = [self boxCalculateHeight];
        CGFloat boxWidth = [self boxCalculateWidth];
        self.bounds = CGRectMake(0, 0, boxWidth, boxHeight);
        
        CGRect rctLabelTitle = CGRectMake(0, 0, boxWidth, kTitleHeight-1);
        CGRect rctLineView = CGRectMake(0, kTitleHeight-0.7, boxWidth, 0.7);
        CGRect rctTable = CGRectMake(0, kTitleHeight, boxWidth, boxHeight-kTitleHeight);
        
        UILabel *label = [[UILabel alloc] initWithFrame:rctLabelTitle];
        label.text = title;
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        
        UIView *singleLine = [[UIView alloc] initWithFrame:rctLineView];
        singleLine.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0];
        
        UITableView *table = [[UITableView alloc] initWithFrame:rctTable
                                                          style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorInset = UIEdgeInsetsZero;
        if ([UIDevice currentDevice].systemVersion.floatValue>=8.0) {
            table.layoutMargins=UIEdgeInsetsZero;
        }
        self.lableTitle = label;
        self.lineView = singleLine;
        self.tableContent = table;
        
        [self addSubview:singleLine];
        [self addSubview:label];
        [self addSubview:table];
    }
    return self;
}

- (CGFloat)boxCalculateHeight
{
    CGRect bounds = self.superview ? self.superview.bounds : [UIScreen mainScreen].bounds;
    CGFloat maxHeight = bounds.size.height-kEdgeSize*2;
    CGFloat realHeight = self.dataItems.count*kItemHeight + kTitleHeight;
    return MIN(maxHeight,realHeight);
}


-(void)layoutSubviews
{
    CGFloat boxHeight = [self boxCalculateHeight];
    CGFloat boxWidth = [self boxCalculateWidth];
    
    self.bounds = CGRectMake(0, 0, boxWidth, boxHeight);
    self.lableTitle.frame = CGRectMake(0, 0, boxWidth, kTitleHeight-1);
    self.lineView.frame = CGRectMake(0, kTitleHeight-0.7, boxWidth, 0.7);
    self.tableContent.frame = CGRectMake(0, kTitleHeight, boxWidth, boxHeight-kTitleHeight);
    
    [super layoutSubviews];
}

-(CGFloat)boxCalculateWidth
{
    CGFloat maxW = 0.0f;
    NSArray* items = self.dataItems;
    for (PopupItemData* pitem in items) {
        CGSize titleSize = [pitem.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
        maxW = MAX(maxW, titleSize.width);
    }
    maxW += 30.f;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width-kEdgeSize*2;
    return MAX(MIN(maxW, maxWidth),kMinBoxWidth);
}

-(void)scrollTableViewToIndex
{
    if (self.scrollIndex>=0) {
        [self.tableContent scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.scrollIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

-(void)show
{
    [super show];
    [self scrollTableViewToIndex];
}

- (void)showModal
{
    [super showModal];
    [self scrollTableViewToIndex];
}

#pragma - mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataItems.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"CellIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    PopupItemData* cellModel = [self.dataItems objectAtIndex:[indexPath row]];
    cell.textLabel.text = cellModel.text;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.separatorInset = UIEdgeInsetsZero;
    if (self.scrollIndex>=0 && [indexPath row]==self.scrollIndex) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell.textLabel.textColor = [UIColor blueColor];
    } else {
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    if ([UIDevice currentDevice].systemVersion.floatValue>=8.0) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }

    return cell;
}

#pragma - mark UITableViewDalagate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kItemHeight;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.completeBlock) {
        self.completeBlock([self.dataItems objectAtIndex:[indexPath row]]);
    }
    [self dismissWithAnimated:YES];
}

@end
