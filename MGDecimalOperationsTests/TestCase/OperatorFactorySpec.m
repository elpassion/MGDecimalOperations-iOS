#import "SpecHelper.h"
#import "OperatorFactory.h"
#import "AddOperator.h"
#import "SubtractOperator.h"
#import "MultiplyOperator.h"
#import "DivideOperator.h"
#import "OpenBracket.h"
#import "CloseBracket.h"

SpecBegin(OperatorFactory)

describe(@"OperatorFactory", ^{
    __block OperatorFactory *sut;

    beforeEach(^{
        sut = [OperatorFactory new];
    });

    afterEach(^{
        sut = nil;
    });

    describe(@"operatorWithCharacter", ^{
        context(@"when perform with '+'", ^{
            __block id <OperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'+'];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([AddOperator class]);
            });
        });

        context(@"when perform with '-'", ^{
            __block id <OperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'-'];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([SubtractOperator class]);
            });
        });

        context(@"when perform with '*'", ^{
            __block id <OperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'*'];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([MultiplyOperator class]);
            });
        });

        context(@"when perform with '/'", ^{
            __block id <OperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'/'];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([DivideOperator class]);
            });
        });

        context(@"when perform with '('", ^{
            __block id <OperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'('];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([OpenBracket class]);
            });
        });

        context(@"when perform with ')'", ^{
            __block id <OperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:')'];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([CloseBracket class]);
            });
        });

        context(@"when perform with 'a'", ^{
            __block id <OperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'a'];
            });

            it(@"should return nil", ^{
                expect(result).to.beNil();
            });
        });
    });
});

SpecEnd
