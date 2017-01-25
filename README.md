![platform](https://img.shields.io/badge/platform-iOS-brightgreen.svg)
![language](https://img.shields.io/badge/language-Objective--C-brightgreen.svg)
![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)

# MGDecimalOperations
MGDecimalOperations is a framework that simplyfy and makes clear operations on ```NSDecimalNumbers```

## Requirements
* iOS 8.0+
* Objective-C or Swift

## Installation
### [CocoaPods](https://cocoapods.org/)
To install you need to add this line in your ```Podfile```
```
pod 'MGDecimalOperations'
```
and after that execute
```
pod install
```

## Description
The framework allows to make operations on ```NSDeciamlNumbers```. To perform an  operation you need to pass the operation written in ```String```, dictionary with variables and reference to ```NSError```. Framework keeps order of operations. You can use round brackets to establish order of operations. The name of variable is unlimited (all ASCII signs except mathematical operations signs and open brackets).

Basic supported mathematical operations:
* ```+```
* ```-```
* ```*```
* ```/```

## Usage
To start using framework, you have to initialize ```MGDecimalOperations``` object.
```
DecimalOperations *decimalOperations = [DecimalOperations new];
```
After that you will be able to use these two methods:
```
(NSDecimalNumber *)mathWithOperation:(NSString *)operation
                   variablesDecimal:(NSDictionary *)variables
                   error:(NSError **)error
```
```
(NSDecimalNumber *)mathWithOperation:(NSString *)operation
                   variablesString:(NSDictionary *)variables
                   error:(NSError **)error
```

The difference between them is that the first method accepts ```NSDictionary``` with ```NSDecimalNumbers``` and second accepts ```NSDictionary``` containing variables written in ```String``` (which will be converted to ```NSDecimalNumbers```).

To use these methods you also need to create a pointer to ```NSError``` and pass it to method.
```
NSError *error;
```

## Examples
### Using method with variablesDecimal parameter

* Perform mathWithOperation ```a + b``` where ```a = 2.321378923``` and ```b = 3.210932892```

```
NSDictionary *variables = @{
        @"a": [NSDecimalNumber decimalNumberWithString:@"2.321378923"],
        @"b": [NSDecimalNumber decimalNumberWithString:@"3.210932892"]
};
NSString *operation = @"a + b"

NSDecimalNumber *result = [deciamlOperations mathWithOperation:operation
                                             variablesDecimal:variables
                                             error:&error];
```

* Perform mathWithOperation ```alfa +((beta/gamma)* delta-(epsilon+dzeta )*eta)``` where ```alfa = 1```, ```beta = 2```, ```gamma = 3```, ```delta = 4```, ```epsilon = 5```, ```dzeta = 6```, ```eta = 7```.

```
NSDictionary *variables = @{
        @"alfa": [NSDecimalNumber decimalNumberWithString:@"1"],
        @"beta": [NSDecimalNumber decimalNumberWithString:@"2"],
        @"gamma": [NSDecimalNumber decimalNumberWithString:@"3"],
        @"delta": [NSDecimalNumber decimalNumberWithString:@"4"],
        @"epsilon": [NSDecimalNumber decimalNumberWithString:@"5"],
        @"dzeta": [NSDecimalNumber decimalNumberWithString:@"6"],
        @"eta": [NSDecimalNumber decimalNumberWithString:@"7"]
};
NSString *operation = @"alfa +((beta/gamma)* delta-(epsilon+dzeta )*eta)"

NSDecimalNumber *result = [decimalOperations mathWithOperation:operation
                                             variablesDecimal:variables
                                             error:&error];
```

### Using method with variablesString parameter

* Perform mathWithOperation ```a4a + 44g*g4g``` where ```a4a = 2```, ```44g = 4```, ```g4g = 5```.

```
NSDictionary *variables = @{
        @"a4a": @"2",
        @"44g": @"4",
        @"g4g": @"5"
};
NSString *operation = @"a4a + 44g*g4g"

NSDecimalNumber *result = [decimalOperations mathWithOperation:operation
                                             variablesString:variables
                                             error:&error];
```

## Author
[Maciej Gomółka](https://github.com/Zaprogramiacz) inspirated by [Dariusz Rybicki](https://github.com/darrarski).
