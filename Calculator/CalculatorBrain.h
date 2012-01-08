//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Chase Southard on 1/8/12.
//  Copyright (c) 2012 Cogitools Software Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@end
