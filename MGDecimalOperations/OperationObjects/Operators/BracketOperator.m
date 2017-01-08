//
// Created by Maciej Gomółka on 30.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "BracketOperator.h"

@implementation BracketOperator

- (instancetype)initWithSymbol:(NSString *)symbol
{
    if (self = [super init]) {
        _symbol = symbol;
    }
    return self;
}

@end
