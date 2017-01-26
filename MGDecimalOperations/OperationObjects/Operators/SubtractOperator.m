#import "SubtractOperator.h"
#import "Variable.h"

@implementation SubtractOperator

- (instancetype)init
{
    if (self = [super init]) {
        _priority = 1;
        _symbol = @"-";
    }
    return self;
}

- (Variable *)makeOperationWithFirstArgument:(Variable *)firstArgument SecondArgument:(Variable *)secondArgument
{
    Variable *result = [[Variable alloc] initWithSymbol:@"" value:@"0"];
    result.value = [firstArgument.value decimalNumberBySubtracting:secondArgument.value];
    return result;
}

@end
