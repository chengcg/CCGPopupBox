//
//  SelectColorView.m
//  EMPian
//
//  Created by chengcg on 15/11/4.
//  Copyright © 2015年 com. All rights reserved.
//

#import "SelectColorView.h"

@interface SelectColorView()

@property (copy, nonatomic) void(^completeBlock)(UIColor*);

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
    [self.btnOk setTitle:@"确定" forState:UIControlStateNormal];
}

-(void)color:(UIColor *)color complationBlock:(void (^)(UIColor *))complate
{
    self.completeBlock = complate;
    UIColor *c = color;
    if (color==nil) {
        c=[UIColor blackColor];
    }
    self.colorPreView.backgroundColor = c;
    
    CGFloat a;
    CGFloat R,G,B;
    [c getRed:&R green:&G blue:&B alpha:&a];
    self.labelRed.text = [NSString stringWithFormat:@"%.f",R*255.0];
    self.labelGreen.text = [NSString stringWithFormat:@"%.f",G*255.0];
    self.labelBlue.text = [NSString stringWithFormat:@"%.f",B*255.0];
    
    self.sliderRed.value = R*255.0;
    self.sliderGreen.value = G*255.0;
    self.sliderBlue.value = B*255.0;
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    if (sender == self.sliderRed) {
        self.labelRed.text = [NSString stringWithFormat:@"%.f",sender.value];
    }else if( sender == self.sliderGreen) {
        self.labelGreen.text = [NSString stringWithFormat:@"%.f",sender.value];
    }else if( sender == self.sliderBlue) {
        self.labelBlue.text = [NSString stringWithFormat:@"%.f",sender.value];
    }
    
   self.colorPreView.backgroundColor = [UIColor colorWithRed:self.sliderRed.value /255.0
                                                   green:self.sliderGreen.value /255.0
                                                    blue:self.sliderBlue.value /255.0
                                                   alpha:1.0];
}

- (IBAction)btnClick:(UIButton *)sender {
    if (self.completeBlock) {
        self.completeBlock(self.colorPreView.backgroundColor);
    }
    [self dismissWithAnimated:YES];
}
@end
