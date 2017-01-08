//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "OperationCalculator.h"
#import "OperationObjectProtocol.h"
#import "OperatorProtocol.h"
#import "Variable.h"

@implementation OperationCalculator

- (NSArray *)postfixExpressionWithSeparatedObjects:(NSArray *)separatedObjects
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
