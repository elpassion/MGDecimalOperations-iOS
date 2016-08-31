//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OperationObjectProtocol;

@interface OperationConverter : NSObject

- (NSArray *)separatedObjectsWithString:(NSString *)operation;
- (id <OperationObjectProtocol>)operationObjectWithString:(NSString *)operation currentPositionInString:(NSUInteger)currentPosition;

@end
