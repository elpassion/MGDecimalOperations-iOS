#import <Foundation/Foundation.h>

@class Variable;

/**
 *  The 'MGDecimalOperationsCalculator' class is responsible for execution 
 *  operations on NSDecimalNumbers wrote in String.
 */

@interface MGDecimalOperationsCalculator : NSObject

/**
 *  This is method for calculate operations wrote in String. 
 *  In this method you provide to the variables parameter NSDictionary
 *  contains keys with name of variables and numbers wrote in String that
 *  will be converted to NSDecimalNumbers.
 *
 *  @param operation is operation wrote in String
 *  @param variables is NSDictionary where the key is name of variable that represent your number in String operation
 *                   and value is number in String that will be converted to the NSDecimalNumber.
 *  @param error     is NSError. Before you call this method you need to create NSError pointer that you pass.
 *                   When error occurs this variable will describe problem.
 *
 *  @return NSDecimalNumber that is result of operation wrote in operation parameter
 *  @code
 *  NSDictionary *variables = @{
 *    @"a": "1"],
 *    @"b": "2"]
 *  };
 *  NSString *operation = @"a + b"
 *
 *  NSDecimalNumber *result = [deciamlOperations mathWithOperation:operation
 *                                                 variablesString:variables
 *                                                           error:&error];
 */

- (nullable NSDecimalNumber *)mathWithOperation:(NSString * _Nonnull)operation
                                variablesString:(NSDictionary * _Nonnull)variables
                                          error:(NSError * _Nullable * _Nullable)error;

/**
 *  This is method for calculation operations wrote in String.
 *  In this method you provide to the variables parameter NSDictionary
 *  contains keys with name of variables and NSDecimalNumbers
 *
 *  @param operation is operation wrote in String
 *  @param variables is NSDictionary where the key is name of variable that represent
 *                   your number in String operation and value is NSDecimalNumber.
 *  @param error     is NSError. Before you call this method you need to create NSError
 *                   pointer that you pass. When error occurs this variable will describe problem.
 *
 *  @return NSDecimalNumber that is result of operation wrote in operation parameter
 *  @code
 *  NSDictionary *variables = @{
 *    @"a": [NSDecimalNumber decimalNumberWithString:@"1"],
 *    @"b": [NSDecimalNumber decimalNumberWithString:@"2"]
 *  };
 *  NSString *operation = @"a + b"
 *
 *  NSDecimalNumber *result = [deciamlOperations mathWithOperation:operation
 *                                                variablesDecimal:variables
 *                                                           error:&error];
 */

- (nullable NSDecimalNumber *)mathWithOperation:(NSString * _Nonnull)operation
                               variablesDecimal:(NSDictionary * _Nonnull)variables
                                          error:(NSError * _Nullable * _Nullable)error;

@end
