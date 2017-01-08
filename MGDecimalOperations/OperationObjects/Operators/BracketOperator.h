//
// Created by Maciej Gomółka on 30.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BracketProtocol.h"

@class Variable;

@interface BracketOperator : NSObject <BracketProtocol>

@property (nonatomic, strong) NSString *symbol;

- (instancetype)initWithSymbol:(NSString *)symbol;

@end
