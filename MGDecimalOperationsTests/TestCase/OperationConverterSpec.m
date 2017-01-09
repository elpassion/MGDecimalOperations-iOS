#import "SpecHelper.h"
#import "OperationConverter.h"
#import "OperatorProtocol.h"
#import "Variable.h"
#import "AddOperator.h"
#import "MultiplyOperator.h"
#import "OpenBracket.h"
#import "CloseBracket.h"

SpecBegin(OperationConverter)

describe(@"OperationConverter", ^{
    __block OperationConverter *sut;

    beforeEach(^{
        sut = [OperationConverter new];
    });

    afterEach(^{
        sut = nil;
    });

    describe(@"operationObjectWithString", ^{
        __block id <OperationObjectProtocol> result;

        context(@"when perform with 'aa+b' at index 0", ^{
            beforeEach(^{
                result = [sut operationObjectWithString:@"aa+b" currentPositionInString:0];
            });

            it(@"should return 'aa'", ^{
                expect(result.symbol).to.equal(@"aa");
            });
        });

        context(@"when perform with 'a+bb' at index 1", ^{
            beforeEach(^{
                result = [sut operationObjectWithString:@"a+bb" currentPositionInString:1];
            });

            it(@"should return '+'", ^{
                expect(result.symbol).to.equal(@"+");
            });
        });

        context(@"when perform with '%%%' at index 0", ^{
            beforeEach(^{
                result = [sut operationObjectWithString:@"%%%" currentPositionInString:0];
            });

            it(@"should return object", ^{
                expect(result).notTo.beNil();
            });

            it(@"should be kind of class FailedObject", ^{
                expect(result).beKindOf([Variable class]);
            });
        });

        context(@"when perform with 'a*c' at index 1", ^{
            beforeEach(^{
                result = [sut operationObjectWithString:@"a*c" currentPositionInString:1];
            });

            it(@"should return '*'", ^{
                expect(result.symbol).to.equal(@"*");
            });
        });

        context(@"when perform with 'a-cc' at index 2", ^{
            beforeEach(^{
                result = [sut operationObjectWithString:@"a-cc" currentPositionInString:2];
            });

            it(@"should return 'cc'", ^{
                expect(result.symbol).to.equal(@"cc");
            });
        });
    });

    describe(@"separatedObjectsWithString", ^{
        __block NSArray *result;

        context(@"when perform with 'a + b * c'", ^{
            beforeEach(^{
                result = [sut separatedObjectsWithString:@"a + b * c"];
            });

            it(@"should return array with 5 elements", ^{
                expect(result).to.haveCount(5);
            });

            describe(@"1st element", ^{
                it(@"should be instance of 'Variable'", ^{
                    expect(result[0]).beInstanceOf([Variable class]);
                });

                it(@"should have correct value", ^{
                    expect([result[0] symbol]).to.equal(@"a");
                });
            });

            describe(@"2nd element", ^{
                it(@"should be instance of 'AddOperator'", ^{
                    expect(result[1]).beInstanceOf([AddOperator class]);
                });

                it(@"should have correct value", ^{
                    expect([result[1] symbol]).to.equal(@"+");
                });
            });

            describe(@"3rd element", ^{
                it(@"should be instance of 'Variable'", ^{
                    expect(result[2]).beInstanceOf([Variable class]);
                });

                it(@"should have correct value", ^{
                    expect([result[2] symbol]).to.equal(@"b");
                });
            });

            describe(@"4th element", ^{
                it(@"should be instance of 'MultiplyOperator'", ^{
                    expect(result[3]).beInstanceOf([MultiplyOperator class]);
                });

                it(@"should have correct value", ^{
                    expect([result[3] symbol]).to.equal(@"*");
                });
            });

            describe(@"5th element", ^{
                it(@"should be instance of 'Variable'", ^{
                    expect(result[4]).beInstanceOf([Variable class]);
                });

                it(@"should have correct value", ^{
                    expect([result[4] symbol]).to.equal(@"c");
                });
            });
        });

        context(@"when perform with 'aa *(b + ccc)'", ^{
            beforeEach(^{
                result = [sut separatedObjectsWithString:@"aa *(b + ccc)"];
            });

            it(@"should return array with 7 elements", ^{
                expect(result).to.haveCount(7);
            });

            describe(@"1st element", ^{
                it(@"should be instance of 'Variable'", ^{
                    expect(result[0]).beInstanceOf([Variable class]);
                });

                it(@"should have correct value", ^{
                    expect([result[0] symbol]).to.equal(@"aa");
                });
            });

            describe(@"2nd element", ^{
                it(@"should be instance of 'MultiplyOperator'", ^{
                    expect(result[1]).beInstanceOf([MultiplyOperator class]);
                });

                it(@"should have correct value", ^{
                    expect([result[1] symbol]).to.equal(@"*");
                });
            });

            describe(@"3rd element", ^{
                it(@"should be instance of 'OpenBracket'", ^{
                    expect(result[2]).beInstanceOf([OpenBracket class]);
                });

                it(@"should have correct value", ^{
                    expect([result[2] symbol]).to.equal(@"(");
                });
            });

            describe(@"4th element", ^{
                it(@"should be instance of 'Variable'", ^{
                    expect(result[3]).beInstanceOf([Variable class]);
                });

                it(@"should have correct value", ^{
                    expect([result[3] symbol]).to.equal(@"b");
                });
            });

            describe(@"5th element", ^{
                it(@"should be instance of 'AddOperator'", ^{
                    expect(result[4]).beInstanceOf([AddOperator class]);
                });

                it(@"should have correct value", ^{
                    expect([result[4] symbol]).to.equal(@"+");
                });
            });

            describe(@"6th element", ^{
                it(@"should be instance of 'Variable'", ^{
                    expect(result[5]).beInstanceOf([Variable class]);
                });

                it(@"should have correct value", ^{
                    expect([result[5] symbol]).to.equal(@"ccc");
                });
            });

            describe(@"7th element", ^{
                it(@"should be instance of 'CloseBracket'", ^{
                    expect(result[6]).beInstanceOf([CloseBracket class]);
                });

                it(@"should have correct value", ^{
                    expect([result[6] symbol]).to.equal(@")");
                });
            });
        });
    });
});

SpecEnd
