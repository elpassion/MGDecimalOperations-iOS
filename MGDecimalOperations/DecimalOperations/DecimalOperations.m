#import "DecimalOperations.h"
#import "DecimalConverter.h"
#import "Variable.h"
#import "OperationValidator.h"
#import "OperationCalculator.h"
#import "OperationConverter.h"

@interface DecimalOperations ()

@property (nonatomic, strong) DecimalConverter *decimalsConverter;
@property (nonatomic, strong) OperationValidator *operationValidator;
@property (nonatomic, strong) OperationCalculator *operationCalculator;
@property (nonatomic, strong) OperationConverter *operationConverter;

@end

@implementation DecimalOperations

- (instancetype)init
{
    if (self = [super init]) {
        _decimalsConverter = [DecimalConverter new];
        _operationValidator = [OperationValidator new];
        _operationCalculator = [OperationCalculator new];
        _operationConverter = [OperationConverter new];
    }
    return self;
}

- (NSDecimalNumber *)mathWithOperation:(NSString *)operation variablesString:(NSDictionary *)variables error:(NSError **)error
{
    NSDictionary *convertedVariables = [self.decimalsConverter decimalVariablesFromStringVariables:variables error:error];
    return [self mathWithOperation:operation variablesDecimal:convertedVariables error:error];
}

- (NSDecimalNumber *)mathWithOperation:(NSString *)operation variablesDecimal:(NSDictionary *)variables error:(NSError **)error
{
    [self.operationValidator validateOperationWithString:operation error:error];
    if (*error) return nil;
    NSArray *separatedObjects = [self.operationConverter separatedObjectsWithString:operation];
    [self.operationValidator validateOperationWithSeparatedObjects:separatedObjects variables:variables error:error];
    if (*error) return nil;
    NSArray *postfix = [[self operationCalculator] postfixExpressionWithSeparatedObjects:separatedObjects];
    Variable *resultVariable = [[self operationCalculator] evaluatedResultWithPostfixArray:postfix variablesDictionary:variables];
    return [resultVariable value];
}

@end
