//
// Created by Maciej Gomółka on 28.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperatorProtocol.h"

@interface DivideOperator : NSObject <OperatorProtocol>

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) NSInteger priority;

@end
