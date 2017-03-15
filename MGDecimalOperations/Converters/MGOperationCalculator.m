#import "MGOperationCalculator.h"
#import "MGOperationObjectProtocol.h"
#import "MGOperatorProtocol.h"
#import "MGVariable.h"
#import "MGOpenBracket.h"
#import "MGCloseBracket.h"

@implementation MGOperationCalculator

- (NSArray *)postfixExpressionWithSeparatedObjects:(NSArray *)separatedObjects
{
    NSMutableArray *operationObjects = [[NSMutableArray alloc] initWithArray:separatedObjects];
    NSMutableArray *stack = [NSMutableArray new];
    NSMutableArray *output = [NSMutableArray new];
    NSUInteger operationObjectsCount = operationObjects.count;

    for (int i = 0; i < operationObjectsCount; i++) {
        id <MGOperationObjectProtocol> operationObject = operationObjects.firstObject;
        [operationObjects removeObjectAtIndex:0];
        if ([operationObject isKindOfClass:[MGVariable class]]) {
            [output addObject:operationObject];
        } else if ([operationObject isKindOfClass:[MGOpenBracket class]]) {
            [stack addObject:operationObject];
        } else if ([operationObject isKindOfClass:[MGCloseBracket class]]) {
            while (true) {
                id <MGNonValueObjectProtocol> fromStack = stack.lastObject;
                [stack removeLastObject];
                if ([fromStack isKindOfClass:[MGOpenBracket class]]) break;
                [output addObject:fromStack];
            }
        } else if ([stack.lastObject conformsToProtocol:@protocol(MGOperatorProtocol)]) {
            id <MGOperatorProtocol> stackOperator = stack.lastObject;
            id <MGOperatorProtocol> currentOperator = (id <MGOperatorProtocol>) operationObject;
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
        id <MGOperationObjectProtocol> operationObject = [stack lastObject];
        [stack removeLastObject];
        [output addObject:operationObject];
    }
    return output.copy;
}

- (MGVariable *)evaluatedResultWithPostfixArray:(NSArray *)postfixArray variablesDictionary:(NSDictionary *)variables
{
    NSMutableArray *startPostfixArray = [postfixArray mutableCopy];
    NSMutableArray *stack = [NSMutableArray new];
    NSUInteger postfixArrayLength = postfixArray.count;

    for (int i = 0; i < postfixArrayLength; i++) {
        id <MGOperationObjectProtocol> operationObject = [startPostfixArray firstObject];
        [startPostfixArray removeObjectAtIndex:0];
        if ([operationObject isKindOfClass:[MGVariable class]]) {
            [stack addObject:operationObject];
        } else {
            id <MGOperatorProtocol> operator = (id <MGOperatorProtocol>) operationObject;
            MGVariable *secondVariable = [stack lastObject];
            [stack removeLastObject];
            MGVariable *firstVariable = [stack lastObject];
            [stack removeLastObject];
            if (firstVariable.value == nil) firstVariable.value = variables[firstVariable.symbol];
            if (secondVariable.value == nil) secondVariable.value = variables[secondVariable.symbol];
            MGVariable *result = [operator makeOperationWithFirstArgument:firstVariable secondArgument:secondVariable];
            [stack addObject:result];
        }
    }
    return [stack lastObject];
}

@end
