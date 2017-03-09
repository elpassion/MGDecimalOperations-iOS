#import <Foundation/Foundation.h>

@protocol MGOperationObjectProtocol;

@interface MGOperationConverter : NSObject

- (NSArray *)separatedObjectsWithString:(NSString *)operation;
- (id <MGOperationObjectProtocol>)operationObjectWithString:(NSString *)operation currentPositionInString:(NSUInteger)currentPosition;

@end
