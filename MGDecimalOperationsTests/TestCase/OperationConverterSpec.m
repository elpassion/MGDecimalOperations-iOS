#import "SpecHelper.h"
#import "OperationConverter.h"
#import "OperatorProtocol.h"
#import "Variable.h"

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

        afterEach(^{
            result = nil;
        });

        context(@"when perform with ' aa+b' at index 0", ^{

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

        afterEach(^{
            result = nil;
        });

        context(@"when perform with 'a+b*c'", ^{

            beforeEach(^{
                result = [sut separatedObjectsWithString:@"a + b * c"];
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
                result = [sut separatedObjectsWithString:@"aa *(b + ccc)"];
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
});

SpecEnd