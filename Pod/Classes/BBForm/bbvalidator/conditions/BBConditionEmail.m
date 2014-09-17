
#import "BBConditionEmail.h"
#import "BBTextInputFormElement.h"

@implementation BBConditionEmail


- (BOOL)check:(BBFormElement *)element;
{
    if (![element isKindOfClass:[BBTextInputFormElement class]])
        return NO;
    NSString *string = ((BBTextInputFormElement*)element).value;
    
    if (nil == string)
        string = [NSString string];
    
    self.regexString = @"^[+\\w\\.\\-']+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*(\\.[a-zA-Z]{2,})+$";
    
    return [super check:element];
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationEmail", nil);
}

@end
