#import <Foundation/Foundation.h>
#import "OperationObjectProtocol.h"
#import "NonValueObjectProtocol.h"

@class Variable;

@protocol OperatorProtocol <NSObject, OperationObjectProtocol, NonValueObjectProtocol>

@property (nonatomic) NSInteger priority;

- (Variable *)makeOperationWithFirstArgument:(Variable *)firstArgument SecondArgument:(Variable *)secondArgument;

@end
