#import <Foundation/Foundation.h>
#import "MGNonValueObjectProtocol.h"

@class MGVariable;

@interface MGOpenBracket : NSObject <MGNonValueObjectProtocol>

@property (nonatomic, strong) NSString *symbol;

@end
