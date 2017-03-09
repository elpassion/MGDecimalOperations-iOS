#import "SpecHelper.h"
#import "MGOperationCalculator.h"
#import "MGAddOperator.h"
#import "MGVariable.h"
#import "MGMultiplyOperator.h"
#import "MGDivideOperator.h"
#import "MGSubtractOperator.h"
#import "MGOpenBracket.h"
#import "MGCloseBracket.h"

SpecBegin(MGOperationCalculator)

    describe(@"MGOperationCalculator", ^{
        __block MGOperationCalculator *sut;

        beforeEach(^{
            sut = [MGOperationCalculator new];
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
                            [MGOpenBracket new],
                            [MGOpenBracket new],
                            [[MGVariable alloc] initWithSymbol:@"3"],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"5"],
                            [MGCloseBracket new],
                            [MGMultiplyOperator new],
                            [[MGVariable alloc] initWithSymbol:@"7"],
                            [MGCloseBracket new]
                    ];
                    result = [sut postfixExpressionWithSeparatedObjects:inputObjects];
                });

                describe(@"result", ^{
                    it(@"should have 5 elements", ^{
                        expect(result).to.haveCount(5);
                    });

                    it(@"should have right value", ^{
                        expect(result).to.equal(@[
                                inputObjects[2],
                                inputObjects[4],
                                inputObjects[3],
                                inputObjects[7],
                                inputObjects[6]
                        ]);
                    });
                });
            });

            context(@"when perform with '2*2+2'", ^{
                beforeEach(^{
                    inputObjects = @[
                            [[MGVariable alloc] initWithSymbol:@"2"],
                            [MGMultiplyOperator new],
                            [[MGVariable alloc] initWithSymbol:@"2"],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"2"]
                    ];
                    result = [sut postfixExpressionWithSeparatedObjects:inputObjects];
                });

                describe(@"result", ^{
                    it(@"should have 5 elements", ^{
                        expect(result).to.haveCount(5);
                    });

                    it(@"should have right value", ^{
                        expect(result).to.equal(@[
                                inputObjects[0],
                                inputObjects[2],
                                inputObjects[1],
                                inputObjects[4],
                                inputObjects[3]
                        ]);
                    });
                });
            });

            context(@"when perform with '((3/2*5)+6)'", ^{
                beforeEach(^{
                    inputObjects = @[
                            [MGOpenBracket new],
                            [MGOpenBracket new],
                            [[MGVariable alloc] initWithSymbol:@"3"],
                            [MGDivideOperator new],
                            [[MGVariable alloc] initWithSymbol:@"2"],
                            [MGMultiplyOperator new],
                            [[MGVariable alloc] initWithSymbol:@"5"],
                            [MGCloseBracket new],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"6"],
                            [MGCloseBracket new],
                    ];
                    result = [sut postfixExpressionWithSeparatedObjects:inputObjects];
                });

                describe(@"result", ^{
                    it(@"should have 11 elements", ^{
                        expect(result).to.haveCount(7);
                    });

                    it(@"should have right value", ^{
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
            });

            context(@"when perform with '3+5*7/3/(3-5)'", ^{
                beforeEach(^{
                    inputObjects = @[
                            [[MGVariable alloc] initWithSymbol:@"3"],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"5"],
                            [MGMultiplyOperator new],
                            [[MGVariable alloc] initWithSymbol:@"7"],
                            [MGDivideOperator new],
                            [[MGVariable alloc] initWithSymbol:@"3"],
                            [MGDivideOperator new],
                            [MGOpenBracket new],
                            [[MGVariable alloc] initWithSymbol:@"3"],
                            [MGSubtractOperator new],
                            [[MGVariable alloc] initWithSymbol:@"5"],
                            [MGCloseBracket new]
                    ];
                    result = [sut postfixExpressionWithSeparatedObjects:inputObjects];
                });

                describe(@"result", ^{
                    it(@"should have 11 elements", ^{
                        expect(result).to.haveCount(11);
                    });

                    it(@"should have right value", ^{
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

            context(@"when perform with '2+((2+2)/(2*2)*2)'", ^{
                beforeEach(^{
                    inputObjects = @[
                            [[MGVariable alloc] initWithSymbol:@"a"],
                            [MGAddOperator new],
                            [MGOpenBracket new],
                            [MGOpenBracket new],
                            [[MGVariable alloc] initWithSymbol:@"a"],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"a"],
                            [MGCloseBracket new],
                            [MGDivideOperator new],
                            [MGOpenBracket new],
                            [[MGVariable alloc] initWithSymbol:@"a"],
                            [MGMultiplyOperator new],
                            [[MGVariable alloc] initWithSymbol:@"a"],
                            [MGCloseBracket new],
                            [MGMultiplyOperator new],
                            [[MGVariable alloc] initWithSymbol:@"a"],
                            [MGCloseBracket new]
                    ];

                    result = [sut postfixExpressionWithSeparatedObjects:inputObjects];
                });

                describe(@"result", ^{
                    it(@"should have 11 elements", ^{
                        expect(result).to.haveCount(11);
                    });

                    it(@"should have right value", ^{
                        expect(result).to.equal(@[
                                inputObjects[0],
                                inputObjects[4],
                                inputObjects[6],
                                inputObjects[5],
                                inputObjects[10],
                                inputObjects[12],
                                inputObjects[11],
                                inputObjects[8],
                                inputObjects[15],
                                inputObjects[14],
                                inputObjects[1]
                        ]);
                    });
                });
            });
        });

        describe(@"evaluatedResultWithPostfixArray", ^{
            __block MGVariable *result;
            __block NSArray *postfixArray;
            __block NSDictionary *inputVariables;

            context(@"when perform with 'a b + c *'", ^{
                beforeEach(^{
                    postfixArray = @[
                            [[MGVariable alloc] initWithSymbol:@"a"],
                            [[MGVariable alloc] initWithSymbol:@"b"],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"c"],
                            [MGMultiplyOperator new]
                    ];
                    inputVariables = @{
                            @"a": [[NSDecimalNumber alloc] initWithString:@"3"],
                            @"b": [[NSDecimalNumber alloc] initWithString:@"5"],
                            @"c": [[NSDecimalNumber alloc] initWithString:@"7"],
                    };
                    result = [sut evaluatedResultWithPostfixArray:postfixArray variablesDictionary:inputVariables];
                });

                it(@"should return 56", ^{
                    expect(result.value).to.equal(56);
                });
            });

            context(@"when perform with 'a  b  +  c  c  /  +'", ^{
                beforeEach(^{
                    postfixArray = @[
                            [[MGVariable alloc] initWithSymbol:@"a"],
                            [[MGVariable alloc] initWithSymbol:@"b"],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"c"],
                            [[MGVariable alloc] initWithSymbol:@"c"],
                            [MGDivideOperator new],
                            [MGAddOperator new]
                    ];
                    inputVariables = @{
                            @"a": [[NSDecimalNumber alloc] initWithString:@"3"],
                            @"b": [[NSDecimalNumber alloc] initWithString:@"5"],
                            @"c": [[NSDecimalNumber alloc] initWithString:@"7"]
                    };
                    result = [sut evaluatedResultWithPostfixArray:postfixArray variablesDictionary:inputVariables];
                });

                it(@"should return 9", ^{
                    expect(result.value).to.equal(9);
                });
            });
        });
    });

SpecEnd
