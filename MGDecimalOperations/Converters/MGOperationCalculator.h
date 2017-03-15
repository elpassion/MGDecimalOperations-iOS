#import <Foundation/Foundation.h>

@class MGVariable;

@interface MGOperationCalculator : NSObject

- (NSArray *)postfixExpressionWithSeparatedObjects:(NSArray *)separatedObjects;
- (MGVariable *)evaluatedResultWithPostfixArray:(NSArray *)postfixArray variablesDictionary:(NSDictionary *)variables;

@end
