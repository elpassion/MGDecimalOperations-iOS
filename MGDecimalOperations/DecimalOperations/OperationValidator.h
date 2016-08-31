//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationValidator : NSObject

- (void)validateOperationWithString:(NSString *)operation error:(NSError **)error;
- (void)validateOperationWithSeparatedObjects:(NSArray *)separatedObjects error:(NSError **)error;

- (BOOL)isNumberOfCloseAndOpenBracketThisSame:(NSString *)operation;
- (BOOL)isVariableNeighbourForVariable:(NSString *)operation;
- (BOOL)isSeparatedObjectArrayContainFailedObject:(NSArray *)separatedObjects;
- (BOOL)isCurrentAndPreviousObjectsCanBeNeighbours:(NSArray *)separatedObjects;

@end
