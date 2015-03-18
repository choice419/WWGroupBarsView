//
//  WWGraphValuesRange.h
//  ZhiNengGuangFu
//
//  Created by choice on 14/12/9.
//  Copyright (c) 2014年 choice. All rights reserved.
//

#ifndef ZhiNengGuangFu_WWGraphValuesRange_h
#define ZhiNengGuangFu_WWGraphValuesRange_h



struct _WWValuesRange {
    CGFloat max;
    CGFloat min;
};


typedef struct _WWValuesRange WWGraphValuesRange;


NS_INLINE WWGraphValuesRange WWMakeGraphValuesRange(CGFloat min, CGFloat max) {
    WWGraphValuesRange r;
    r.min = min;
    r.max = max;
    return r;
}

NS_INLINE BOOL WWValuesRangeNULL(WWGraphValuesRange r) {
    return r.min==CGFLOAT_MIN && r.max==CGFLOAT_MAX;
}

#endif
