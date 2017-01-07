//
// Created by Maciej Gomółka on 24.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Variable;

/**
 *  The 'DecimalOperations' class is responsible for execution 
 *  operations on NSDecimalNumbers wrote in String.
 */

@interface DecimalOperations : NSObject

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
 *  @return NSDeciamlNumber that is result of operation wrote in @parm operation
 */

- (NSDecimalNumber *)mathWithOperation:(NSString *)operation variablesString:(NSDictionary *)variables error:(NSError **)error;

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
 *  @return NSDecimalNumber that is result of operation wrote in @parm operation
 */

- (NSDecimalNumber *)mathWithOperation:(NSString *)operation variablesDecimal:(NSDictionary *)variables error:(NSError **)error;

@end
