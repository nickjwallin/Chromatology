//
//  NNLColor.h
//  chroma-test
//
//  Created by Carl Benson on 3/6/16.
//  Copyright © 2016 Carl D. Benson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNLColor : UIColor

- (instancetype)initWithInitialColor:(UIColor *)color;

- (void)addColor:(UIColor *)color;

@end
