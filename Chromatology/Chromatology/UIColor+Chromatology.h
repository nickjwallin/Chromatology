//
//  UIColor+Chromatology.h
//  Chromatology
//
//  Created by Carl Benson on 3/3/16.
//  Copyright © 2016 nicnacklabratories. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Chromatology)

- (UIColor *)blackColor;      // 0.0 white
- (UIColor *)darkGrayColor;   // 0.333 white
- (UIColor *)lightGrayColor;  // 0.667 white
- (UIColor *)whiteColor;      // 1.0 white
- (UIColor *)grayColor;       // 0.5 white
- (UIColor *)redColor;        // 1.0, 0.0, 0.0 RGB
- (UIColor *)greenColor;      // 0.0, 1.0, 0.0 RGB
- (UIColor *)blueColor;       // 0.0, 0.0, 1.0 RGB
- (UIColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB
- (UIColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB
- (UIColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB
- (UIColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB
- (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB
- (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB
- (UIColor *)clearColor;      // 0.0 white, 0.0 alpha

@end
