//
// Created by Maciej Gomółka on 08.01.2017.
// Copyright (c) 2017 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationObjectProtocol.h"

@protocol BracketProtocol <NSObject, OperationObjectProtocol>
@end@protocol BracketProtocol <NSObject, OperationObjectProtocol, NonValueObjectProtocol>
@end
