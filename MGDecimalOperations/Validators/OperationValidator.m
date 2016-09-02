//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "OperationValidator.h"
#import "ErrorFactory.h"
#import "FailedObject.h"
#import "OperatorProtocol.h"
#import "BracketOperator.h"
#import "Variable.h"

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
    } else if ([self isRightNumberOfOperatorsAndVariables:operation]) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Numbers not separated by operator"];
    }
}

- (void)validateOperationWithSeparatedObjects:(NSArray *)separatedObjects variables:(NSDictionary *)variables error:(NSError **)error
{
    if ([self isSeparatedObjectArrayContainFailedObject:separatedObjects]) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Operation contain forbidden variables name or operations"];
    } else if (![self isCurrentAndPreviousObjectsCanBeNeighbours:separatedObjects]) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Operator next to operator"];
    }else if(![self isDictionaryContainSeparatedObjects:separatedObjects variables:variables]) {
        *error = [self.errorFactory errorWithMessage:@"Dictionary doesn't contain all variables"];
    }
}

- (BOOL)isDictionaryContainSeparatedObjects:(NSArray *)separatedObjects variables:(NSDictionary *)variables
{
    for(NSUInteger i = 0; i < separatedObjects.count; i++){
        id <OperationObjectProtocol> object = separatedObjects[i];
        if ([object isKindOfClass:[Variable class]]){
            Variable *variable = (Variable *)object;
            NSDecimalNumber *value = variables[variable.symbol];
            if (value == nil){
                return false;
            }
        }
    }
    return true;
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

- (BOOL)isRightNumberOfOperatorsAndVariables:(NSString *)operation
{
    NSString *operationWithoutBrackets = [[operation stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSPredicate *noEmptyString = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@" -+*/"];
    NSArray *operationInParts = [operationWithoutBrackets componentsSeparatedByCharactersInSet:characterSet];
    NSArray *filteredArray = [operationInParts filteredArrayUsingPredicate:noEmptyString];

    NSUInteger numberOfVariables = filteredArray.count;
    NSUInteger numberOfOperators = [self numberOfOperatorsWithOperation:operation];

    return numberOfOperators != numberOfVariables-1;
}

-(NSUInteger)numberOfOperatorsWithOperation:(NSString *)operation
{
    NSUInteger numberOfOperators = 0;
    for (NSUInteger i = 0; i < operation.length; i++){
        UniChar character = [operation characterAtIndex:i];
        if(character == '+' || character == '-' || character == '*' || character == '/'){
            numberOfOperators++;
        }
    }
    return numberOfOperators;
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
