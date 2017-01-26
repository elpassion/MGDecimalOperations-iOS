#import <Foundation/Foundation.h>

@interface ErrorFactory : NSObject

- (NSError *)errorWithMessage:(NSString *)errorMessage;

@end
