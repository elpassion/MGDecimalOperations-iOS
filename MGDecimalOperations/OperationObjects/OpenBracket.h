#import <Foundation/Foundation.h>
#import "NonValueObjectProtocol.h"

@class Variable;

@interface OpenBracket : NSObject <NonValueObjectProtocol>

@property (nonatomic, strong) NSString *symbol;

@end
