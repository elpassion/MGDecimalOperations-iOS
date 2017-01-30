#import "SpecHelper.h"
#import "DecimalConverter.h"
#import "ErrorFactory.h"

SpecBegin(DecimalsConverter)

    describe(@"DecimalConverter", ^{
        __block DecimalConverter *sut;

        beforeEach(^{
            ErrorFactory *errorFactory = [ErrorFactory new];
            sut = [[DecimalConverter alloc] initWithErrorFactory:errorFactory];
        });

        afterEach(^{
            sut = nil;
        });

        describe(@"isCorrectNumber", ^{
            __block BOOL correctNumber;

            context(@"when check '22'", ^{
                beforeEach(^{
                    correctNumber = [sut isCorrectNumber:@"22"];
                });

                it(@"should return true", ^{
                    expect(correctNumber).to.beTruthy();
                });
            });

            context(@"when check '2343453.44'", ^{
                beforeEach(^{
                    correctNumber = [sut isCorrectNumber:@"2343453.44"];
                });

                it(@"should return true", ^{
                    expect(correctNumber).to.beTruthy();
                });
            });

            context(@"when check '223..234.3'", ^{
                beforeEach(^{
                    correctNumber = [sut isCorrectNumber:@"223..234.3"];
                });

                it(@"should return false", ^{
                    expect(correctNumber).to.beFalsy();
                });
            });

            context(@"when check '0.345345'", ^{
                beforeEach(^{
                    correctNumber = [sut isCorrectNumber:@"0.345345"];
                });

                it(@"should return true", ^{
                    expect(correctNumber).to.beTruthy();
                });
            });

            context(@"when check '2333afg334'", ^{
                beforeEach(^{
                    correctNumber = [sut isCorrectNumber:@"2333afg334"];
                });

                it(@"should return false", ^{
                    expect(correctNumber).to.beFalsy();
                });
            });

            context(@"when check '2344.a343'", ^{
                beforeEach(^{
                    correctNumber = [sut isCorrectNumber:@"2344.a343"];
                });

                it(@"should return false", ^{
                    expect(correctNumber).to.beFalsy();
                });
            });
        });

        describe(@"decimalVariablesFromStringVariables", ^{
            __block NSDictionary *stringVariables;
            __block NSDictionary *decimalVariables;
            __block NSDictionary *expectedResult;

            context(@"when check right variables", ^{
                __block NSError *error;

                beforeEach(^{
                    stringVariables = @{
                            @"a": @"2222",
                            @"b": @"345.65"
                    };
                    decimalVariables = [sut decimalVariablesFromStringVariables:stringVariables error:&error];
                    expectedResult = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"2222"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"345.65"]
                    };
                });

                it(@"should return right values", ^{
                    expect(decimalVariables).to.equal(expectedResult);
                });

                it(@"should error be nil", ^{
                    expect(error).to.beNil();
                });
            });

            context(@"when check wrong variables", ^{
                __block NSError *error;

                beforeEach(^{
                    stringVariables = @{
                            @"a": @"2a222",
                            @"b": @"345.65"
                    };
                    decimalVariables = [sut decimalVariablesFromStringVariables:stringVariables error:&error];
                });

                it(@"should return nil", ^{
                    expect(decimalVariables);
                });

                it(@"should error be nil", ^{
                    expect(error).notTo.beNil();
                });
            });
        });
    });

SpecEnd
