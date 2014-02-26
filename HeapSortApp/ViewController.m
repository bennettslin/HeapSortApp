//
//  ViewController.m
//  HeapSortApp
//
//  Created by Bennett Lin on 2/26/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
  NSMutableArray *_arrayToHeapSort;
  NSUInteger _remainingHeapCount;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _arrayToHeapSort = [[NSMutableArray alloc] initWithCapacity:2];
  
  for (int i = 0; i < 20; i++) {
    NSUInteger randomInteger = arc4random_uniform(50);
    NSNumber *numberObject = [NSNumber numberWithUnsignedInteger:randomInteger];
    if (![_arrayToHeapSort containsObject:numberObject]) {
      [_arrayToHeapSort addObject:numberObject];
      NSLog(@"adding number object %@", numberObject);
    }
  }
  _remainingHeapCount = [_arrayToHeapSort count];
  
  for (int i = (([_arrayToHeapSort count] - 1) / 2);i >= 0; i--) {
    [self maxHeapifyForIndex:i];
  }

  [self sortRemainingHeap];
  
  NSLog(@"%@", _arrayToHeapSort);
}

-(void)maxHeapifyForIndex:(NSUInteger)index {
  int leftChildIndex = 2 * index + 1;
  int rightChildIndex = 2 * index + 2;
  NSNumber *largestNumber = _arrayToHeapSort[index];
  
  if (leftChildIndex < _remainingHeapCount) {
    NSNumber *leftChildNumber = _arrayToHeapSort[leftChildIndex];
    if (leftChildNumber > largestNumber) {
      largestNumber = leftChildNumber;
    }
  }

  if (rightChildIndex < _remainingHeapCount) {
    NSNumber *rightChildNumber = _arrayToHeapSort[rightChildIndex];
    if (rightChildNumber > largestNumber) {
      largestNumber = rightChildNumber;
    }
  }
  
  if (largestNumber != _arrayToHeapSort[index]) {
    NSUInteger indexOfLargestNumber = [_arrayToHeapSort indexOfObject:largestNumber];
    [_arrayToHeapSort exchangeObjectAtIndex:index withObjectAtIndex:indexOfLargestNumber];
    [self maxHeapifyForIndex:indexOfLargestNumber];
  }
}

-(void)sortRemainingHeap {
  for (int i = [_arrayToHeapSort count] - 1; i > 0; i--) {
    [_arrayToHeapSort exchangeObjectAtIndex:0 withObjectAtIndex:i];
    NSLog(@"max number at i is %@", [_arrayToHeapSort objectAtIndex:i]);
    _remainingHeapCount--;
    NSLog(@"remaining heap count %i", _remainingHeapCount);
    [self maxHeapifyForIndex:0];
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
