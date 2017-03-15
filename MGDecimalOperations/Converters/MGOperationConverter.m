#import "MGOperationConverter.h"
#import "MGOperatorFactory.h"
#import "MGVariable.h"

@interface MGOperationConverter ()

@property (nonatomic, strong) MGOperatorFactory *operatorFactory;

@end

@implementation MGOperationConverter

- (instancetype)init
{
    if (self = [super init]) {
        _operatorFactory = [MGOperatorFactory new];
    }
    return self;
}

- (NSArray *)separatedObjectsWithString:(NSString *)operation
{
    NSString *operationWithoutSpaces = [operation stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger currentPositionInString = 0;
    NSUInteger operationLength = operationWithoutSpaces.length;
    id <MGOperationObjectProtocol> currentObject;
    NSArray *separatedObjects = [NSArray new];

    while (currentPositionInString < operationLength) {
        currentObject = [self operationObjectWithString:operationWithoutSpaces
                                currentPositionInString:currentPositionInString];
        separatedObjects = [separatedObjects arrayByAddingObject:currentObject];
        currentPositionInString += currentObject.symbol.length;
    }
    return separatedObjects;
}

- (id <MGOperationObjectProtocol>)operationObjectWithString:(NSString *)operation currentPositionInString:(NSUInteger)currentPosition
{
    NSString *object = @"";

    while (currentPosition < operation.length) {
        UniChar character = [operation characterAtIndex:currentPosition];
        if ([self isOperator:character]) {
            if (object.length == 0) {
                return (id<MGOperationObjectProtocol>) [self.operatorFactory operatorWithCharacter:character];
            }
            return [[MGVariable alloc] initWithSymbol:object];
        } else {
            object = [object stringByAppendingFormat:@"%c", character];
            currentPosition++;
        }
    }
    return [[MGVariable alloc] initWithSymbol:object];
}

- (BOOL)isOperator:(UniChar)character
{
    return [self.availableOperatorsSet characterIsMember:character];
}

- (NSCharacterSet *)availableOperatorsSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"()*/+-"];
}

@end
