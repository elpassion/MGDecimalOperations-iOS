#import "MGAddOperator.h"
#import "MGVariable.h"

@implementation MGAddOperator

- (instancetype)init
{
    if (self = [super init]) {
        _priority = 1;
        _symbol = @"+";
    }
    return self;
}

- (MGVariable *)makeOperationWithFirstArgument:(MGVariable *)firstArgument secondArgument:(MGVariable *)secondArgument
{
    MGVariable *result = [[MGVariable alloc] initWithSymbol:@"" value:@"0"];
    result.value = [firstArgument.value decimalNumberByAdding:secondArgument.value];
    return result;
}

@end
