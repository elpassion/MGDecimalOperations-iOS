#import "MGDivideOperator.h"
#import "MGVariable.h"

@implementation MGDivideOperator

- (instancetype)init
{
    if (self = [super init]) {
        _priority = 2;
        _symbol = @"/";
    }
    return self;
}

- (MGVariable *)makeOperationWithFirstArgument:(MGVariable *)firstArgument secondArgument:(MGVariable *)secondArgument
{
    MGVariable *result = [[MGVariable alloc] initWithSymbol:@"" value:@"0"];
    result.value = [firstArgument.value decimalNumberByDividingBy:secondArgument.value];
    return result;
}

@end
