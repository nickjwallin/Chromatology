//
//  NNLColor.m
//  chroma-test
//
//  Created by Carl Benson on 3/6/16.
//  Copyright © 2016 Carl D. Benson. All rights reserved.
//

#import "NNLColor.h"

@interface NNLColor()

@property (strong, nonatomic) UIColor *internalColor;
@property NSUInteger colorCount;

@end

@implementation NNLColor

- (instancetype)initWithInitialColor:(UIColor *)color {
    if (self = [super init]) {
        self.internalColor = color;
        self.colorCount = 1;
    }
    return self;
}

- (void)addColor:(UIColor *)color {
    self.internalColor = [self mixedWithColor:color];
    self.colorCount += 1;
}

- (UIColor *)mixedWithColor:(UIColor *)other {
    CGFloat selfRed = 0.0,  selfGreen = 0.0,  selfBlue = 0.0,  selfAlpha = 0.0,
    otherRed = 0.0, otherGreen = 0.0, otherBlue = 0.0, otherAlpha = 0.0;
    double factor = 1.0/((double)(self.colorCount + 1));
    [self  getRed:&selfRed  green:&selfGreen  blue:&selfBlue  alpha:&selfAlpha];
    [other getRed:&otherRed green:&otherGreen blue:&otherBlue alpha:&otherAlpha];
    return [UIColor colorWithRed:(selfRed * self.colorCount + otherRed) * factor
                           green:(selfGreen * self.colorCount + otherGreen) * factor
                            blue:(selfBlue * self.colorCount + otherBlue) * factor
                           alpha:(selfAlpha * self.colorCount + otherAlpha) * factor];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.internalColor];
}


@end
