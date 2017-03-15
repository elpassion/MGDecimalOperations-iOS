#import "MGDecimalOperations.h"
#import "MGDecimalConverter.h"
#import "MGVariable.h"
#import "MGOperationValidator.h"
#import "MGOperationCalculator.h"
#import "MGOperationConverter.h"

@interface MGDecimalOperationsCalculator ()

@property (nonatomic, strong) MGDecimalConverter *decimalsConverter;
@property (nonatomic, strong) MGOperationValidator *operationValidator;
@property (nonatomic, strong) MGOperationCalculator *operationCalculator;
@property (nonatomic, strong) MGOperationConverter *operationConverter;

@end

@implementation MGDecimalOperationsCalculator

- (instancetype)init
{
    if (self = [super init]) {
        _decimalsConverter = [MGDecimalConverter new];
        _operationValidator = [MGOperationValidator new];
        _operationCalculator = [MGOperationCalculator new];
        _operationConverter = [MGOperationConverter new];
    }
    return self;
}

- (NSDecimalNumber *)mathWithOperation:(NSString *)operation
                       variablesString:(NSDictionary *)variables
                                 error:(NSError **)error
{
    NSDictionary *convertedVariables = [self.decimalsConverter decimalVariablesFromStringVariables:variables error:error];
    return [self mathWithOperation:operation variablesDecimal:convertedVariables error:error];
}

- (NSDecimalNumber *)mathWithOperation:(NSString *)operation
                      variablesDecimal:(NSDictionary *)variables
                                 error:(NSError **)error
{
    [self.operationValidator validateOperationWithString:operation error:error];
    if (*error) return nil;
    NSArray *separatedObjects = [self.operationConverter separatedObjectsWithString:operation];
    [self.operationValidator validateOperationWithSeparatedObjects:separatedObjects
                                                         variables:variables
                                                             error:error];
    if (*error) return nil;
    NSArray *postfix = [[self operationCalculator] postfixExpressionWithSeparatedObjects:separatedObjects];
    MGVariable *resultVariable = [[self operationCalculator] evaluatedResultWithPostfixArray:postfix
                                                                       variablesDictionary:variables];
    return [resultVariable value];
}

@end
