#import "OperatorFactory.h"
#import "SubtractOperator.h"
#import "MultiplyOperator.h"
#import "DivideOperator.h"
#import "OpenBracket.h"
#import "AddOperator.h"
#import "CloseBracket.h"

@implementation OperatorFactory

- (id <OperationObjectProtocol>)operatorWithCharacter:(UniChar)operatorSymbol
{
    switch (operatorSymbol) {
        case '+':
            return [[AddOperator alloc] init];
        case '-':
            return [[SubtractOperator alloc] init];
        case '*':
            return [[MultiplyOperator alloc] init];
        case '/':
            return [[DivideOperator alloc] init];
        case '(':
            return [OpenBracket new];
        case ')':
            return [CloseBracket new];
        default:
            return nil;
    }
}

@end
