#import "MGMultiplyOperator.h"
#import "MGVariable.h"

@implementation MGMultiplyOperator

- (instancetype)init
{
    if (self = [super init]) {
        _priority = 2;
        _symbol = @"*";
    }
    return self;
}

- (MGVariable *)makeOperationWithFirstArgument:(MGVariable *)firstArgument secondArgument:(MGVariable *)secondArgument
{
    MGVariable *result = [[MGVariable alloc] initWithSymbol:@"" value:@"0"];
    result.value = [firstArgument.value decimalNumberByMultiplyingBy:secondArgument.value];
    return result;
}

@end
