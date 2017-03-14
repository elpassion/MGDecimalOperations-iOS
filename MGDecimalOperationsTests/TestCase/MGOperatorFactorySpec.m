#import "SpecHelper.h"
#import "MGOperatorFactory.h"
#import "MGAddOperator.h"
#import "MGSubtractOperator.h"
#import "MGMultiplyOperator.h"
#import "MGDivideOperator.h"
#import "MGOpenBracket.h"
#import "MGCloseBracket.h"

SpecBegin(MGOperatorFactory)

describe(@"MGOperatorFactory", ^{
    __block MGOperatorFactory *sut;

    beforeEach(^{
        sut = [MGOperatorFactory new];
    });

    afterEach(^{
        sut = nil;
    });

    describe(@"operatorWithCharacter", ^{
        context(@"when perform with '+'", ^{
            __block id <MGOperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'+'];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([MGAddOperator class]);
            });
        });

        context(@"when perform with '-'", ^{
            __block id <MGOperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'-'];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([MGSubtractOperator class]);
            });
        });

        context(@"when perform with '*'", ^{
            __block id <MGOperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'*'];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([MGMultiplyOperator class]);
            });
        });

        context(@"when perform with '/'", ^{
            __block id <MGOperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'/'];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([MGDivideOperator class]);
            });
        });

        context(@"when perform with '('", ^{
            __block id <MGOperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:'('];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([MGOpenBracket class]);
            });
        });

        context(@"when perform with ')'", ^{
            __block id <MGOperationObjectProtocol> result;
            beforeEach(^{
                result = [sut operatorWithCharacter:')'];
            });

            it(@"should return correct object", ^{
                expect(result).to.beInstanceOf([MGCloseBracket class]);
            });
        });

        context(@"when perform with 'a'", ^{
            __block id <MGOperationObjectProtocol> result;
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
