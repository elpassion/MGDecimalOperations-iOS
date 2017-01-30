#import "OperatorFactory.h"
#import "SubtractOperator.h"
#import "MultiplyOperator.h"
#import "DivideOperator.h"
#import "OpenBracket.h"
#import "NonValueObjectProtocol.h"
#import "AddOperator.h"
#import "CloseBracket.h"

@implementation OperatorFactory

- (id <NonValueObjectProtocol>)operatorWithCharacter:(UniChar)operatorSymbol
{
    NSString *key = [NSString stringWithFormat:@"%c", operatorSymbol];
    return self.operatorsDict[key] ?: nil;
}

- (NSDictionary *)operatorsDict
{
    return @{
            @"+": [AddOperator new],
            @"-": [SubtractOperator new],
            @"*": [MultiplyOperator new],
            @"/": [DivideOperator new],
            @"(": [OpenBracket new],
            @")": [CloseBracket new]
    };
}

@end
