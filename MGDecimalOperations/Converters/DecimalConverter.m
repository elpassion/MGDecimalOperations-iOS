#import "DecimalConverter.h"
#import "ErrorFactory.h"

@interface DecimalConverter ()

@property (nonatomic, strong) ErrorFactory *errorFactory;

@end

@implementation DecimalConverter

- (instancetype)initWithErrorFactory:(ErrorFactory *)errorFactory
{
    if (self = [super init]) {
        _errorFactory = errorFactory;
    }
    return self;
}

- (NSMutableDictionary *)decimalVariablesFromStringVariables:(NSDictionary *)variables error:(NSError **)error
{
    NSMutableDictionary *decimalVariables = [NSMutableDictionary new];
    NSArray *keys = variables.allKeys;
    for (NSUInteger i = 0; i < variables.count; i++) {
        NSString *key = keys[i];
        NSString *stringNumber = variables[key];
        if ([self isCorrectNumber:stringNumber]) {
            decimalVariables[key] = [[NSDecimalNumber alloc] initWithString:stringNumber];
        } else {
            *error = [self.errorFactory errorWithMessage:@"Argument not a number"];
            return nil;
        }
    }
    return decimalVariables;
}

- (BOOL)isCorrectNumber:(NSString *)variable
{
    NSUInteger numberOfDots = 0;
    for (NSUInteger i = 0; i < variable.length; i++) {
        UniChar character = [variable characterAtIndex:i];
        if (character == '.') {
            numberOfDots++;
        } else if ([self isOutOfRange:character]) {
            return NO;
        }
    }
    return numberOfDots <= 1;
}

- (BOOL)isOutOfRange:(UniChar)character
{
    return character < '0' || character > '9';
}

@end
