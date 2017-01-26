#import <Foundation/Foundation.h>

@class ErrorFactory;

@interface DecimalConverter : NSObject

- (instancetype)initWithErrorFactory:(ErrorFactory *)errorFactory;

- (NSMutableDictionary *)decimalVariablesFromStringVariables:(NSDictionary *)variables error:(NSError **)error;
- (BOOL)isCorrectNumber:(NSString *)variable;

@end
