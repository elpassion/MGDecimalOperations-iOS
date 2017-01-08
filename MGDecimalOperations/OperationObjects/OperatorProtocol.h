//
// Created by Maciej Gomółka on 30.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationObjectProtocol.h"

@class Variable;

@protocol OperatorProtocol <NSObject, OperationObjectProtocol, NonValueObjectProtocol>

@property (nonatomic) NSInteger priority;

- (Variable *)makeOperationWithFirstArgument:(Variable *)firstArgument SecondArgument:(Variable *)secondArgument;

@end
