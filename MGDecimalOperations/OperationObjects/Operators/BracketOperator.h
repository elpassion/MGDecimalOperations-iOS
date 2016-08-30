//
// Created by Maciej Gomółka on 30.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperatorProtocol.h"

@class Variable;

@interface BracketOperator : NSObject <OperatorProtocol>

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) NSInteger priority;

- (instancetype)initWithSymbol:(NSString *)symbol;

- (Variable *)makeOperationWithFirstArgument:(Variable *)firstArgument SecondArgument:(Variable *)secondArgument;

@end
