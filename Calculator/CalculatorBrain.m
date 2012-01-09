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
    
    if([operation isEqualToString:@"+"]){
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]){
        result = [self popOperand] * [self popOperand];
    } else if ([@"/" isEqualToString:operation]){
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([@"-" isEqualToString:operation]){
        double subtrahend = [self popOperand];
        if (subtrahend) result = [self popOperand] - subtrahend;
    } else if ([@"Pi" isEqualToString:operation]){
        result = 3.1415926535897932384626433832795028841971693993751058209749;
    } else if ([@"SQRT" isEqualToString:operation]){
        result = sqrt([self popOperand]);
    } else if ([@"AC" isEqualToString:operation]){
        result = 0;
        [self.operandStack removeAllObjects];        
    }
    
    [self pushOperand:result];
    return result;
}

@end
