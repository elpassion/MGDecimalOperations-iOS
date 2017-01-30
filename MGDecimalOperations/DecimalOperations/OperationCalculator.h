#import <Foundation/Foundation.h>

@class Variable;

@interface OperationCalculator : NSObject

- (NSArray *)postfixExpressionWithSeparatedObjects:(NSArray *)separatedObjects;
- (Variable *)evaluatedResultWithPostfixArray:(NSArray *)postfixArray variablesDictionary:(NSDictionary *)variables;

@end
