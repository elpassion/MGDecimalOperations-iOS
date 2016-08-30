#import "SpecHelper.h"
#import "DecimalOperations.h"
#import "Variable.h"
#import "MultiplyOperator.h"
#import "AddOperator.h"
#import "DivideOperator.h"
#import "SubtractOperator.h"
#import "BracketOperator.h"

SpecBegin(DecimalOperations)

    describe(@"DecimalOperations", ^{

        __block DecimalOperations *sut;

        beforeEach(^{
            sut = [DecimalOperations new];
        });

        afterEach(^{
            sut = nil;
        });

        describe(@"mathWithOperation variablesDecimal", ^{

            __block NSDictionary *variables;
            __block NSDecimalNumber *result;

            afterEach(^{
                variables = nil;
                result = nil;
            });

            context(@"when perform '2.321378923 + 3.210932892'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"2.321378923"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"3.210932892"]
                    };
                    result = [sut mathWithOperation:@"a + b" variablesDecimal:variables error:nil];
                });

                it(@"should return 5.532311815", ^{
                    expect(result).to.equal(5.532311815);
                });
            });

            context(@"when perform '50 - 70'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"50"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"70"]
                    };
                    result = [sut mathWithOperation:@"a - b" variablesDecimal:variables error:nil];
                });

                it(@"should return -20", ^{
                    expect(result).to.equal(-20);
                });
            });

            context(@"when perform '3 * 5'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"3"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"5"]
                    };
                    result = [sut mathWithOperation:@"a * b" variablesDecimal:variables error:nil];
                });

                it(@"should return 15", ^{
                    expect(result).to.equal(15);
                });
            });

            context(@"when perform '70 / 7'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"70"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"7"]
                    };
                    result = [sut mathWithOperation:@"a / b" variablesDecimal:variables error:nil];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform '5 + 5 + 5 - 5'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"d": [NSDecimalNumber decimalNumberWithString:@"5"]
                    };

                    result = [sut mathWithOperation:@"a + b + c - d" variablesDecimal:variables error:nil];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform '4 * 5 / 2'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"4"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"2"]
                    };

                    result = [sut mathWithOperation:@"a * b / c" variablesDecimal:variables error:nil];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform '2 + (2 * 2)'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"2"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"2"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"2"]
                    };

                    result = [sut mathWithOperation:@"a + (b * c)" variablesDecimal:variables error:nil];
                });

                it(@"should return 6", ^{
                    expect(result).to.equal(6);
                });
            });

            context(@"when perform '(14 / 7 * (3 + (3 * 5)))'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"14"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"7"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"3"],
                            @"d": [NSDecimalNumber decimalNumberWithString:@"3"],
                            @"e": [NSDecimalNumber decimalNumberWithString:@"5"]
                    };

                    result = [sut mathWithOperation:@"(a / b * (c + (d * e)))" variablesDecimal:variables error:nil];
                });

                it(@"should return 36", ^{
                    expect(result).to.equal(36);
                });
            });

            context(@"when perform '((((3 * 5 * 2) + 5) - 10) / 5)'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"3"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"2"],
                            @"d": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"e": [NSDecimalNumber decimalNumberWithString:@"10"],
                            @"f": [NSDecimalNumber decimalNumberWithString:@"5"]
                    };

                    result = [sut mathWithOperation:@"((((a * b * c) + d) - e) / f)" variablesDecimal:variables error:nil];
                });

                it(@"should return 5", ^{
                    expect(result).to.equal(5);
                });
            });
        });

        describe(@"mathWithOperation variablesString", ^{

            __block NSDictionary *variables;
            __block NSDecimalNumber *result;

            afterEach(^{
                variables = nil;
                result = nil;
            });

            context(@"when perform '2.321378923 + 3.210932892'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"2.321378923",
                            @"b": @"3.210932892"
                    };
                    result = [sut mathWithOperation:@"a + b" variablesString:variables error:nil];
                });

                it(@"should return 5.532311815", ^{
                    expect(result).to.equal(5.532311815);
                });
            });

            context(@"when perform '50 - 70'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"50",
                            @"b": @"70"
                    };
                    result = [sut mathWithOperation:@"a - b" variablesString:variables error:nil];
                });

                it(@"should return -20", ^{
                    expect(result).to.equal(-20);
                });
            });

            context(@"when perform '3 * 5'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"3",
                            @"b": @"5"
                    };
                    result = [sut mathWithOperation:@"a * b" variablesString:variables error:nil];
                });

                it(@"should return 15", ^{
                    expect(result).to.equal(15);
                });
            });

            context(@"when perform '70 / 7'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"70",
                            @"b": @"7"
                    };
                    result = [sut mathWithOperation:@"a / b" variablesString:variables error:nil];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform '5 + 5 + 5 - 5'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"5",
                            @"b": @"5",
                            @"c": @"5",
                            @"d": @"5"
                    };

                    result = [sut mathWithOperation:@"a + b + c - d" variablesString:variables error:nil];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform '4 * 5 / 2'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"4",
                            @"b": @"5",
                            @"c": @"2"
                    };

                    result = [sut mathWithOperation:@"a * b / c" variablesString:variables error:nil];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform '2 + (2 * 2)'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"2",
                            @"b": @"2",
                            @"c": @"2"
                    };

                    result = [sut mathWithOperation:@"a + (b * c)" variablesString:variables error:nil];
                });

                it(@"should return 6", ^{
                    expect(result).to.equal(6);
                });
            });

            context(@"when perform '(14 / 7 * (3 + (3 * 5)))'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"14",
                            @"b": @"7",
                            @"c": @"3",
                            @"d": @"3",
                            @"e": @"5"
                    };

                    result = [sut mathWithOperation:@"(a / b * (c + (d * e)))" variablesString:variables error:nil];
                });

                it(@"should return 36", ^{
                    expect(result).to.equal(36);
                });
            });

            context(@"when perform '((((3 * 5 * 2) + 5) - 10) / 5)'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"3",
                            @"b": @"5",
                            @"c": @"2",
                            @"d": @"5",
                            @"e": @"10",
                            @"f": @"5"
                    };

                    result = [sut mathWithOperation:@"((((a * b * c) + d) - e) / f)" variablesString:variables error:nil];
                });

                it(@"should return 5", ^{
                    expect(result).to.equal(5);
                });
            });
        });

        describe(@"getOperationObjectWithString", ^{

            __block id <OperationObjectProtocol> result;

            afterEach(^{
                result = nil;
            });

            context(@"when perform with ' aa+b' at index 0", ^{

                beforeEach(^{
                    result = [sut getOperationObjectWithString:@"aa+b" currentPositionInString:0];
                });

                it(@"should return 'aa'", ^{
                    expect(result.symbol).to.equal(@"aa");
                });
            });

            context(@"when perform with 'a+bb' at index 1", ^{

                beforeEach(^{
                    result = [sut getOperationObjectWithString:@"a+bb" currentPositionInString:1];
                });

                it(@"should return '+'", ^{
                    expect(result.symbol).to.equal(@"+");
                });
            });

            context(@"when perform with '%%%' at index 0", ^{

                beforeEach(^{
                    result = [sut getOperationObjectWithString:@"%%%" currentPositionInString:0];
                });

                it(@"should return nil", ^{
                    expect(result.symbol).to.beNil();
                });
            });

            context(@"when perform with 'a*c' at index 1", ^{

                beforeEach(^{
                    result = [sut getOperationObjectWithString:@"a*c" currentPositionInString:1];
                });

                it(@"should return '*'", ^{
                    expect(result.symbol).to.equal(@"*");
                });
            });

            context(@"when perform with 'a-cc' at index 2", ^{

                beforeEach(^{
                    result = [sut getOperationObjectWithString:@"a-cc" currentPositionInString:2];
                });

                it(@"should return 'cc'", ^{
                    expect(result.symbol).to.equal(@"cc");
                });
            });
        });

        describe(@"getSeparatedObjectsWithString", ^{

            __block NSArray *result;

            afterEach(^{
                result = nil;
            });

            context(@"when perform with 'a+b*c'", ^{

                beforeEach(^{
                    result = [sut getSeparatedObjectsWithString:@"a + b * c"];
                });

                it(@"should return array with 5 elements", ^{
                    expect(result).to.haveCount(5);
                });

                it(@"should symbols 0,2,4 be kind of class Variable", ^{
                    expect(result[0]).beAKindOf([Variable class]);
                    expect(result[2]).beAKindOf([Variable class]);
                    expect(result[4]).beAKindOf([Variable class]);
                });

                it(@"should symbols 1,3 implements 'OperatorProtocol'", ^{
                    expect(result[1]).conformTo(@protocol(OperatorProtocol));
                    expect(result[3]).conformTo(@protocol(OperatorProtocol));
                });

                it(@"should return correct values", ^{
                    expect([result[0] symbol]).to.equal(@"a");
                    expect([result[1] symbol]).to.equal(@"+");
                    expect([result[2] symbol]).to.equal(@"b");
                    expect([result[3] symbol]).to.equal(@"*");
                    expect([result[4] symbol]).to.equal(@"c");
                });
            });

            context(@"when perform with 'aa *(b + ccc)'", ^{

                beforeEach(^{
                    result = [sut getSeparatedObjectsWithString:@"aa *(b + ccc)"];
                });

                it(@"should return array with 7 elements", ^{
                    expect(result).to.haveCount(7);
                });

                it(@"should symbols 0,3,5 be kind of class Variable", ^{
                    expect(result[0]).beAKindOf([Variable class]);
                    expect(result[3]).beAKindOf([Variable class]);
                    expect(result[5]).beAKindOf([Variable class]);
                });

                it(@"should symbols 1,2,4,6 implements 'OperatorProtocol'", ^{
                    expect(result[1]).conformTo(@protocol(OperatorProtocol));
                    expect(result[2]).conformTo(@protocol(OperatorProtocol));
                    expect(result[4]).conformTo(@protocol(OperatorProtocol));
                    expect(result[6]).conformTo(@protocol(OperatorProtocol));
                });

                it(@"should return correct values", ^{
                    expect([result[0] symbol]).to.equal(@"aa");
                    expect([result[1] symbol]).to.equal(@"*");
                    expect([result[2] symbol]).to.equal(@"(");
                    expect([result[3] symbol]).to.equal(@"b");
                    expect([result[4] symbol]).to.equal(@"+");
                    expect([result[5] symbol]).to.equal(@"ccc");
                    expect([result[6] symbol]).to.equal(@")");
                });
            });
        });

        describe(@"getPostfixExpressionWithSeparatedObjects", ^{

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

                    result = [sut getPostfixExpressionWithSeparatedObjects:inputObjects];
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

                    result = [sut getPostfixExpressionWithSeparatedObjects:inputObjects];
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

                    result = [sut getPostfixExpressionWithSeparatedObjects:inputObjects];
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

                    result = [sut getPostfixExpressionWithSeparatedObjects:inputObjects];
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
    });

SpecEnd