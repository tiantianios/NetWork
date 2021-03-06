//
//  ServiceRoot.m
//  NetWork
//
//  Created by tianxiuping on 2017/11/1.
//  Copyright © 2017年 TXP. All rights reserved.
//

#import "ServiceRoot.h"
#import "TBXML.h"
#import "MetadataUrlProvider.h"
#define kWebSiteURLDefine @""
static NSMutableDictionary *methods;
static id <UrlProvider> _urlProvider;

@implementation ServiceRoot

+ (void)load
{
    [ServiceRoot loadServiceMethod];
}

+ (void)loadServiceMethod
{
    NSError *error;
    TBXML *root = [TBXML tbxmlWithXMLFile:@"service_metadata.xml" error:&error];
    
    TBXMLElement *rootElement = root.rootXMLElement;
    
    _urlProvider = (id<UrlProvider>)[[NSClassFromString([TBXML valueOfAttributeNamed:@"UrlProvider" forElement:rootElement]) alloc] init];
    
    BOOL isExclusive;
    NSString *httpMethod;
    NSString *message;
    BOOL showWaitBox;
    BOOL showError;
    int timeout = 0;
    NSString *timeoutMessage;
    NSString *fallbackMessage;
    
    if (rootElement)
    {
        TBXMLElement *defaults = [TBXML childElementNamed:@"Defaults" parentElement:rootElement];
        if (defaults)
        {
            isExclusive = [[TBXML valueOfAttributeNamed:@"IsExclusive" forElement:defaults] boolValue];
            httpMethod = [TBXML valueOfAttributeNamed:@"Method" forElement:defaults];
            message = [TBXML valueOfAttributeNamed:@"Message" forElement:defaults];
            showWaitBox = [[TBXML valueOfAttributeNamed:@"ShowWaitBox" forElement:defaults] boolValue];
            showError = [[TBXML valueOfAttributeNamed:@"ShowError" forElement:defaults] boolValue];
            timeout = [[TBXML valueOfAttributeNamed:@"Timeout" forElement:defaults] intValue];
            timeoutMessage = [TBXML valueOfAttributeNamed:@"TimeoutMessage" forElement:defaults];
            fallbackMessage = [TBXML valueOfAttributeNamed:@"FallbackMessage" forElement:defaults];
        }
    }
    
    if ([[_urlProvider class] isSubclassOfClass:[MetadataUrlProvider class]])
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        TBXMLElement *urls = [TBXML childElementNamed:@"Urls" parentElement:rootElement];
        
        TBXMLElement *url = urls->firstChild;
        
        while (url) {
            
            [dict setObject:[[NSString stringWithCString:url->text encoding:NSUTF8StringEncoding] isEqualToString:@"http:"]?kWebSiteURLDefine:[NSString stringWithCString:url->text encoding:NSUTF8StringEncoding] forKey:[TBXML valueOfAttributeNamed:@"Name" forElement:url]];
            
            url = url->nextSibling;
            
        }
        
        ((MetadataUrlProvider *)_urlProvider).mappings = dict;
    }
    
    methods = [[NSMutableDictionary alloc] init];
    
    TBXMLElement *ServiceMethods = [TBXML childElementNamed:@"ServiceMethods" parentElement:rootElement];
    
    TBXMLElement *serviceMethod = ServiceMethods->firstChild;
    
    while (serviceMethod) {
        
        ServiceMethod *method = [[ServiceMethod alloc] init];
        
        method.name = [TBXML valueOfAttributeNamed:@"UrlDomain" forElement:serviceMethod];
                
        method.method = [TBXML valueOfAttributeNamed:@"Method" forElement:serviceMethod]?[TBXML valueOfAttributeNamed:@"Method" forElement:serviceMethod]:httpMethod;
        
        method.message = [TBXML valueOfAttributeNamed:@"Message" forElement:serviceMethod];
        
        method.showErrorMessage = [[TBXML valueOfAttributeNamed:@"ShowError" forElement:serviceMethod] boolValue];
        
        method.timeout = [[TBXML valueOfAttributeNamed:@"Timeout" forElement:serviceMethod] intValue] ? [[TBXML valueOfAttributeNamed:@"Timeout" forElement:serviceMethod] intValue] : timeout;
        
        method.returnType = [TBXML valueOfAttributeNamed:@"ReturnType" forElement:serviceMethod];
        
        method.timeoutMessage = [TBXML valueOfAttributeNamed:@"TimeoutMessage" forElement:serviceMethod];
        
        method.parameters = [TBXML valueOfAttributeNamed:@"Parameters" forElement:serviceMethod];
        
        method.fallbackMessage = [TBXML valueOfAttributeNamed:@"FallbackMessage" forElement:serviceMethod] ? [TBXML valueOfAttributeNamed:@"FallbackMessage" forElement:serviceMethod] : fallbackMessage;
                
        method.isCookieEnabled = [[TBXML valueOfAttributeNamed:@"IsCookieEnabled" forElement:serviceMethod] boolValue];
        
        method.url = [NSString stringWithFormat:@"%@%@/%@",[((MetadataUrlProvider *)_urlProvider).mappings objectForKey:[TBXML valueOfAttributeNamed:@"Url" forElement:serviceMethod]],[TBXML valueOfAttributeNamed:@"UrlPath" forElement:serviceMethod],[TBXML valueOfAttributeNamed:@"UrlDomain" forElement:serviceMethod]];

        [methods setObject:method forKey:method.name];
        
        serviceMethod = serviceMethod->nextSibling;
    }
}

+ (ServiceMethod *)findMethod:(NSString *)methodName
{
    return [methods objectForKey:methodName];
}

+ (NSString *)getHostURLWithName:(NSString *)name
{
    return [_urlProvider urlForUrlID:name];
}

@end
