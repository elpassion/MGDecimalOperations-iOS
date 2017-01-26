#import <Foundation/Foundation.h>

@protocol OperationObjectProtocol;

@interface OperationConverter : NSObject

- (NSArray *)separatedObjectsWithString:(NSString *)operation;
- (id <OperationObjectProtocol>)operationObjectWithString:(NSString *)operation currentPositionInString:(NSUInteger)currentPosition;

@end
