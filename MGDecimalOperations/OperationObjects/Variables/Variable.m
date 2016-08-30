//
// Created by Maciej Gomółka on 26.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "Variable.h"

@implementation Variable

- (instancetype)initWithSymbol:(NSString *)symbol
{
    if (self = [super init]) {
        _symbol = symbol;
    }
    return self;
}

- (instancetype)initWithSymbol:(NSString *)symbol value:(NSString *)value
{
    if (self = [super init]) {
        _symbol = symbol;
        _value = [[NSDecimalNumber alloc] initWithString:value];
    }
    return self;
}

- (void)setVariableValueWithVariables:(NSDictionary *)variables
{
    self.value = variables[self.symbol];
}

- (BOOL)isValueSet
{
    return self.value != nil;
}

@end
