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
        currentObject = [self operationObjectWithString:operationWithoutSpaces currentPositionInString:currentPositionInString];
        separatedObjects = [separatedObjects arrayByAddingObject:currentObject];
        currentPositionInString += currentObject.symbol.length;
    }
    return separatedObjects;
}

- (id <OperationObjectProtocol>)operationObjectWithString:(NSString *)operation currentPositionInString:(NSUInteger)currentPosition
{
    NSString *object = @"";
    BOOL isNumberInObject = NO;

    while (currentPosition < operation.length) {
        UniChar character = [operation characterAtIndex:currentPosition];
        if ([self isCharacterOperator:character]) {
            if (!isNumberInObject) {
                return [self.operatorFactory operatorWithCharacter:character];
            } else {
                return [[Variable alloc] initWithSymbol:object];
            }
        } else {
            isNumberInObject = YES;
            object = [object stringByAppendingFormat:@"%c", character];
            currentPosition++;
            continue;
        }
    }
    return [[Variable alloc] initWithSymbol:object];
}

- (BOOL)isCharacterOperator:(UniChar)character
{
    return ((character >= 40 && character <= 43) || character == 47 || character == 45);
}

@end
