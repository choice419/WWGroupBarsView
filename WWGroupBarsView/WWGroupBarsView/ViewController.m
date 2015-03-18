//
//  ViewController.m
//  WWGroupBarsView
//
//  Created by choice on 15/3/16.
//  Copyright (c) 2015年 choice. All rights reserved.
//

#import "ViewController.h"
#import "WWGroupBarsView.h"

// 屏幕大小
#define SCREENWIDTH           [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT          [UIScreen mainScreen].bounds.size.height

// 颜色16进制转换
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()
{
    WWGroupBarsView *wasteGraph;   //叠加柱状图
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    wasteGraph= [[WWGroupBarsView alloc] initWithFrame:CGRectMake(10, 14, SCREENWIDTH-20-10, 140)];
    wasteGraph.graphColor=[UIColor colorWithRed:140.0/255.0 green:208.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    
    [self.view addSubview:wasteGraph];
    
    NSMutableArray *array1 = [@[@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3"] mutableCopy];
    NSMutableArray *array2 = [@[@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3"] mutableCopy];
    NSMutableArray *array3 = [@[@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3"] mutableCopy];
    NSMutableArray *array4 = [@[@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"1"] mutableCopy];
    NSMutableArray *array5 = [@[@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"1"] mutableCopy];
    
    
    
    wasteGraph.allValueArray = [@[array1,array2,array3,array4,array5] mutableCopy];
    
    wasteGraph.colorsArray = [@[UIColorFromRGB(0x98aaef),UIColorFromRGB(0x299fee),UIColorFromRGB(0x29ccee),UIColorFromRGB(0x98aaef),UIColorFromRGB(0x299fee)] mutableCopy];
    
    wasteGraph.hidden = NO;
    wasteGraph.amountAll =12;
    [wasteGraph animate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
