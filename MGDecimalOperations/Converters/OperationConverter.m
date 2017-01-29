#import "OperationConverter.h"
#import "OperatorFactory.h"
#import "Variable.h"

@interface OperationConverter ()

@property (nonatomic, strong) OperatorFactory *operatorFactory;

@end

@implementation OperationConverter

- (instancetype)init
{
    if (self = [super init]) {
        _operatorFactory = [OperatorFactory new];
    }
    return self;
}

- (NSArray *)separatedObjectsWithString:(NSString *)operation
{
    NSString *operationWithoutSpaces = [operation stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger currentPositionInString = 0;
    NSUInteger operationLength = operationWithoutSpaces.length;
    id <OperationObjectProtocol> currentObject;
    NSArray *separatedObjects = [NSArray new];

    while (currentPositionInString < operationLength) {
        currentObject = [self operationObjectWithString:operationWithoutSpaces
                                currentPositionInString:currentPositionInString];
        separatedObjects = [separatedObjects arrayByAddingObject:currentObject];
        currentPositionInString += currentObject.symbol.length;
    }
    return separatedObjects;
}

- (id <OperationObjectProtocol>)operationObjectWithString:(NSString *)operation currentPositionInString:(NSUInteger)currentPosition
{
    NSString *object = @"";

    while (currentPosition < operation.length) {
        UniChar character = [operation characterAtIndex:currentPosition];
        if ([self isOperator:character]) {
            if (object.length == 0) {
                return (id<OperationObjectProtocol>) [self.operatorFactory operatorWithCharacter:character];
            }
            return [[Variable alloc] initWithSymbol:object];
        } else {
            object = [object stringByAppendingFormat:@"%c", character];
            currentPosition++;
        }
    }
    return [[Variable alloc] initWithSymbol:object];
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
