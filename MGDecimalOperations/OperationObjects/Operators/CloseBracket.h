//
// Created by Maciej Gomółka on 08.01.2017.
// Copyright (c) 2017 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NonValueObjectProtocol.h"

@interface CloseBracket : NSObject <NonValueObjectProtocol>

@property (nonatomic, strong) NSString *symbol;

@end