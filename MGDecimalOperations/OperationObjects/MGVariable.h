#import <Foundation/Foundation.h>
#import "MGOperationObjectProtocol.h"

@interface MGVariable : NSObject <MGOperationObjectProtocol>

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSDecimalNumber *value;

- (instancetype)initWithSymbol:(NSString *)symbol;
- (instancetype)initWithSymbol:(NSString *)symbol value:(NSString *)value;

@end
