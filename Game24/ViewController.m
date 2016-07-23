//
//  ViewController.m
//  Game24
//
//  Created by Ping on 23/07/2016.
//  Copyright © 2016 Pinggeek. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, OperationType) {
    firstType = 0,
    
    addition,
    subtraction,
    multiplication,
    division,
    reverseSub,
    reverseDiv,
    
    lastType = reverseDiv
};

@interface ViewController (){
    BOOL is24;
    NSMutableArray *resultArr;
    NSString *firstResultString;
    NSString *secondResultString;
    NSString *thirdResultString;
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    resultArr = [[NSMutableArray alloc] init];
    [self generateValidRandomNumbers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSMutableArray *)generateValidRandomNumbers{
    BOOL isValid = false;
    NSMutableArray *validNumbers = [[NSMutableArray alloc] init];
    while (isValid == false) {
        NSMutableArray * numArr = [[NSMutableArray alloc] init];
        for (NSInteger i=0; i<4; i++) {
            int num = arc4random() % 13 + 1;
            [numArr addObject:@(num)];
        }
        isValid = [self check24Points:numArr];
        NSLog(@"%@ BOOL:%@",numArr,@(isValid));
        if (isValid) {
            validNumbers = [numArr mutableCopy];
        }
    };
    
    return validNumbers;
}


- (BOOL)check24Points:(NSMutableArray*)numArr {
    NSInteger count = numArr.count;
    if (count == 1 && [numArr[0] doubleValue] == 24) {
        is24 = true;
        NSLog(@"Result:%@ \n%@ \n%@",firstResultString,secondResultString, thirdResultString);
    }
    for (NSInteger i=0; i<count; i++) {
        for (NSInteger j=i+1; j<count; j++){
            for (NSInteger k=firstType; is24 == false &&  k<lastType; k++ ){
                NSMutableArray *newArr = [numArr mutableCopy];
                double numA = [newArr[i] doubleValue];
                double numB = [newArr[j] doubleValue];
                double result = [self calculateWithType:k forNumber:numA andNumber:numB];
                
                [newArr removeObjectAtIndex:j];
                [newArr removeObjectAtIndex:i];
                [newArr addObject:@(result)];
                
                NSString *tempStr = [NSString stringWithFormat:@"%0.2f (%i) %0.2f = %0.2f", numA,k,numB,result];
                if (newArr.count ==3){
                    firstResultString = tempStr;
                }
                if (newArr.count ==2){
                    secondResultString = tempStr;
                }
                if (newArr.count == 1) {
                    thirdResultString = tempStr;
                }
                
                
                [self check24Points:newArr];
            }
        }
    }
    
    return is24;
}



- (double)calculateWithType:(OperationType)type forNumber:(double)numA andNumber:(double)numB{
    double result;
    switch (type) {
        case 0:
            result = numA + numB;
            break;
        case 1:
            result = numA - numB;
            break;
        case 2:
            result = numA * numB;
            break;
        case 3:
            if (numB != 0) {
                result = numA / numB;
            }
            break;
        case 4:
            result = numB - numA;
            break;
        case 5:
            if (numA != 0) {
                result = numB / numA;
            }
            break;
        default:
            break;
    }
    return result;
}



@end





