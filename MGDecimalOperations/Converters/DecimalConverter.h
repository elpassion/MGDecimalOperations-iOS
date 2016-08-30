//
// Created by Maciej Gomółka on 25.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ErrorFactory;

@interface DecimalConverter : NSObject

- (instancetype)initWithErrorFactory:(ErrorFactory *)errorFactory;

- (NSMutableDictionary *)decimalVariablesFromStringVariables:(NSDictionary *)variables error:(NSError **)error;
- (NSDecimalNumber *)decimalNumberFromString:(NSString *)string;
- (BOOL)isCorrectNumber:(NSString *)variable;

@end
