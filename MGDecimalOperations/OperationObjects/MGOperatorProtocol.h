#import <Foundation/Foundation.h>
#import "MGOperationObjectProtocol.h"
#import "MGNonValueObjectProtocol.h"

@class MGVariable;

@protocol MGOperatorProtocol <NSObject, MGOperationObjectProtocol, MGNonValueObjectProtocol>

@property (nonatomic) NSUInteger priority;

- (MGVariable *)makeOperationWithFirstArgument:(MGVariable *)firstArgument secondArgument:(MGVariable *)secondArgument;

@end
