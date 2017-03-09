#import <Foundation/Foundation.h>
#import "MGOperatorProtocol.h"

@interface MGDivideOperator : NSObject <MGOperatorProtocol>

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) NSUInteger priority;

@end
