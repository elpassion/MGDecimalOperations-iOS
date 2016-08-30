//
// Created by Maciej Gomółka on 28.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "OperatorFactory.h"
#import "SubtractOperator.h"
#import "MultiplyOperator.h"
#import "DivideOperator.h"
#import "BracketOperator.h"
#import "AddOperator.h"

@implementation OperatorFactory

- (id <OperationObjectProtocol>)getOperatorWithCharacter:(UniChar)operatorSymbol
{
    switch (operatorSymbol) {
        case '+':
            return [[AddOperator alloc] init];
        case '-':
            return [[SubtractOperator alloc] init];
        case '*':
            return [[MultiplyOperator alloc] init];
        case '/':
            return [[DivideOperator alloc] init];
        case '(':
            return [[BracketOperator alloc] initWithSymbol:@"("];
        case ')':
            return [[BracketOperator alloc] initWithSymbol:@")"];
        default:
            return nil;
    }
}

@end
