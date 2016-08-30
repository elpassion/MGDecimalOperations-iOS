//
// Created by Maciej Gomółka on 24.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "DecimalOperations.h"
#import "DecimalConverter.h"
#import "OperatorFactory.h"
#import "Variable.h"
#import "OperatorProtocol.h"

@interface DecimalOperations ()

@property (nonatomic, strong) DecimalConverter *decimalsConverter;
@property (nonatomic, strong) OperatorFactory *operatorFactory;

@end

@implementation DecimalOperations

- (instancetype)init
{
    if (self = [super init]) {
        _decimalsConverter = [DecimalConverter new];
        _operatorFactory = [OperatorFactory new];
    }
    return self;
}

- (NSDecimalNumber *)mathWithOperation:(NSString *)operation variablesString:(NSDictionary *)variables error:(NSError **)error
{
    NSDictionary *convertedVariables = [[self decimalsConverter] decimalVariablesFromStringVariables:variables error:error];
    return [self mathWithOperation:operation variablesDecimal:convertedVariables error:error];
}

- (NSDecimalNumber *)mathWithOperation:(NSString *)operation variablesDecimal:(NSDictionary *)variables error:(NSError **)error
{
    NSArray *separatedObjects = [self getSeparatedObjectsWithString:operation];
    NSArray *postfix = [self getPostfixExpressionWithSeparatedObjects:separatedObjects];
    Variable *resultVariable = [self getEvaluatedResultWithPostfixArray:postfix variablesDictionary:variables];
    return [resultVariable value];
}

- (NSArray *)getPostfixExpressionWithSeparatedObjects:(NSArray *)separatedObjects
{
    NSMutableArray *startArray = [[NSMutableArray alloc] initWithArray:separatedObjects];
    NSMutableArray *stack = [NSMutableArray new];
    NSMutableArray *output = [NSMutableArray new];
    NSUInteger startArrayLength = startArray.count;

    for (int i = 0; i < startArrayLength; i++) {
        id <OperationObjectProtocol> operationObject = [startArray firstObject];
        [startArray removeObjectAtIndex:0];
        if ([operationObject isKindOfClass:[Variable class]]) {
            [output addObject:operationObject];
            continue;
        }
        id <OperatorProtocol> operator = (id <OperatorProtocol>) operationObject;
        if ([[operator symbol] isEqualToString:@"("]) {
            [stack addObject:operator];
        } else if ([[operator symbol] isEqualToString:@")"]) {
            while (true) {
                id <OperatorProtocol> fromStack = [stack lastObject];
                [stack removeLastObject];
                if ([[fromStack symbol] isEqualToString:@"("]) break;
                [output addObject:fromStack];
            }
        } else {
            id <OperatorProtocol> stackOperator = [stack lastObject];
            if (stackOperator.priority >= operator.priority && ![[stackOperator symbol] isEqualToString:@"("] && stack.count > 0) {
                [stack removeLastObject];
                [output addObject:stackOperator];
            }
            [stack addObject:operator];
        }
    }

    NSUInteger stackLength = stack.count;
    for (int i = 0; i < stackLength; i++) {
        id <OperationObjectProtocol> operationObject = [stack lastObject];
        [stack removeLastObject];
        [output addObject:operationObject];
    }
    return output;
}

- (Variable *)getEvaluatedResultWithPostfixArray:(NSArray *)postfixArray variablesDictionary:(NSDictionary *)variables
{
    NSMutableArray *startPostfixArray = [postfixArray mutableCopy];
    NSMutableArray *stack = [NSMutableArray new];
    NSUInteger postfixArrayLength = postfixArray.count;

    for (int i = 0; i < postfixArrayLength; i++) {
        id <OperationObjectProtocol> operationObject = [startPostfixArray firstObject];
        [startPostfixArray removeObjectAtIndex:0];
        if ([operationObject isKindOfClass:[Variable class]]) {
            [stack addObject:operationObject];
        } else {
            id <OperatorProtocol> operator = (id <OperatorProtocol>) operationObject;
            Variable *secondVariable = [stack lastObject];
            [stack removeLastObject];
            Variable *firstVariable = [stack lastObject];
            [stack removeLastObject];
            if (![firstVariable isValueSet]) [firstVariable setVariableValueWithVariables:variables];
            if (![secondVariable isValueSet]) [secondVariable setVariableValueWithVariables:variables];
            Variable *result = [operator makeOperationWithFirstArgument:firstVariable SecondArgument:secondVariable];
            [stack addObject:result];
        }
    }
    return [stack lastObject];
}

- (NSArray *)getSeparatedObjectsWithString:(NSString *)operation
{
    NSString *operationWithoutSpaces = [operation stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger currentPositionInString = 0;
    NSUInteger operationLength = operationWithoutSpaces.length;
    id <OperationObjectProtocol> currentObject;
    NSArray *resultArr = [NSArray new];

    while (currentPositionInString < operationLength) {
        currentObject = [self getOperationObjectWithString:operationWithoutSpaces currentPositionInString:currentPositionInString];
        resultArr = [resultArr arrayByAddingObject:currentObject];
        currentPositionInString += currentObject.symbol.length;
    }
    return resultArr;
}

- (id <OperationObjectProtocol>)getOperationObjectWithString:(NSString *)operation currentPositionInString:(NSUInteger)currentPosition
{
    NSString *object = @"";
    BOOL isNumberInObject = false;

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
            isNumberInObject = true;
            object = [object stringByAppendingFormat:@"%c", character];
            currentPosition++;
            continue;
        }
        return nil;
    }
    return [[Variable alloc] initWithSymbol:object];
}

@end
