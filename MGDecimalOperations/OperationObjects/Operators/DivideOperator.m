//
// Created by Maciej Gomółka on 28.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "DivideOperator.h"
#import "Variable.h"

@implementation DivideOperator

- (instancetype)init
{
    if (self = [super init]) {
        _priority = 2;
        _symbol = @"/";
    }
    return self;
}

- (Variable *)makeOperationWithFirstArgument:(Variable *)firstArgument SecondArgument:(Variable *)secondArgument
{
    Variable *result = [[Variable alloc] initWithSymbol:@"" value:@"0"];
    result.value = [firstArgument.value decimalNumberByDividingBy:secondArgument.value];
    return result;
}

@end
