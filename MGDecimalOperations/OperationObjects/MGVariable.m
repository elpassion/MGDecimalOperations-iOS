#import "MGVariable.h"

@implementation MGVariable

- (instancetype)initWithSymbol:(NSString *)symbol
{
    if (self = [super init]) {
        _symbol = symbol;
    }
    return self;
}

- (instancetype)initWithSymbol:(NSString *)symbol value:(NSString *)value
{
    if (self = [super init]) {
        _symbol = symbol;
        _value = [[NSDecimalNumber alloc] initWithString:value];
    }
    return self;
}

@end
