//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Chase Southard on 1/8/12.
//  Copyright (c) 2012 Cogitools Software Corp. All rights reserved.
//

#import "CalculatorBrain.h"


@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;


- (NSMutableArray *)operandStack
{
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)setOperandStack:(NSMutableArray *)operandStack
{
    _operandStack = operandStack;
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
    
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}


- (double)performOperation:(NSString *)operation
{
    double result = 0;
    // calc result
    // sin and cos are in Rad NOT Deg
    
    if([operation isEqualToString:@"+"]){
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]){
        result = [self popOperand] * [self popOperand];
    } else if ([@"/" isEqualToString:operation]){
        // TODO: How to handle divide by Zero
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([@"-" isEqualToString:operation]){
        double subtrahend = [self popOperand];
        if (subtrahend) result = [self popOperand] - subtrahend;
    } else if ([@"π" isEqualToString:operation]){
        result = 3.1415926535897932384626433832795028841971693993751058209749;
    } else if ([@"sqrt" isEqualToString:operation]){
        result = sqrt([self popOperand]);
    } else if ([@"C" isEqualToString:operation]){
        result = 0;
        [self.operandStack removeAllObjects];        
    } else if ([@"sin" isEqualToString:operation]){
        result = sin([self popOperand]);
    } else if ([@"cos" isEqualToString:operation]){
        result = cos([self popOperand]);
    } else if ([@"1/x" isEqualToString:operation]){
        double denominator = [self popOperand];
        if(denominator != 0){
            result = (1/denominator);
        }
            
    } else if ([@"x^2" isEqualToString:operation]){
        result = exp2([self popOperand]);
    }
    
    [self pushOperand:result];
    return result;
}

- (NSString *)operands{
    return [self.operandStack componentsJoinedByString:@" "];
}

- (void)backspace{
    [self popOperand];
}

@end
