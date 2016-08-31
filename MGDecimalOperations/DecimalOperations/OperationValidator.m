//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "OperationValidator.h"
#import "ErrorFactory.h"
#import "FailedObject.h"
#import "OperatorProtocol.h"
#import "BracketOperator.h"

@interface OperationValidator ()

@property (nonatomic, strong) ErrorFactory *errorFactory;

@end

@implementation OperationValidator

- (instancetype)init
{
    if (self = [super init]) {
        _errorFactory = [ErrorFactory new];
    }
    return self;
}

- (void)validateOperationWithString:(NSString *)operation error:(NSError **)error
{
    if (![self isNumberOfCloseAndOpenBracketThisSame:operation]) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Different number of open and close brackets"];
    } else if ([self isVariableNeighbourForVariable:operation]) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Numbers not separated by operator"];
    }
}

- (void)validateOperationWithSeparatedObjects:(NSArray *)separatedObjects error:(NSError **)error
{
    if ([self isSeparatedObjectArrayContainFailedObject:separatedObjects]) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Operation contain forbidden variables name or operations"];
    } else if (![self isCurrentAndPreviousObjectsCanBeNeighbours:separatedObjects]) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Operator next to operator"];
    }
}

- (BOOL)isNumberOfCloseAndOpenBracketThisSame:(NSString *)operation
{
    NSUInteger open = 0;
    NSUInteger close = 0;

    for (NSUInteger i = 0; i < operation.length; i++) {
        UniChar character = [operation characterAtIndex:i];
        if (character == '(') open++;
        if (character == ')') close++;
    }
    return (open == close);
}

- (BOOL)isVariableNeighbourForVariable:(NSString *)operation
{
    NSString *operationWithoutBrackets = [[operation stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSPredicate *noEmptyString = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSArray *operationInParts = [operationWithoutBrackets componentsSeparatedByString:@" "];
    NSArray *filteredArray = [operationInParts filteredArrayUsingPredicate:noEmptyString];

    BOOL isVariable = NO;

    for (NSUInteger i = 0; i < filteredArray.count; i++) {
        UniChar character = [filteredArray[i] characterAtIndex:0];
        if (!(character >= 42 && character <= 47 && character != 44)) {
            if (isVariable) return YES;
            isVariable = YES;
        } else {
            isVariable = NO;
        }
    }
    return NO;
}

- (BOOL)isSeparatedObjectArrayContainFailedObject:(NSArray *)separatedObjects
{
    for (NSUInteger i = 0; i < separatedObjects.count; i++) {
        id <OperationObjectProtocol> object = separatedObjects[i];
        if ([object isKindOfClass:[FailedObject class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isCurrentAndPreviousObjectsCanBeNeighbours:(NSArray *)separatedObjects
{
    for (NSUInteger i = 1; i < separatedObjects.count; i++) {
        id <OperationObjectProtocol> current = separatedObjects[i];
        id <OperationObjectProtocol> previous = separatedObjects[i - 1];

        if ([current class] == [BracketOperator class] || [previous class] == [BracketOperator class]) return YES;
        if ([current conformsToProtocol:@protocol(OperatorProtocol)] && [previous conformsToProtocol:@protocol(OperatorProtocol)]) return NO;
    }
    return YES;
}

@end
