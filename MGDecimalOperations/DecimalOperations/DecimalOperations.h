//
// Created by Maciej Gomółka on 24.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationObjectProtocol.h"

@class Variable;

@interface DecimalOperations : NSObject

- (NSDecimalNumber *)mathWithOperation:(NSString *)operation variablesString:(NSDictionary *)variables error:(NSError **)error;
- (NSDecimalNumber *)mathWithOperation:(NSString *)operation variablesDecimal:(NSDictionary *)variables error:(NSError **)error;
- (NSArray *)getPostfixExpressionWithSeparatedObjects:(NSArray *)separatedObjects;
- (NSArray *)getSeparatedObjectsWithString:(NSString *)operation;
- (id <OperationObjectProtocol>)getOperationObjectWithString:(NSString *)operation currentPositionInString:(NSUInteger)currentPosition;

@end