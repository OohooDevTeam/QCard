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

//http://derekneely.com/2009/11/iphone-development-global-variables/

#import <UIKit/UIKit.h>

@interface Singleton : UIViewController{
    
    //SuperMemo algorithm variables
    //Old easiness factor
    double EF_prime;
    
    //New easiness factor
    double EF;
    
    //Words needing reviewing
    NSMutableArray *troubledWords;
    NSMutableArray *troubledAnswers;
    
    //Initial words
    NSMutableArray *initialWords;
    NSMutableArray *initialAnswers;
    
    //Have no trouble with
    NSMutableArray *easyWords;
    
    //Skipped words and answers
    NSMutableArray *skippedWords;
    NSMutableArray *skippedAnswers;
    
    //AnswerView
    NSMutableArray *answerArray;
    int index;
    
    //AuthenticateView
    //Hash Table
    NSMutableDictionary *courseName;
    NSMutableArray *files;
    
    //Total number of elements (words)
    NSUInteger elements;
    
    //Current array index
    NSUInteger array_index;
    
    BOOL initial_round;
    BOOL skipped_round;
    BOOL incorrect_round;
    
    //Server to connect to and download files
    NSString *serverName;
    
}

//Property declaration
@property (nonatomic, retain) NSMutableArray *troubledWords;
@property (nonatomic, retain) NSMutableArray *initialWords;
@property (nonatomic, retain) NSMutableArray *easyWords;
@property (nonatomic, retain) NSMutableArray *skippedWords;
@property (nonatomic, retain) NSMutableArray *troubledAnswers;
@property (nonatomic, retain) NSMutableArray *initialAnswers;
@property (nonatomic, retain) NSMutableArray *skippedAnswers;

//AnswerView
@property (nonatomic, retain) NSMutableArray *answerArray;
@property (nonatomic) int index;

//AuthenticateView
@property (nonatomic, retain) NSMutableDictionary *courseName;
@property (nonatomic, retain) NSMutableArray *files;

@property (nonatomic) NSUInteger elements;
@property (nonatomic) NSUInteger array_index;

@property (nonatomic, assign) BOOL initial_round;
@property (nonatomic, assign) BOOL skipped_round;
@property (nonatomic, assign) BOOL incorrect_round;

@property (nonatomic, copy) NSString *serverName;

//Global variable
+ (Singleton *) globalVar;

@end
