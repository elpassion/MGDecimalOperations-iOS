//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Variable;

@interface OperationCalculator : NSObject

- (NSArray *)postfixExpressionWithSeparatedObjects:(NSArray *)separatedObjects;
- (Variable *)evaluatedResultWithPostfixArray:(NSArray *)postfixArray variablesDictionary:(NSDictionary *)variables;

@end
