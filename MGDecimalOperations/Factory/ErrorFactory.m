#import "ErrorFactory.h"

@implementation ErrorFactory

- (NSError *)errorWithMessage:(NSString *)errorMessage
{
    NSMutableDictionary *details = [NSMutableDictionary new];
    details[NSLocalizedDescriptionKey] = errorMessage;
    return [NSError errorWithDomain:@"MGDecimalOperations" code:1 userInfo:[details copy]];
}

@end
