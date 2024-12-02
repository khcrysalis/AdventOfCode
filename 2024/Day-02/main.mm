#import <Foundation/Foundation.h>

void part1(NSString *filePath);
BOOL isReportSafe(NSArray<NSNumber *> *levels);

void part2(NSString *filePath);
BOOL isReportSafeButPart2(NSArray<NSNumber *> *levels);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argv[1] != NULL) {
            NSString *filePath = [NSString stringWithUTF8String:argv[1]];
            part1(filePath);
            part2(filePath);
        } else {
            return 1;
        }
    }
    return 0;
}

#pragma mark - Part 1: objective C(++) why does this haave to be so long what the fuck?

void part1(NSString *filePath) {
    NSError *error = nil;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"Error reading file at %@: %@", filePath, error.localizedDescription);
        return;
    }
    
    NSArray<NSString *> *reports = [fileContents componentsSeparatedByString:@"\n"];
    NSMutableArray<NSString *> *safeReports = [NSMutableArray array];

    NSCharacterSet *whitespaceAndNewlineCharacterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSString *report in reports) {
        NSString *trimmedReport = [report stringByTrimmingCharactersInSet:whitespaceAndNewlineCharacterSet];
        if (trimmedReport.length == 0) { continue;}
        
        NSArray<NSString *> *levelStrings = [trimmedReport componentsSeparatedByString:@" "];
        NSMutableArray<NSNumber *> *levels = [NSMutableArray arrayWithCapacity:levelStrings.count];
        for (NSString *levelString in levelStrings) {
            NSNumber *level = @([levelString integerValue]);
            [levels addObject:level];
        }
        
        if (isReportSafe(levels)) { [safeReports addObject:trimmedReport]; }
    }
    
    NSLog(@"Some of these r safe reports: %lu", (unsigned long)safeReports.count);
}
// this is ok
BOOL isReportSafe(NSArray<NSNumber *> *levels) {
    BOOL isIncreasing = YES;
    BOOL isDecreasing = YES;
    
    for (NSUInteger i = 0; i < levels.count - 1; i++) {
        NSInteger currentLevel = [levels[i] integerValue];
        NSInteger nextLevel = [levels[i + 1] integerValue];
        NSInteger diff = nextLevel - currentLevel;
        
        if (diff < -3 || diff > 3 || diff == 0) { return NO }
        
        if (diff > 0) {
            isDecreasing = NO;
        } else if (diff < 0) {
            isIncreasing = NO;
        }
    }
    
    return isIncreasing || isDecreasing;
}

#pragma mark - Part 2: ew

void part2(NSString *filePath) {
    NSError *error = nil;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

    if (error) {
        NSLog(@"Error reading file at %@: %@", filePath, error.localizedDescription);
        return;
    }

    NSArray<NSString *> *lines = [fileContents componentsSeparatedByString:@"\n"];
    NSUInteger safeReportCount = 0;

    for (NSString *line in lines) {
        if ([line length] == 0) { continue; }

        NSArray<NSString *> *levelStrings = [line componentsSeparatedByString:@" "];
        NSMutableArray<NSNumber *> *levels = [NSMutableArray array];

        for (NSString *levelString in levelStrings) { [levels addObject:@([levelString integerValue])]; }
        if (isReportSafeButPart2(levels)) { safeReportCount++; }
    }

    NSLog(@"Dampener shits: %lu", (unsigned long)safeReportCount);
}

BOOL isReportSafeButPart2(NSArray<NSNumber *> *levels) {
    if (isReportSafe(levels)) { return YES; }

    for (NSUInteger i = 0; i < levels.count; i++) {
        NSNumber *removedLevel = levels[i];
        NSMutableArray<NSNumber *> *modifiedLevels = [levels mutableCopy];
        [modifiedLevels removeObjectAtIndex:i];

        if (isReportSafe(modifiedLevels)) { return YES; }

        [modifiedLevels insertObject:removedLevel atIndex:i];
    }

    return NO;
}