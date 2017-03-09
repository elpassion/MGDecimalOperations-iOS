#import "SpecHelper.h"
#import "MGOperationValidator.h"
#import "MGVariable.h"
#import "MGAddOperator.h"

SpecBegin(MGOperationValidator)

    describe(@"MGOperationValidator", ^{
        __block MGOperationValidator *sut;

        beforeEach(^{
            sut = [MGOperationValidator new];
        });

        afterEach(^{
            sut = nil;
        });

        describe(@"isNumberOfCloseAndOpenBracketThisSame", ^{
            __block BOOL result;

            context(@"when perform with '(a + (b * (c / d)))'", ^{
                beforeEach(^{
                    result = [sut isNumberOfCloseAndOpenBracketsEqual:@"(a + (b * (c / d)))"];
                });

                it(@"should return true", ^{
                    expect(result).to.beTruthy();
                });
            });

            context(@"when perform with '(a + b - (c * d) - (f * g)))'", ^{
                beforeEach(^{
                    result = [sut isNumberOfCloseAndOpenBracketsEqual:@"(a + b - (c * d) - (f * g)))"];
                });

                it(@"should return false", ^{
                    expect(result).to.beFalsy();
                });
            });
        });

        describe(@"isCorrectNumberOfOperatorsAndVariables", ^{
            __block BOOL result;

            context(@"when perform with 'a b'", ^{
                beforeEach(^{
                    result = [sut isCorrectNumberOfOperatorsAndVariables:@"a b"];
                });

                it(@"should return false", ^{
                    expect(result).to.beFalsy();
                });
            });

            context(@"when perform with 'a+b'", ^{
                beforeEach(^{
                    result = [sut isCorrectNumberOfOperatorsAndVariables:@"a+b"];
                });

                it(@"should return true", ^{
                    expect(result).to.beTruthy();
                });
            });

            context(@"when perform with 'a + b'", ^{
                beforeEach(^{
                    result = [sut isCorrectNumberOfOperatorsAndVariables:@"a + b"];
                });

                it(@"should return true", ^{
                    expect(result).to.beTruthy();
                });
            });

            context(@"when perform with 'a  b'", ^{
                beforeEach(^{
                    result = [sut isCorrectNumberOfOperatorsAndVariables:@"a  b"];
                });

                it(@"should return false", ^{
                    expect(result).to.beFalsy();
                });
            });

            context(@"when perform with 'a +  b'", ^{
                beforeEach(^{
                    result = [sut isCorrectNumberOfOperatorsAndVariables:@"a + b"];
                });

                it(@"should return true", ^{
                    expect(result).to.beTruthy();
                });
            });
        });

        describe(@"areCurrentAndPreviousObjectsCanBeNeighbours", ^{
            __block NSArray *inputValues;
            __block BOOL result;

            context(@"when perform with '1 + 1'", ^{
                beforeEach(^{
                    inputValues = @[
                            [[MGVariable alloc] initWithSymbol:@"a" value:@"1"],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"b" value:@"1"]
                    ];
                    result = [sut areCurrentAndPreviousObjectsCanBeNeighbours:inputValues];
                });

                it(@"should return true", ^{
                    expect(result).to.beTruthy();
                });
            });

            context(@"when perform with '56 ++ 4'", ^{
                beforeEach(^{
                    inputValues = @[
                            [[MGVariable alloc] initWithSymbol:@"a" value:@"56"],
                            [MGAddOperator new],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"b" value:@"4"]
                    ];
                    result = [sut areCurrentAndPreviousObjectsCanBeNeighbours:inputValues];
                });

                it(@"should return false", ^{
                    expect(result).to.beFalsy();
                });
            });
        });

        describe(@"validateOperationWithString", ^{
            __block NSError *error;

            afterEach(^{
                error = nil;
            });

            context(@"when perform with 'a + b -c'", ^{
                beforeEach(^{
                    [sut validateOperationWithString:@"a + b -c" error:&error];
                });

                it(@"should error to be nil", ^{
                    expect(error).to.beNil();
                });
            });

            context(@"when perform with 'a + b (c)'", ^{
                beforeEach(^{
                    [sut validateOperationWithString:@"a + b (c)" error:&error];
                });

                it(@"should error NOT to be nil", ^{
                    expect(error).notTo.beNil();
                });

                it(@"should error have correct user info", ^{
                    expect(error.userInfo[NSLocalizedDescriptionKey]).to.equal(@"Wrong operation. Numbers not separated by operator");
                });
            });

            context(@"when perform with '(a + c * (g)))'", ^{
                beforeEach(^{
                    [sut validateOperationWithString:@"(a + c * (g)))" error:&error];
                });

                it(@"should error NOT to be nil", ^{
                    expect(error).notTo.beNil();
                });

                it(@"should error have correct user info", ^{
                    expect(error.userInfo[NSLocalizedDescriptionKey]).to.equal(@"Wrong operation. Different number of open and close brackets");
                });
            });

            context(@"when perform with 'a ++ a'", ^{
                beforeEach(^{
                    NSDictionary *variables = @{
                            @"a": [[NSDecimalNumber alloc] initWithString:@"2"]
                    };
                    NSArray *separatedObjects = @[
                            [[MGVariable alloc] initWithSymbol:@"a"],
                            [MGAddOperator new],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"a"]
                    ];
                    [sut validateOperationWithSeparatedObjects:separatedObjects variables:variables error:&error];
                });

                it(@"should error NOT to be nil", ^{
                    expect(error).notTo.beNil();
                });

                it(@"should error have correct user info", ^{
                    expect(error.userInfo[NSLocalizedDescriptionKey]).to.equal(@"Wrong operation. Operator next to operator");
                });
            });

            context(@"when perform 'a + b'", ^{
                beforeEach(^{
                    NSDictionary *variables = @{
                            @"a": [[NSDecimalNumber alloc] initWithString:@"a"]
                    };
                    NSArray *separatedObjects = @[
                            [[MGVariable alloc] initWithSymbol:@"a"],
                            [MGAddOperator new],
                            [[MGVariable alloc] initWithSymbol:@"b"]
                    ];
                    [sut validateOperationWithSeparatedObjects:separatedObjects variables:variables error:&error];
                });

                it(@"should error NOT to be nil", ^{
                    expect(error).notTo.beNil();
                });

                it(@"should error have correct user info", ^{
                    expect(error.userInfo[NSLocalizedDescriptionKey]).to.equal(@"Dictionary doesn't contain all variables");
                });
            });
        });
    });

SpecEnd
