#import "SpecHelper.h"
#import "OperationValidator.h"
#import "Variable.h"
#import "AddOperator.h"

SpecBegin(OperationValidator)

    describe(@"OperationValidator", ^{

        __block OperationValidator *sut;

        beforeEach(^{
            sut = [OperationValidator new];
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

        describe(@"isRightNumberOfOperatorsAndVariables", ^{

            __block BOOL result;

            context(@"when perform with 'a b'", ^{

                beforeEach(^{
                    result = [sut isCorrectNumberOfOperatorsAndVariables:@"a b"];
                });

                it(@"should return true", ^{
                    expect(result).to.beTruthy();
                });
            });

            context(@"when perform with 'a+b'", ^{

                beforeEach(^{
                    result = [sut isCorrectNumberOfOperatorsAndVariables:@"a+b"];
                });

                it(@"should return false", ^{
                    expect(result).to.beFalsy();
                });
            });

            context(@"when perform with 'a + b'", ^{

                beforeEach(^{
                    result = [sut isCorrectNumberOfOperatorsAndVariables:@"a + b"];
                });

                it(@"should return false", ^{
                    expect(result).to.beFalsy();
                });
            });

            context(@"when perform with 'a  b'", ^{

                beforeEach(^{
                    result = [sut isCorrectNumberOfOperatorsAndVariables:@"a  b"];
                });

                it(@"should return true", ^{
                    expect(result).to.beTruthy();
                });
            });

            context(@"when perform with 'a +  b'", ^{

                beforeEach(^{
                    result = [sut isCorrectNumberOfOperatorsAndVariables:@"a + b"];
                });

                it(@"should return false", ^{
                    expect(result).to.beFalsy();
                });
            });
        });

        describe(@"isCurrentAndPreviousObjectsCanBeNeighbours", ^{

            __block NSArray *inputValues;
            __block BOOL result;

            context(@"when perform with '1 + 1'", ^{

                beforeEach(^{
                    inputValues = @[
                            [[Variable alloc] initWithSymbol:@"a" value:@"1"],
                            [AddOperator new],
                            [[Variable alloc] initWithSymbol:@"b" value:@"1"]
                    ];

                    result = [sut areCurrentAndPreviousObjectsCanBeNeighbours:inputValues];
                });

                it(@"should return true", ^{
                    expect(result).to.beTruthy();
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

                it(@"should error not to be nil", ^{
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

                it(@"should error not to be nil", ^{
                    expect(error).notTo.beNil();
                });

                it(@"should error have correct user info", ^{
                    expect(error.userInfo[NSLocalizedDescriptionKey]).to.equal(@"Wrong operation. Different number of open and close brackets");
                });
            });
        });
    });

SpecEnd