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
  NSMutableArray *_arrayToQuickSort;
  NSUInteger _remainingHeapCount;
  NSMutableArray *_quickSortedArray;
}

-(NSMutableArray *)quickSortThisArray:(NSMutableArray *)thisArray {
  
  if ([thisArray count] <= 1) {
    return thisArray;
  }
  
  NSNumber *pivotNumber = thisArray[[thisArray count] / 2];
  
  [thisArray removeObject:pivotNumber];
  
  NSMutableArray *allLowerNumbers = [[NSMutableArray alloc] initWithCapacity:2];
  NSMutableArray *allHigherNumbers = [[NSMutableArray alloc] initWithCapacity:2];
  
  for (NSNumber *thisNumber in thisArray) {
    if ([thisNumber integerValue] <= [pivotNumber integerValue]) {
      [allLowerNumbers addObject:thisNumber];
    } else {
      [allHigherNumbers addObject:thisNumber];
    }
  }
  
  NSArray *tempArray = [NSArray new];
  tempArray = [tempArray arrayByAddingObjectsFromArray:[self quickSortThisArray:allLowerNumbers]];
  tempArray = [tempArray arrayByAddingObjectsFromArray:@[pivotNumber]];
  tempArray = [tempArray arrayByAddingObjectsFromArray:[self quickSortThisArray:allHigherNumbers]];
  return [NSMutableArray arrayWithArray:tempArray];
}

-(void)viewDidLoad {
  [super viewDidLoad];
  
  _arrayToHeapSort = [[NSMutableArray alloc] initWithCapacity:2];
  _arrayToQuickSort = [[NSMutableArray alloc] initWithCapacity:2];
  _quickSortedArray = [[NSMutableArray alloc] initWithCapacity:2];
  
  for (int i = 0; i < 100; i++) {
    NSUInteger randomInteger = arc4random_uniform(500);
    NSNumber *numberObject = [NSNumber numberWithUnsignedInteger:randomInteger];
    if (![_arrayToHeapSort containsObject:numberObject]) {
      [_arrayToHeapSort addObject:numberObject];
//      NSLog(@"adding number object %@", numberObject);
    }
  }
  
  _remainingHeapCount = [_arrayToHeapSort count];
  
  NSLog(@"Unsorted heapSort array is %@, count is %i", _arrayToHeapSort, [_arrayToHeapSort count]);
  
  for (int i = ([_arrayToHeapSort count] - 1) / 2;i >= 0; i--) {
    [self maxHeapifyForIndex:i];
  }

  [self sortRemainingHeap];
  
  NSLog(@"Sorted heapSort array is %@, count is %i", _arrayToHeapSort, [_arrayToHeapSort count]);
  
  for (int i = 0; i < 100; i++) {
    NSUInteger randomInteger = arc4random_uniform(500);
    NSNumber *numberObject = [NSNumber numberWithUnsignedInteger:randomInteger];
    if (![_arrayToQuickSort containsObject:numberObject]) {
      [_arrayToQuickSort addObject:numberObject];
        //      NSLog(@"adding number object %@", numberObject);
    }
  }
  
  NSLog(@"unsorted quickSort array is %@, count is %i", _arrayToQuickSort, [_arrayToQuickSort count]);
  _quickSortedArray = [self quickSortThisArray:_arrayToQuickSort];
  NSLog(@"sorted quickSort array is %@, count is %i", _quickSortedArray, [_quickSortedArray count]);
}

-(void)maxHeapifyForIndex:(NSUInteger)index {
  int leftChildIndex = 2 * index + 1;
  int rightChildIndex = 2 * index + 2;
  NSNumber *largestNumber = _arrayToHeapSort[index];
  
  if (leftChildIndex < _remainingHeapCount) {
    NSNumber *leftChildNumber = _arrayToHeapSort[leftChildIndex];
    if ([leftChildNumber integerValue] > [largestNumber integerValue]) {
      largestNumber = leftChildNumber;
    }
  }

  if (rightChildIndex < _remainingHeapCount) {
    NSNumber *rightChildNumber = _arrayToHeapSort[rightChildIndex];
    if ([rightChildNumber integerValue] > [largestNumber integerValue]) {
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
  for (int i = [_arrayToHeapSort count] - 1; i >= 0; i--) {
    [_arrayToHeapSort exchangeObjectAtIndex:0 withObjectAtIndex:i];
//    NSLog(@"max number at i is %@", [_arrayToHeapSort objectAtIndex:i]);
    _remainingHeapCount--;
//    NSLog(@"remaining heap count %i", _remainingHeapCount);
    [self maxHeapifyForIndex:0];
  }
}

-(void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
