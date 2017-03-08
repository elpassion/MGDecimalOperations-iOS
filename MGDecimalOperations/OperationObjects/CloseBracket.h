#import <Foundation/Foundation.h>
#import "NonValueObjectProtocol.h"

@interface CloseBracket : NSObject <NonValueObjectProtocol>

@property (nonatomic, strong) NSString *symbol;

@end