//
// Created by Maciej Gomółka on 26.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationObjectProtocol.h"

@interface Variable : NSObject <OperationObjectProtocol>

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSDecimalNumber *value;

- (instancetype)initWithSymbol:(NSString *)symbol;
- (instancetype)initWithSymbol:(NSString *)symbol value:(NSString *)value;

- (BOOL)isValueSet;

- (void)setVariableValueWithVariables:(NSDictionary *)variables;

@end
