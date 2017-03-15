#import "MGOperatorFactory.h"
#import "MGSubtractOperator.h"
#import "MGMultiplyOperator.h"
#import "MGDivideOperator.h"
#import "MGOpenBracket.h"
#import "MGNonValueObjectProtocol.h"
#import "MGAddOperator.h"
#import "MGCloseBracket.h"

@implementation MGOperatorFactory

- (id <MGNonValueObjectProtocol>)operatorWithCharacter:(UniChar)operatorSymbol
{
    NSString *key = [NSString stringWithFormat:@"%c", operatorSymbol];
    return self.operatorsDict[key] ?: nil;
}

- (NSDictionary *)operatorsDict
{
    return @{
            @"+": [MGAddOperator new],
            @"-": [MGSubtractOperator new],
            @"*": [MGMultiplyOperator new],
            @"/": [MGDivideOperator new],
            @"(": [MGOpenBracket new],
            @")": [MGCloseBracket new]
    };
}

@end
