//
//  ViewController.m
//  CCGPopupBoxExample
//
//  Created by chengcg on 15/11/10.
//  Copyright © 2015年 ccg. All rights reserved.
//

#import "ViewController.h"
#import "MultiItemsPopupBox.h"
#import "SelectColorView.h"

@interface ViewController ()
- (IBAction)changeLabelFont:(id)sender;
- (IBAction)changeTextColor:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeLabelFont:(id)sender {
    NSArray *sysfonts = [UIFont familyNames];
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:42];
    for (NSString *str in sysfonts) {
        PopupItemData *data = [[PopupItemData alloc] initWithText:str Data:nil];
        [dataArr addObject:data];
    }
    
    NSString *fontName = [self.labelText.font familyName];
    NSInteger index = [sysfonts indexOfObject:fontName];
    
    index = index>=[sysfonts count] ? -1 : index;
    
    MultiItemsPopupBox *box = [[MultiItemsPopupBox alloc]initWithTitle:@"选择字体"
                                                                 items:dataArr
                                                           scrollIndex:index
                                                            complation:^(PopupItemData *data)
    {
        self.labelText.font = [UIFont fontWithName:data.text size:18];
    }];
    box.suportedInterfaceOrientations = self.supportedInterfaceOrientations;
    [box show];
}

- (IBAction)changeTextColor:(id)sender {
    SelectColorView* colorView = [[[NSBundle mainBundle] loadNibNamed:@"SelectColorView" owner:self options:nil]lastObject];
    [colorView color:self.labelText.textColor complationBlock:^(UIColor *color) {
        self.labelText.textColor = color;
    }];
    colorView.suportedInterfaceOrientations = self.supportedInterfaceOrientations;
    [colorView show];
}
@end
