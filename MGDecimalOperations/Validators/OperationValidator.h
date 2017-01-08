//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationValidator : NSObject

- (void)validateOperationWithString:(NSString *)operation error:(NSError **)error;
- (void)validateOperationWithSeparatedObjects:(NSArray *)separatedObjects variables:(NSDictionary *)variables error:(NSError **)error;

- (BOOL)isNumberOfCloseAndOpenBracketsEqual:(NSString *)operation;
- (BOOL)isCorrectNumberOfOperatorsAndVariables:(NSString *)operation;
- (BOOL)areCurrentAndPreviousObjectsCanBeNeighbours:(NSArray *)separatedObjects;

@end