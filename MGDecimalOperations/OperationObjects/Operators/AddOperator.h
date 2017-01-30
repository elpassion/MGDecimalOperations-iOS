#import <Foundation/Foundation.h>
#import "OperatorProtocol.h"

@interface AddOperator : NSObject <OperatorProtocol>

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) NSUInteger priority;

@end
