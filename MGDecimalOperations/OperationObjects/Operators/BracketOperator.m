//
// Created by Maciej Gomółka on 30.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "BracketOperator.h"
#import "Variable.h"

@implementation BracketOperator

- (instancetype)initWithSymbol:(NSString *)symbol
{
    if (self = [super init]) {
        _symbol = symbol;
    }
    return self;
}

- (Variable *)makeOperationWithFirstArgument:(Variable *)firstArgument SecondArgument:(Variable *)secondArgument
{
    return nil;
}

@end
