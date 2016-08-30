//
// Created by Maciej Gomółka on 28.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "AddOperator.h"
#import "Variable.h"

@implementation AddOperator

- (instancetype)init
{
    if (self = [super init]) {
        _priority = 1;
        _symbol = @"+";
    }
    return self;
}

- (Variable *)makeOperationWithFirstArgument:(Variable *)firstArgument SecondArgument:(Variable *)secondArgument
{
    Variable *result = [[Variable alloc] initWithSymbol:@"" value:@"0"];
    result.value = [firstArgument.value decimalNumberByAdding:secondArgument.value];
    return result;
}

@end
