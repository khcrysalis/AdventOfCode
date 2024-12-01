#import <Foundation/Foundation.h>

void part1(NSString *filePath);
void part2(NSString *filePath);

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

void part1(NSString *filePath) {
    NSError *error = nil;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"Error reading file at %@: %@", filePath, error.localizedDescription);
        return;
    }
    
    NSArray *lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray *leftNumbers = [NSMutableArray array];
    NSMutableArray *rightNumbers = [NSMutableArray array];

    for (NSString *line in lines) {
        NSArray *numbers = [[line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
        if (numbers.count == 2) {
            [leftNumbers addObject:@([numbers[0] integerValue])];
            [rightNumbers addObject:@([numbers[1] integerValue])];
        }
    }

    [leftNumbers sortUsingSelector:@selector(compare:)];
    [rightNumbers sortUsingSelector:@selector(compare:)];

    NSInteger totalDifference = 0;
    for (NSInteger i = 0; i < leftNumbers.count; i++) {
        totalDifference += labs([leftNumbers[i] integerValue] - [rightNumbers[i] integerValue]);
    }

    NSLog(@"Total distance from that insane txt: %ld", (long)totalDifference);
}

void part2(NSString *filePath) {
    NSError *error = nil;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

    if (error) {
        NSLog(@"Error reading file at %@: %@", filePath, error.localizedDescription);
        return;
    }

    NSArray *lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray *leftNumbers = [NSMutableArray array];
    NSMutableArray *rightNumbers = [NSMutableArray array];

    for (NSString *line in lines) {
        NSArray *numbers = [[line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
        if (numbers.count == 2) {
            [leftNumbers addObject:@([numbers[0] integerValue])];
            [rightNumbers addObject:@([numbers[1] integerValue])];
        }
    }

    NSCountedSet *rightNumberCounts = [[NSCountedSet alloc] initWithArray:rightNumbers];
    NSInteger similarityScore = 0;

    for (NSNumber *leftNumber in leftNumbers) {
        similarityScore += [leftNumber integerValue] * [rightNumberCounts countForObject:leftNumber];
    }

    NSLog(@"Total similarity score from that insane txt: %ld", (long)similarityScore);
}