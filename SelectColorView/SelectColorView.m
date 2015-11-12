//
//  SelectColorView.m
//  EMPian
//
//  Created by chengcg on 15/11/4.
//  Copyright © 2015年 com. All rights reserved.
//

#import "SelectColorView.h"

@interface SelectColorView()

@property (copy, nonatomic) void(^complateBlock)(UIColor*);

@property (weak, nonatomic) IBOutlet UILabel *labelRed;
@property (weak, nonatomic) IBOutlet UILabel *labelGreen;
@property (weak, nonatomic) IBOutlet UILabel *labelBlue;
@property (weak, nonatomic) IBOutlet UIView *colorPreView;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;
@property (weak, nonatomic) IBOutlet UISlider *sliderRed;
@property (weak, nonatomic) IBOutlet UISlider *sliderGreen;
@property (weak, nonatomic) IBOutlet UISlider *sliderBlue;

- (IBAction)sliderValueChanged:(UISlider *)sender;
- (IBAction)btnClick:(UIButton *)sender;
@end

@implementation SelectColorView

- (void)awakeFromNib
{
    [_btnOk setTitle:@"确定" forState:UIControlStateNormal];
}

-(void)color:(UIColor *)color complationBlock:(void (^)(UIColor *))complate
{
    _complateBlock = complate;
    UIColor *c = color;
    if (color==nil) {
        c=[UIColor blackColor];
    }
    _colorPreView.backgroundColor = c;
    
    CGFloat a;
    CGFloat R,G,B;
    [c getRed:&R green:&G blue:&B alpha:&a];
    _labelRed.text = [NSString stringWithFormat:@"%.f",R*255.0];
    _labelGreen.text = [NSString stringWithFormat:@"%.f",G*255.0];
    _labelBlue.text = [NSString stringWithFormat:@"%.f",B*255.0];
    
    _sliderRed.value = R*255.0;
    _sliderGreen.value = G*255.0;
    _sliderBlue.value = B*255.0;
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    if (sender == _sliderRed) {
        _labelRed.text = [NSString stringWithFormat:@"%.f",sender.value];
    }else if( sender == _sliderGreen) {
        _labelGreen.text = [NSString stringWithFormat:@"%.f",sender.value];
    }else if( sender == _sliderBlue) {
        _labelBlue.text = [NSString stringWithFormat:@"%.f",sender.value];
    }
    
   _colorPreView.backgroundColor = [UIColor colorWithRed:_sliderRed.value /255.0
                                                   green:_sliderGreen.value /255.0
                                                    blue:_sliderBlue.value /255.0
                                                   alpha:1.0];
}

- (IBAction)btnClick:(UIButton *)sender {
    if (_complateBlock) {
        _complateBlock(_colorPreView.backgroundColor);
    }
    [self dismissWithAnimated:YES];
}
@end
