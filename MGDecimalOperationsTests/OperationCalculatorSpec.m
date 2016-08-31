#import "SpecHelper.h"
#import "OperationCalculator.h"
#import "BracketOperator.h"
#import "AddOperator.h"
#import "Variable.h"
#import "MultiplyOperator.h"
#import "DivideOperator.h"
#import "SubtractOperator.h"

SpecBegin(OperationCalculator)

    describe(@"OperationCalculator", ^{

        __block OperationCalculator *sut;

        beforeEach(^{
            sut = [OperationCalculator new];
        });

        afterEach(^{
            sut = nil;
        });

        describe(@"postfixExpressionWithSeparatedObjects", ^{

            __block NSArray *result;
            __block NSArray *inputObjects;

            context(@"when perform with '((3+5)*7)'", ^{

                beforeEach(^{
                    inputObjects = @[
                            [[BracketOperator alloc] initWithSymbol:@"("],
                            [[BracketOperator alloc] initWithSymbol:@"("],
                            [[Variable alloc] initWithSymbol:@"3"],
                            [AddOperator new],
                            [[Variable alloc] initWithSymbol:@"5"],
                            [[BracketOperator alloc] initWithSymbol:@")"],
                            [MultiplyOperator new],
                            [[Variable alloc] initWithSymbol:@"7"],
                            [[BracketOperator alloc] initWithSymbol:@")"]
                    ];

                    result = [sut postfixExpressionWithSeparatedObjects:inputObjects];
                });

                it(@"should return 5 elements", ^{
                    expect(result).to.haveCount(5);
                });

                it(@"should return right value", ^{
                    expect(result).to.equal(@[
                            inputObjects[2],
                            inputObjects[4],
                            inputObjects[3],
                            inputObjects[7],
                            inputObjects[6]
                    ]);
                });
            });

            context(@"when perform with '2*2+2'", ^{

                beforeEach(^{
                    inputObjects = @[
                            [[Variable alloc] initWithSymbol:@"2"],
                            [MultiplyOperator new],
                            [[Variable alloc] initWithSymbol:@"2"],
                            [AddOperator new],
                            [[Variable alloc] initWithSymbol:@"2"]
                    ];

                    result = [sut postfixExpressionWithSeparatedObjects:inputObjects];
                });

                it(@"should return 5 elements", ^{
                    expect(result).to.haveCount(5);
                });

                it(@"should return right value", ^{
                    expect(result).to.equal(@[
                            inputObjects[0],
                            inputObjects[2],
                            inputObjects[1],
                            inputObjects[4],
                            inputObjects[3]
                    ]);
                });
            });

            context(@"when perform with '((3/2*5)+6)'", ^{

                beforeEach(^{
                    inputObjects = @[
                            [[BracketOperator alloc] initWithSymbol:@"("],
                            [[BracketOperator alloc] initWithSymbol:@"("],
                            [[Variable alloc] initWithSymbol:@"3"],
                            [DivideOperator new],
                            [[Variable alloc] initWithSymbol:@"2"],
                            [MultiplyOperator new],
                            [[Variable alloc] initWithSymbol:@"5"],
                            [[BracketOperator alloc] initWithSymbol:@")"],
                            [AddOperator new],
                            [[Variable alloc] initWithSymbol:@"6"],
                            [[BracketOperator alloc] initWithSymbol:@")"]
                    ];

                    result = [sut postfixExpressionWithSeparatedObjects:inputObjects];
                });

                it(@"should have 11 elements", ^{
                    expect(result).haveCount(7);
                });

                it(@"should return right value", ^{
                    expect(result).to.equal(@[
                            inputObjects[2],
                            inputObjects[4],
                            inputObjects[3],
                            inputObjects[6],
                            inputObjects[5],
                            inputObjects[9],
                            inputObjects[8]
                    ]);
                });
            });

            context(@"when perform with '3+5*7/3/(3-5)'", ^{

                beforeEach(^{
                    inputObjects = @[
                            [[Variable alloc] initWithSymbol:@"3"],
                            [AddOperator new],
                            [[Variable alloc] initWithSymbol:@"5"],
                            [MultiplyOperator new],
                            [[Variable alloc] initWithSymbol:@"7"],
                            [DivideOperator new],
                            [[Variable alloc] initWithSymbol:@"3"],
                            [DivideOperator new],
                            [[BracketOperator alloc] initWithSymbol:@"("],
                            [[Variable alloc] initWithSymbol:@"3"],
                            [SubtractOperator new],
                            [[Variable alloc] initWithSymbol:@"5"],
                            [[BracketOperator alloc] initWithSymbol:@")"]
                    ];

                    result = [sut postfixExpressionWithSeparatedObjects:inputObjects];
                });

                it(@"should have 11 elements", ^{
                    expect(result).haveCount(11);
                });

                it(@"should return right value", ^{
                    expect(result).to.equal(@[
                            inputObjects[0],
                            inputObjects[2],
                            inputObjects[4],
                            inputObjects[3],
                            inputObjects[6],
                            inputObjects[5],
                            inputObjects[9],
                            inputObjects[11],
                            inputObjects[10],
                            inputObjects[7],
                            inputObjects[1]
                    ]);
                });
            });
        });

        describe(@"evaluatedResultWithPostfixArray", ^{

            __block Variable *result;
            __block NSArray *postfixArray;
            __block NSDictionary *inputVariables;

            context(@"when perform with 'a b + c *'", ^{

                beforeEach(^{
                    postfixArray = @[
                            [[Variable alloc] initWithSymbol:@"a"],
                            [[Variable alloc] initWithSymbol:@"b"],
                            [AddOperator new],
                            [[Variable alloc] initWithSymbol:@"c"],
                            [MultiplyOperator new]
                    ];

                    inputVariables = @{
                            @"a" : [[NSDecimalNumber alloc] initWithString:@"3"],
                            @"b" : [[NSDecimalNumber alloc] initWithString:@"5"],
                            @"c" : [[NSDecimalNumber alloc] initWithString:@"7"],
                    };

                    result = [sut evaluatedResultWithPostfixArray:postfixArray variablesDictionary:inputVariables];
                });

                it(@"should return 56", ^{
                    expect(result.value).equal(56);
                });
            });
        });
    });

SpecEnd