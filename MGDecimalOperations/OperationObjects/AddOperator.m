#import "AddOperator.h"
#import "Variable.h"

@implementation AddOperator

- (instancetype)init
{
    if (self = [super init]) {
        _priority = 1;
        _symbol = @"+";
    }
    return self;
}

- (Variable *)makeOperationWithFirstArgument:(Variable *)firstArgument secondArgument:(Variable *)secondArgument
{
    Variable *result = [[Variable alloc] initWithSymbol:@"" value:@"0"];
    result.value = [firstArgument.value decimalNumberByAdding:secondArgument.value];
    return result;
}

@end
