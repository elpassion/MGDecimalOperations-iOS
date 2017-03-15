#import "MGOperationValidator.h"
#import "MGErrorFactory.h"
#import "MGOperatorProtocol.h"
#import "MGOpenBracket.h"
#import "MGVariable.h"

@interface MGOperationValidator ()

@property (nonatomic, strong) MGErrorFactory *errorFactory;

@end

@implementation MGOperationValidator

- (instancetype)init
{
    if (self = [super init]) {
        _errorFactory = [MGErrorFactory new];
    }
    return self;
}

- (void)validateOperationWithString:(NSString *)operation error:(NSError **)error
{
    if ([self isNumberOfCloseAndOpenBracketsEqual:operation] == false) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Different number of open and close brackets"];
    } else if ([self isCorrectNumberOfOperatorsAndVariables:operation] == false) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Numbers not separated by operator"];
    }
}

- (void)validateOperationWithSeparatedObjects:(NSArray *)separatedObjects
                                    variables:(NSDictionary *)variables
                                        error:(NSError **)error
{
    if ([self areCurrentAndPreviousObjectsCanBeNeighbours:separatedObjects] == false) {
        *error = [self.errorFactory errorWithMessage:@"Wrong operation. Operator next to operator"];
    }else if([self isDictionaryContainSeparatedObjects:separatedObjects variables:variables] == false) {
        *error = [self.errorFactory errorWithMessage:@"Dictionary doesn't contain all variables"];
    }
}

- (BOOL)isDictionaryContainSeparatedObjects:(NSArray *)separatedObjects variables:(NSDictionary *)variables
{
    for(NSUInteger i = 0; i < separatedObjects.count; i++){
        id <MGOperationObjectProtocol> object = separatedObjects[i];
        if ([object isKindOfClass:[MGVariable class]]){
            MGVariable *variable = (MGVariable *)object;
            NSDecimalNumber *value = variables[variable.symbol];
            if (value == nil){
                return false;
            }
        }
    }
    return true;
}

- (BOOL)isNumberOfCloseAndOpenBracketsEqual:(NSString *)operation
{
    NSUInteger open = 0;
    NSUInteger close = 0;

    for (NSUInteger i = 0; i < operation.length; i++) {
        UniChar character = [operation characterAtIndex:i];
        if (character == '(') open++;
        if (character == ')') close++;
    }
    return (open == close);
}

- (BOOL)isCorrectNumberOfOperatorsAndVariables:(NSString *)operation
{
    NSString *operationWithoutOpenBrackets = [operation stringByReplacingOccurrencesOfString:@"(" withString:@""];
    NSString *operationWithoutBrackets = [operationWithoutOpenBrackets stringByReplacingOccurrencesOfString:@")"
                                                                                                 withString:@""];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@" -+*/"];
    NSArray *operationInParts = [operationWithoutBrackets componentsSeparatedByCharactersInSet:characterSet];
    NSPredicate *noEmptyString = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSArray *filteredArray = [operationInParts filteredArrayUsingPredicate:noEmptyString];

    NSUInteger numberOfVariables = filteredArray.count;
    NSUInteger numberOfOperators = [self numberOfOperatorsWithOperation:operation];
    return numberOfOperators == numberOfVariables-1;
}

-(NSUInteger)numberOfOperatorsWithOperation:(NSString *)operation
{
    NSUInteger numberOfOperators = 0;
    for (NSUInteger i = 0; i < operation.length; i++){
        UniChar character = [operation characterAtIndex:i];
        if(character == '+' || character == '-' || character == '*' || character == '/'){
            numberOfOperators++;
        }
    }
    return numberOfOperators;
}

- (BOOL)areCurrentAndPreviousObjectsCanBeNeighbours:(NSArray *)separatedObjects
{
    for (NSUInteger i = 1; i < separatedObjects.count; i++) {
        id <MGOperationObjectProtocol> current = separatedObjects[i];
        id <MGOperationObjectProtocol> previous = separatedObjects[i - 1];

        if ([current class] == [MGOpenBracket class] || [previous class] == [MGOpenBracket class]) return YES;
        if ([current conformsToProtocol:@protocol(MGOperatorProtocol)] &&
            [previous conformsToProtocol:@protocol(MGOperatorProtocol)]) {
            return NO;
        }
    }
    return YES;
}

@end
