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
        NSString *number = variables[key];
        if ([self isCorrectNumber:number]) {
            NSDecimalNumber *decimalNumber = [self decimalNumberFromString:number];
            decimalVariables[key] = decimalNumber;
        } else {
            *error = [self.errorFactory errorWithMessage:@"Argument not a number"];
            return nil;
        }
    }
    return decimalVariables;
}

- (NSDecimalNumber *)decimalNumberFromString:(NSString *)string
{
    return [[NSDecimalNumber alloc] initWithString:string];
}

- (BOOL)isCorrectNumber:(NSString *)variable
{
    NSUInteger dotNumber = 0;
    for (NSUInteger i = 0; i < variable.length; i++) {
        UniChar character = [variable characterAtIndex:i];
        if (character == 46) dotNumber++;
        if ((character < 48 || character > 57) && character != 46) return NO;
    }
    return dotNumber <= 1;
}

@end
