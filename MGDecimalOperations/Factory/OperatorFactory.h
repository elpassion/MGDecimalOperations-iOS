#import <Foundation/Foundation.h>

@protocol NonValueObjectProtocol;

@interface OperatorFactory : NSObject

- (id <NonValueObjectProtocol>)operatorWithCharacter:(UniChar)operatorSymbol;

@end
