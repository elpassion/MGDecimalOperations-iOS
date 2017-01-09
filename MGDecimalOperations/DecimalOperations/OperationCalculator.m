//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "OperationCalculator.h"
#import "OperationObjectProtocol.h"
#import "OperatorProtocol.h"
#import "Variable.h"
#import "OpenBracket.h"
#import "CloseBracket.h"

@implementation OperationCalculator

- (NSArray *)postfixExpressionWithSeparatedObjects:(NSArray *)separatedObjects
{
    NSMutableArray *operationObjects = [[NSMutableArray alloc] initWithArray:separatedObjects];
    NSMutableArray *stack = [NSMutableArray new];
    NSMutableArray *output = [NSMutableArray new];
    NSUInteger operationObjectsCount = operationObjects.count;

    for (int i = 0; i < operationObjectsCount; i++) {
        id <OperationObjectProtocol> operationObject = operationObjects.firstObject;
        [operationObjects removeObjectAtIndex:0];
        if ([operationObject isKindOfClass:[Variable class]]) {
            [output addObject:operationObject];
        }else if ([operationObject isKindOfClass:[OpenBracket class]]) {
            [stack addObject:operationObject];
        } else if ([operationObject isKindOfClass:[CloseBracket class]]) {
            while (true) {
                id <NonValueObjectProtocol> fromStack = stack.lastObject;
                [stack removeLastObject];
                if ([fromStack isKindOfClass:[OpenBracket class]]) break;
                [output addObject:fromStack];
            }
        } else if ([stack.lastObject conformsToProtocol:@protocol(OperatorProtocol)]) {
            id <OperatorProtocol> stackOperator = stack.lastObject;
            id <OperatorProtocol> currentOperator = (id <OperatorProtocol>) operationObject;
            if (stackOperator.priority >= currentOperator.priority && stack.count > 0) {
                [stack removeLastObject];
                [output addObject:stackOperator];
            }
            [stack addObject:operationObject];
        } else {
            [stack addObject:operationObject];
        }
    }

    NSUInteger stackLength = stack.count;
    for (int i = 0; i < stackLength; i++) {
        id <OperationObjectProtocol> operationObject = [stack lastObject];
        [stack removeLastObject];
        [output addObject:operationObject];
    }
    return output.copy;
}

- (Variable *)evaluatedResultWithPostfixArray:(NSArray *)postfixArray variablesDictionary:(NSDictionary *)variables
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
            if ([firstVariable isValueSet] == false) [firstVariable setVariableValueWithVariables:variables];
            if ([secondVariable isValueSet] == false) [secondVariable setVariableValueWithVariables:variables];
            Variable *result = [operator makeOperationWithFirstArgument:firstVariable SecondArgument:secondVariable];
            [stack addObject:result];
        }
    }
    return [stack lastObject];
}

@end
