//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "OperationConverter.h"
#import "OperatorFactory.h"
#import "Variable.h"
#import "FailedObject.h"

@interface OperationConverter ()

@property (nonatomic, strong) OperatorFactory *operatorFactory;

@end

@implementation OperationConverter

- (instancetype)init
{
    if (self = [super init]) {
        _operatorFactory = [OperatorFactory new];
    }
    return self;
}

- (NSArray *)separatedObjectsWithString:(NSString *)operation
{
    NSString *operationWithoutSpaces = [operation stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger currentPositionInString = 0;
    NSUInteger operationLength = operationWithoutSpaces.length;
    id <OperationObjectProtocol> currentObject;
    NSArray *resultArr = [NSArray new];

    while (currentPositionInString < operationLength) {
        currentObject = [self operationObjectWithString:operationWithoutSpaces currentPositionInString:currentPositionInString];
        resultArr = [resultArr arrayByAddingObject:currentObject];
        currentPositionInString += currentObject.symbol.length;
    }
    return resultArr;
}

- (id <OperationObjectProtocol>)operationObjectWithString:(NSString *)operation currentPositionInString:(NSUInteger)currentPosition
{
    NSString *object = @"";
    BOOL isNumberInObject = NO;

    while (currentPosition < operation.length) {
        UniChar character = [operation characterAtIndex:currentPosition];
        if ((character >= 40 && character <= 43) || character == 47 || character == 45) {
            if (!isNumberInObject) {
                return [self.operatorFactory getOperatorWithCharacter:character];
            } else {
                return [[Variable alloc] initWithSymbol:object];
            }
        };
        if ((character >= 65 && character <= 90) || (character >= 97 && character <= 122)) {
            isNumberInObject = YES;
            object = [object stringByAppendingFormat:@"%c", character];
            currentPosition++;
            continue;
        }
        return [[FailedObject alloc] init];
    }
    return [[Variable alloc] initWithSymbol:object];
}

@end
