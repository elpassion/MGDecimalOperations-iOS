#import <Foundation/Foundation.h>

@protocol OperationObjectProtocol;

@interface OperatorFactory : NSObject

- (id <OperationObjectProtocol>)operatorWithCharacter:(UniChar)operatorSymbol;

@end
