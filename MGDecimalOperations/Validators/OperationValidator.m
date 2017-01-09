//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "OperationValidator.h"
#import "ErrorFactory.h"
#import "OperatorProtocol.h"
#import "OpenBracket.h"
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
    if ([self isNumberOfCloseAndOpenBracketsEqual:operation] == false) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Different number of open and close brackets"];
    } else if ([self isCorrectNumberOfOperatorsAndVariables:operation] == false) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Numbers not separated by operator"];
    }
}

- (void)validateOperationWithSeparatedObjects:(NSArray *)separatedObjects variables:(NSDictionary *)variables error:(NSError **)error
{
    if ([self areCurrentAndPreviousObjectsCanBeNeighbours:separatedObjects] == false) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Operator next to operator"];
    }else if([self isDictionaryContainSeparatedObjects:separatedObjects variables:variables] == false) {
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

- (BOOL)isNumberOfCloseAndOpenBracketsEqual:(NSString *)operation
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

- (BOOL)isCorrectNumberOfOperatorsAndVariables:(NSString *)operation
{
    NSString *operationWithoutBrackets = [[operation stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@" -+*/"];
    NSArray *operationInParts = [operationWithoutBrackets componentsSeparatedByCharactersInSet:characterSet];
    NSPredicate *noEmptyString = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSArray *filteredArray = [operationInParts filteredArrayUsingPredicate:noEmptyString];

    NSUInteger numberOfVariables = filteredArray.count;
    NSUInteger numberOfOperators = [self numberOfOperatorsWithOperation:operation];
    return numberOfOperators == numberOfVariables-1;
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

- (BOOL)areCurrentAndPreviousObjectsCanBeNeighbours:(NSArray *)separatedObjects
{
    for (NSUInteger i = 1; i < separatedObjects.count; i++) {
        id <OperationObjectProtocol> current = separatedObjects[i];
        id <OperationObjectProtocol> previous = separatedObjects[i - 1];

        if ([current class] == [OpenBracket class] || [previous class] == [OpenBracket class]) return YES;
        if ([current conformsToProtocol:@protocol(OperatorProtocol)] && [previous conformsToProtocol:@protocol(OperatorProtocol)]) return NO;
    }
    return YES;
}

@end
