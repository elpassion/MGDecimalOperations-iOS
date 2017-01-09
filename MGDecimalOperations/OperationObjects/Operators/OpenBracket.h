//
// Created by Maciej Gomółka on 30.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NonValueObjectProtocol.h"

@class Variable;

@interface OpenBracket : NSObject <NonValueObjectProtocol>

@property (nonatomic, strong) NSString *symbol;

@end
