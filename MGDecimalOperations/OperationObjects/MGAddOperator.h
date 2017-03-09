#import <Foundation/Foundation.h>
#import "MGOperatorProtocol.h"

@interface MGAddOperator : NSObject <MGOperatorProtocol>

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) NSUInteger priority;

@end
