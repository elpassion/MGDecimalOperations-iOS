//
// Created by Maciej Gomółka on 31.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationObjectProtocol.h"

@interface FailedObject : NSObject <OperationObjectProtocol>

@property (nonatomic, strong) NSString *symbol;

@end
