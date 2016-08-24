#import "SpecHelper.h"

SpecBegin(ExampleTest)

describe(@"ExampleTest", ^{
    it(@"should be true", ^{
        NSInteger result = 1 + 1;
        expect(result).to.equal(2);
    });
});

SpecEnd