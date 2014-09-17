
#import "BBConditionNumeric.h"
#import "BBTextInputFormElement.h"

@implementation BBConditionNumeric


- (BOOL)check:(BBFormElement *)element;
{
    if (![element isKindOfClass:[BBTextInputFormElement class]])
        return NO;
    NSString *string = ((BBTextInputFormElement*)element).value;
    
    if (nil == string)
    {
        return NO;
    }
    
    self.regexString = @"\\d+";
    
    return [super check:element];
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationNumeric", nil);
}


@end
