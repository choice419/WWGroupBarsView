//
//  WWGroupBarsView.h
//  WWGroupBarsView
//
//  Created by choice on 15/3/16.
//  Copyright (c) 2015年 choice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"
#import "WWGraphValuesRange.h"

@interface WWGroupBarsView : UIView
{
    BOOL shouldAnimate;
    
    NSMutableArray *buttons;
    NSArray *points;
}

@property (nonatomic,readwrite) CGFloat topCornerRadius;


@property (nonatomic,copy) NSMutableArray *values; // array of NSNumber or NSString

@property (nonatomic,copy) NSMutableArray *allValueArray;

//@property (nonatomic,copy) NSArray *values1; // array of NSNumber or NSString
//@property (nonatomic,copy) NSArray *values2; // array of NSNumber or NSString
//@property (nonatomic,copy) NSArray *values3; // array of NSNumber or NSString



@property (nonatomic,retain) UIColor *graphColor; // color of the line
@property (nonatomic,copy) NSMutableArray *colorsArray;

@property (nonatomic, assign) int amountAll;     //amount of all

@property (nonatomic,assign) WWGraphValuesRange valueRanges; // specify or read the max min


- (void)animate;

@end
