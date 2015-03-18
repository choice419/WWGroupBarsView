//
//  WWGroupBarsView.m
//  WWGroupBarsView
//
//  Created by choice on 15/3/16.
//  Copyright (c) 2015年 choice. All rights reserved.
//

#import "WWGroupBarsView.h"

#define PADDING 35

#define ANIMATIONDURATION 1.5

@implementation WWGroupBarsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        
        self.valueRanges=WWMakeGraphValuesRange(CGFLOAT_MIN, CGFLOAT_MAX);
        
        self.topCornerRadius=-1;
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.values.count ) {
        
        for (UIView *subview in self.subviews) {
            [subview removeFromSuperview];
        }
        
        [self addBarsAnimated:shouldAnimate];
        [self.graphColor setStroke];
    }
}

- (void)addBarsAnimated:(BOOL)animated{
    
    for (UIButton* button in buttons) {
        [button removeFromSuperview];
    }
    
    if (buttons) {
        [buttons removeAllObjects];
    }else{
        buttons=[[NSMutableArray alloc] init];
    }
    
    if (animated) {
        self.layer.masksToBounds=YES;
    }
    
    if(!self.amountAll)
    {
        return;
    }
    
    CGFloat barWidth=self.frame.size.width/(self.amountAll*2);
    
    CGFloat radius=barWidth*(self.topCornerRadius >=0 ? self.topCornerRadius : 0.3);
    for (NSInteger i=0;i<points.count;i++) {
        CGFloat height=[[points objectAtIndex:i] floatValue]*(self.height-PADDING);
        
        UIButton *button=[[UIButton alloc] init];
        [button setBackgroundColor:self.graphColor];
        button.frame=CGRectMake(2*barWidth*i, animated ? self.height : self.height-height, barWidth, animated ? height+PADDING : height);
        
        //总和
        float sum = [[self.values objectAtIndex:i] floatValue];
        
        for (int j = 0; j<[_allValueArray count]; j++) {
            float n1 = [[[_allValueArray objectAtIndex:j] objectAtIndex:i] floatValue];
            
            float h = 0.0;
            for (int k = 0; k<j; k++) {
                h += [[[_allValueArray objectAtIndex:k] objectAtIndex:i] floatValue];
            }
            
            CGRect fr1 = CGRectMake(0, sum?h/sum*height:0, button.frame.size.width, sum?n1/sum*height:0);
            
            UIView *v1 = [[UIView alloc] initWithFrame:fr1];
            
            UIColor *color;
            if (_colorsArray.count > j) {
                color = [_colorsArray objectAtIndex:j];
            }else{
                color = [UIColor redColor];
            }
            
            v1.backgroundColor = color;
            [button addSubview:v1];
        }
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = button.bounds;
        
        
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)].CGPath;
        
        button.layer.mask=maskLayer;
        
        [self addSubview:button];
        
        if (animated) {
            [UIView animateWithDuration:self.animationDuration delay:i*0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                button.y=self.height-height-PADDING;
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:.15 animations:^{
                    button.frame=CGRectMake(2*barWidth*i, self.frame.size.height-height, barWidth, height);
                }];
            }];
        }
        [buttons addObject:button];
    }
    shouldAnimate=NO;
}

- (CGFloat)animationDuration{
    return  .25;
}

- (void)animate{
    
    shouldAnimate=YES;
    
    [self setNeedsDisplay];
}


#pragma mark setters

-(void)setAllValueArray:(NSMutableArray *)allValueArray
{
    _allValueArray = allValueArray;
    if (_allValueArray.count > 0) {
        NSInteger tempCount = [(NSArray *)[_allValueArray objectAtIndex:0] count];
        
        for (int i = 0; i<_allValueArray.count; i++) {
            NSInteger count = [(NSArray *)[_allValueArray objectAtIndex:i] count];
            if (tempCount != count) {
                return;
            }
        }
        
        _values = [[NSMutableArray alloc] init];
        
        for (int i = 0; i<tempCount; i++) {
            CGFloat f = 0.0;
            for (int j = 0; j<_allValueArray.count; j++) {
                float temp = [[[_allValueArray objectAtIndex:j] objectAtIndex:i] floatValue];
                f += temp;
            }
            
            [_values addObject:[NSNumber numberWithFloat:f]];
        }
        
        points=[self pointsForArray:_values];
        
        [self setNeedsDisplay];
    }
}

- (void)setValues:(NSArray *)values{
    if (values) {
        _values=[values copy];
        
        points=[self pointsForArray:_values];
        
        [self setNeedsDisplay];
    }
}

- (UIColor *)graphColor{
    
    return _graphColor ? _graphColor : [UIColor blueColor];
    
}

-(void)setColorsArray:(NSMutableArray *)colorsArray
{
    _colorsArray = colorsArray;
}

- (NSMutableArray *)pointsForArray:(NSArray *)values{
    
    CGFloat min,max;
    
    if (WWValuesRangeNULL(self.valueRanges)) {
        _valueRanges=[self rangeForValues:values];
        min=_valueRanges.min;
        max=_valueRanges.max;
    }else{
        max=_valueRanges.max;
        min=_valueRanges.min;
    }
    
    NSMutableArray *pointsArray=[[NSMutableArray alloc] init];
    
    if(max!=min){
        for (NSString *p in values) {
            
            CGFloat val=[p floatValue];
            
            val = val/max;
            
            [pointsArray addObject:@(val)];
        }
        
    }else [pointsArray addObject:@(1)];
    
    return pointsArray;
}



- (void)setValueRanges:(WWGraphValuesRange)valueRanges{
    
    _valueRanges=valueRanges;
    
    if (!WWValuesRangeNULL(valueRanges) && self.values) {
        points=[self pointsForArray:self.values];
    }
}



- (WWGraphValuesRange)rangeForValues:(NSArray *)values{
    
    CGFloat min,max;
    
    min=max=[[values firstObject] floatValue];
    
    for (NSInteger i=0; i<values.count; i++) {
        
        CGFloat val=[[values objectAtIndex:i] floatValue];
        
        if (val>max) {
            max=val;
        }
        
        if (val<min) {
            min=val;
        }
    }
    
    return WWMakeGraphValuesRange(min, max);
}

@end
