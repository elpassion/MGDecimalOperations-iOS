#import "SpecHelper.h"
#import "DecimalOperations.h"

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
            __block NSError *error;

            afterEach(^{
                variables = nil;
                result = nil;
                error = nil;
            });

            context(@"when perform with '2.321378923 + 3.210932892'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"2.321378923"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"3.210932892"]
                    };
                    result = [sut mathWithOperation:@"a + b" variablesDecimal:variables error:&error];
                });

                it(@"should return 5.532311815", ^{
                    expect(result).to.equal(5.532311815);
                });
            });

            context(@"when perform with '50 - 70'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"50"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"70"]
                    };
                    result = [sut mathWithOperation:@"a - b" variablesDecimal:variables error:&error];
                });

                it(@"should return -20", ^{
                    expect(result).to.equal(-20);
                });
            });

            context(@"when perform with '3 * 5'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"3"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"5"]
                    };
                    result = [sut mathWithOperation:@"a * b" variablesDecimal:variables error:&error];
                });

                it(@"should return 15", ^{
                    expect(result).to.equal(15);
                });
            });

            context(@"when perform with '70 / 7'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"70"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"7"]
                    };
                    result = [sut mathWithOperation:@"a / b" variablesDecimal:variables error:&error];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform with '5 + 5 + 5 - 5'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"d": [NSDecimalNumber decimalNumberWithString:@"5"]
                    };

                    result = [sut mathWithOperation:@"a + b + c - d" variablesDecimal:variables error:&error];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform with '4 * 5 / 2'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"4"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"2"]
                    };

                    result = [sut mathWithOperation:@"a * b / c" variablesDecimal:variables error:&error];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform with '2 + (2 * 2)'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"2"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"2"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"2"]
                    };

                    result = [sut mathWithOperation:@"a + (b * c)" variablesDecimal:variables error:&error];
                });

                it(@"should return 6", ^{
                    expect(result).to.equal(6);
                });
            });

            context(@"when perform with '(14 / 7 * (3 + (3 * 5)))'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"14"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"7"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"3"],
                            @"d": [NSDecimalNumber decimalNumberWithString:@"3"],
                            @"e": [NSDecimalNumber decimalNumberWithString:@"5"]
                    };

                    result = [sut mathWithOperation:@"(a / b * (c + (d * e)))" variablesDecimal:variables error:&error];
                });

                it(@"should return 36", ^{
                    expect(result).to.equal(36);
                });
            });

            context(@"when perform with '((((3 * 5 * 2) + 5) - 10) / 5)'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"3"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"2"],
                            @"d": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"e": [NSDecimalNumber decimalNumberWithString:@"10"],
                            @"f": [NSDecimalNumber decimalNumberWithString:@"5"]
                    };

                    result = [sut mathWithOperation:@"((((a * b * c) + d) - e) / f)" variablesDecimal:variables error:&error];
                });

                it(@"should return 5", ^{
                    expect(result).to.equal(5);
                });
            });

            context(@"when perform with '1+((2/3)*4-(5+6)*7)'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"1"],
                            @"bb": [NSDecimalNumber decimalNumberWithString:@"9"],
                            @"c": [NSDecimalNumber decimalNumberWithString:@"3"],
                            @"d": [NSDecimalNumber decimalNumberWithString:@"4"],
                            @"e": [NSDecimalNumber decimalNumberWithString:@"5"],
                            @"f": [NSDecimalNumber decimalNumberWithString:@"6"],
                            @"go": [NSDecimalNumber decimalNumberWithString:@"7"],
                    };

                    result = [sut mathWithOperation:@"a+((bb/c )*d-( e +f)*go )" variablesDecimal:variables error:&error];
                });

                it(@"should return '-73,3332'", ^{
                    expect(result).to.equal(-64);
                });
            });

            context(@"when perform with '1++2'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"1"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"2"]
                    };

                    result = [sut mathWithOperation:@"a++b" variablesDecimal:variables error:&error];
                });

                it(@"should error be not nil", ^{
                    expect(error).notTo.beNil();
                });

                it(@"should return nil", ^{
                    expect(result).to.beNil();
                });
            });

            context(@"when perform with '2-+8'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"2"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"8"]
                    };

                    result = [sut mathWithOperation:@"a-+b" variablesDecimal:variables error:&error];
                });

                it(@"should error not to be nil", ^{
                    expect(error).notTo.beNil();
                });

                it(@"should return nil", ^{
                    expect(result).to.beNil();
                });
            });

            context(@"when perform with '111  222'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": [NSDecimalNumber decimalNumberWithString:@"111"],
                            @"b": [NSDecimalNumber decimalNumberWithString:@"222"]
                    };

                    result = [sut mathWithOperation:@"a  b" variablesDecimal:variables error:&error];
                });

                it(@"should error not to be nil", ^{
                    expect(error).notTo.beNil();
                });

                it(@"should return nil", ^{
                    expect(result).to.beNil();
                });
            });
        });

        describe(@"mathWithOperation variablesString", ^{

            __block NSDictionary *variables;
            __block NSDecimalNumber *result;
            __block NSError *error;

            afterEach(^{
                variables = nil;
                result = nil;
                error = nil;
            });

            context(@"when perform with '1 + 4 + 5 - 5'", ^{

                beforeEach(^{
                    variables= @{
                            @"$%^": @"1",
                            @"~AW": @"4",
                            @"!@#": @"5",
                            @"<7.,": @"5"
                    };

                    result = [sut mathWithOperation:@"$%^ + ~AW + !@# - <7.," variablesString:variables error:&error];
                });

                it(@"should return 5", ^{
                    expect(result).to.equal(5);
                });
            });

            context(@"when perform with '2.321378923 + 3.210932892'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"2.321378923",
                            @"b": @"3.210932892"
                    };
                    result = [sut mathWithOperation:@"a + b" variablesString:variables error:&error];
                });

                it(@"should return 5.532311815", ^{
                    expect(result).to.equal(5.532311815);
                });
            });

            context(@"when perform with '2 + 4*5'", ^{

                beforeEach(^{
                    variables = @{
                            @"a4a": @"2",
                            @"44g": @"4",
                            @"g4g": @"5"
                    };

                    result = [sut mathWithOperation:@"a4a + 44g*g4g" variablesString:variables error:&error];
                });

                it(@"should return 22", ^{
                    expect(result).to.equal(22);
                });
            });

            context(@"when perform with '50 - 70'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"50",
                            @"b": @"70"
                    };
                    result = [sut mathWithOperation:@"a - b" variablesString:variables error:&error];
                });

                it(@"should return -20", ^{
                    expect(result).to.equal(-20);
                });
            });

            context(@"when perform with '3 * 5'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"3",
                            @"b": @"5"
                    };
                    result = [sut mathWithOperation:@"a * b" variablesString:variables error:&error];
                });

                it(@"should return 15", ^{
                    expect(result).to.equal(15);
                });
            });

            context(@"when perform with '70 / 7'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"70",
                            @"b": @"7"
                    };
                    result = [sut mathWithOperation:@"a / b" variablesString:variables error:&error];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform with '5 + 5 + 5 - 5'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"5",
                            @"b": @"5",
                            @"c": @"5",
                            @"d": @"5"
                    };

                    result = [sut mathWithOperation:@"a + b + c - d" variablesString:variables error:&error];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform with '4 * 5 / 2'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"4",
                            @"b": @"5",
                            @"c": @"2"
                    };

                    result = [sut mathWithOperation:@"a * b / c" variablesString:variables error:&error];
                });

                it(@"should return 10", ^{
                    expect(result).to.equal(10);
                });
            });

            context(@"when perform with '2 + (2 * 2)'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"2",
                            @"b": @"2",
                            @"c": @"2"
                    };

                    result = [sut mathWithOperation:@"a + (b * c)" variablesString:variables error:&error];
                });

                it(@"should return 6", ^{
                    expect(result).to.equal(6);
                });
            });

            context(@"when perform with '(14 / 7 * (3 + (3 * 5)))'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"14",
                            @"b": @"7",
                            @"c": @"3",
                            @"d": @"3",
                            @"e": @"5"
                    };

                    result = [sut mathWithOperation:@"(a / b * (c + (d * e)))" variablesString:variables error:&error];
                });

                it(@"should return 36", ^{
                    expect(result).to.equal(36);
                });
            });

            context(@"when perform with '((((3 * 5 * 2) + 5) - 10) / 5)'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"3",
                            @"b": @"5",
                            @"c": @"2",
                            @"d": @"5",
                            @"e": @"10",
                            @"f": @"5"
                    };

                    result = [sut mathWithOperation:@"((((a * b * c) + d) - e) / f)" variablesString:variables error:&error];
                });

                it(@"should return 5", ^{
                    expect(result).to.equal(5);
                });
            });

            context(@"when perform 'a + b * (c /d - (e+f * g)) + h *(i + (j/ k))'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"1",
                            @"b": @"2",
                            @"c": @"8",
                            @"d": @"4",
                            @"e": @"5",
                            @"f": @"6",
                            @"g": @"7",
                            @"h": @"8",
                            @"i": @"9",
                            @"j": @"11",
                            @"k": @"11"
                    };

                    result = [sut mathWithOperation:@"a + b * (c /d - (e+f * g)) + h *(i + (j/ k))" variablesString:variables error:&error];
                });

                it(@"should return -9", ^{
                    expect(result).to.equal(-9);
                });

                it(@"should error be nil", ^{
                    expect(error).to.beNil();
                });
            });

            context(@"when perform with 'a + b*c dd'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"1",
                            @"b": @"2",
                            @"c": @"3",
                            @"dd": @"4"
                    };

                    result = [sut mathWithOperation:@"a + b*c dd" variablesString:variables error:&error];
                });

                it(@"should error not to be nil", ^{
                    expect(error).notTo.beNil();
                });
            });

            context(@"when perform with 'aa * abc/ccc+ fff'", ^{

                beforeEach(^{
                    variables = @{
                            @"aa": @"2",
                            @"abc": @"9",
                            @"ccc": @"3",
                            @"fff": @"1"
                    };

                    result = [sut mathWithOperation:@"aa * abc/ccc+ fff" variablesString:variables error:&error];
                });

                it(@"should return 7", ^{
                    expect(result).to.equal(7);
                });
            });

            context(@"when perform with 'a + b - c * d'", ^{

                beforeEach(^{
                    variables = @{
                            @"a": @"1",
                            @"b": @"3",
                            @"c": @"4"
                    };
                    
                    result = [sut mathWithOperation:@"a + b - c * d" variablesString:variables error:&error];
                });

                it(@"should return nil", ^{
                    expect(result).to.beNil();
                });

                it(@"should ", ^{
                    expect(error).notTo.beNil();
                });

                it(@"should return error with message 'Dictionary doesn't contain all variables'", ^{
                    expect(error.userInfo[NSLocalizedDescriptionKey]).to.equal(@"Dictionary doesn't contain all variables");
                });
            });
        });
    });

SpecEnd