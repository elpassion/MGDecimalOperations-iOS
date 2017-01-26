#import <Foundation/Foundation.h>
#import "OperationObjectProtocol.h"

@interface Variable : NSObject <OperationObjectProtocol>

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSDecimalNumber *value;

- (instancetype)initWithSymbol:(NSString *)symbol;
- (instancetype)initWithSymbol:(NSString *)symbol value:(NSString *)value;

@end
