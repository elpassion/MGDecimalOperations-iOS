#import "MGSubtractOperator.h"
#import "MGVariable.h"

@implementation MGSubtractOperator

- (instancetype)init
{
    if (self = [super init]) {
        _priority = 1;
        _symbol = @"-";
    }
    return self;
}

- (MGVariable *)makeOperationWithFirstArgument:(MGVariable *)firstArgument secondArgument:(MGVariable *)secondArgument
{
    MGVariable *result = [[MGVariable alloc] initWithSymbol:@"" value:@"0"];
    result.value = [firstArgument.value decimalNumberBySubtracting:secondArgument.value];
    return result;
}

@end
