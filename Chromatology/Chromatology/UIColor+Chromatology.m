//
//  UIColor+Chromatology.m
//  Chromatology
//
//  Created by Carl Benson on 3/3/16.
//  Copyright © 2016 nicnacklabratories. All rights reserved.
//

#import "UIColor+Chromatology.h"
#include <objc/objc-runtime.h>

@implementation UIColor (Chromatology)

static dispatch_queue_t nillingQueue;

- (UIColor *)mixedWithColor:(UIColor *)other {
    CGFloat selfRed = 0.0,  selfGreen = 0.0,  selfBlue = 0.0,  selfAlpha = 0.0,
            otherRed = 0.0, otherGreen = 0.0, otherBlue = 0.0, otherAlpha = 0.0;
    [self  getRed:&selfRed  green:&selfGreen  blue:&selfBlue  alpha:&selfAlpha];
    [other getRed:&otherRed green:&otherGreen blue:&otherBlue alpha:&otherAlpha];
    return [UIColor colorWithRed:(selfRed + otherRed) * 0.5
                           green:(selfGreen + otherGreen) * 0.5
                            blue:(selfBlue + otherBlue) * 0.5
                           alpha:(selfAlpha + otherAlpha) * 0.5];
}

// A prototypical method to base other method signatures off of.
- (UIColor *)chroma_testColor {
    return nil;
}

// SWIZZLING!
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalMethodSigSEL = @selector(methodSignatureForSelector:);
        SEL ourMethodSigSEL = @selector(chroma_methodSignatureForSelector:);

        [self swizzleForClass:class originalSelector:originalMethodSigSEL newSelector:ourMethodSigSEL];

        SEL originalForwardInvocationSEL = @selector(forwardInvocation:);
        SEL ourForwardInvocationSEL = @selector(chroma_forwardInvocation:);

        [self swizzleForClass:class originalSelector:originalForwardInvocationSEL newSelector:ourForwardInvocationSEL];
    });
}

+ (void)swizzleForClass:(Class)class originalSelector:(SEL)originalSelector newSelector:(SEL)newSelector {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);

    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (success) {
        class_replaceMethod(class, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

- (NSMethodSignature *)chroma_methodSignatureForSelector:(SEL)aSelector {
    if ([UIColor respondsToSelector:aSelector] &&
        [[UIColor performSelector:aSelector] isKindOfClass:[UIColor class]]) {
        return [self chroma_methodSignatureForSelector:@selector(chroma_testColor)];
    } else {
        return [self chroma_methodSignatureForSelector:aSelector];
    }
}

- (void)chroma_forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = [anInvocation selector];
    __block UIColor *result = [self mixedWithColor:[UIColor performSelector:aSelector]];
    [anInvocation setReturnValue:&result];
    // So here's the deal. `result` isn't retained between the time this method returns and the time it's used.
    // In order to make sure `&result` is pointing to something by the time it gets used we need to keep a
    // reference to it. The whole thing is a beautiful hack.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nillingQueue = dispatch_queue_create("com.nicknacklabs.chromatology.nilling", DISPATCH_QUEUE_CONCURRENT);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), nillingQueue, ^{
        result = nil;
    });
}

@end
