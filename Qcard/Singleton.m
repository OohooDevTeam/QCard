/**
 **************************************************************************
 **                              QCard                                   **
 **************************************************************************
 * @package     app                                                      **
 * @subpackage  N/A                                                      **
 * @name        QCard                                                    **
 * @copyright   oohoo.biz                                                **
 * @link        http://oohoo.biz                                         **
 * @author      Theodore Pham                                            **
 * @license     http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later **
 **************************************************************************
 **************************************************************************/

//This is a class that can ONLY have one instance throughout the program
#import "Singleton.h"

@interface Singleton ()

@end

static Singleton *globalVar= nil;

@implementation Singleton

@synthesize answerArray;
@synthesize index;

@synthesize courseName;
@synthesize files;

@synthesize troubledWords;
@synthesize initialWords;
@synthesize easyWords;
@synthesize skippedWords;
@synthesize troubledAnswers;
@synthesize initialAnswers;
@synthesize skippedAnswers;

@synthesize elements;
@synthesize array_index;

@synthesize initial_round;
@synthesize skipped_round;
@synthesize incorrect_round;

@synthesize serverName;

#pragma mark -
#pragma mark Singleton Methods
+ (Singleton *)globalVar {
    if(globalVar == nil){
        globalVar = [[super allocWithZone:NULL] init];
    }
    return globalVar;
}

@end
