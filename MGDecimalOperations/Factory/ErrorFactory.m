//
// Created by Maciej Gomółka on 24.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import "ErrorFactory.h"

@implementation ErrorFactory

- (NSError *)errorWithMessage:(NSString *)errorMessage
{
    NSMutableDictionary *details = [NSMutableDictionary new];
    details[NSLocalizedDescriptionKey] = errorMessage;
    return [NSError errorWithDomain:@"MGDecimalOperations" code:1 userInfo:[details copy]];
}

@end
