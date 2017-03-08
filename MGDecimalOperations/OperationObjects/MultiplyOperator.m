#import "MultiplyOperator.h"
#import "Variable.h"

@implementation MultiplyOperator

- (instancetype)init
{
    if (self = [super init]) {
        _priority = 2;
        _symbol = @"*";
    }
    return self;
}

- (Variable *)makeOperationWithFirstArgument:(Variable *)firstArgument secondArgument:(Variable *)secondArgument
{
    Variable *result = [[Variable alloc] initWithSymbol:@"" value:@"0"];
    result.value = [firstArgument.value decimalNumberByMultiplyingBy:secondArgument.value];
    return result;
}

@end
