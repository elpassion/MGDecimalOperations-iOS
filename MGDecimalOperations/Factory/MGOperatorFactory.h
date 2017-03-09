#import <Foundation/Foundation.h>

@protocol MGNonValueObjectProtocol;

@interface MGOperatorFactory : NSObject

- (id <MGNonValueObjectProtocol>)operatorWithCharacter:(UniChar)operatorSymbol;

@end
