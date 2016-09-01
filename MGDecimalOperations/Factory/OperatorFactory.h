//
// Created by Maciej Gomółka on 28.08.2016.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OperationObjectProtocol;

@interface OperatorFactory : NSObject

- (id <OperationObjectProtocol>)operatorWithCharacter:(UniChar)operatorSymbol;

@end
