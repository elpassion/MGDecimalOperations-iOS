#import "MGErrorFactory.h"

@implementation MGErrorFactory

- (NSError *)errorWithMessage:(NSString *)errorMessage
{
    NSDictionary *details = @{
            NSLocalizedDescriptionKey: errorMessage
    };
    return [NSError errorWithDomain:@"MGDecimalOperations" code:1 userInfo:details];
}

@end
