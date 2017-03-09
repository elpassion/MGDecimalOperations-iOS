#import <Foundation/Foundation.h>

@class MGErrorFactory;

@interface MGDecimalConverter : NSObject

- (instancetype)initWithErrorFactory:(MGErrorFactory *)errorFactory;

- (NSDictionary *)decimalVariablesFromStringVariables:(NSDictionary *)variables error:(NSError **)error;
- (BOOL)isCorrectNumber:(NSString *)variable;

@end
