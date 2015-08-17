//
//  VOKEmbeddedTemplateToolsTests.m
//  VOKEmbeddedTemplateToolsTests
//
//  Created by Isaac Greenspan on 8/16/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import <GRMustache.h>
#import <VOKZZArchiveTemplateRepository.h>
#import <ZZArchive+VOKMachOEmbedded.h>

@interface VOKEmbeddedTemplateToolsTests : XCTestCase

@end

@implementation VOKEmbeddedTemplateToolsTests

- (void)testExample
{
    NSError *error;
    ZZArchive *archive = [ZZArchive vok_archiveFromMachOSection:@"__test_zip"
                                                          error:&error];
    XCTAssertNotNil(archive);
    XCTAssertNil(error);
    
    VOKZZArchiveTemplateRepository *templateRepo = [VOKZZArchiveTemplateRepository templateRepositoryWithArchive:archive];
    XCTAssertNotNil(templateRepo);
    
    GRMustacheTemplate *template = [templateRepo templateNamed:@"test" error:&error];
    XCTAssertNotNil(template);
    XCTAssertNil(error);
    
    NSString *result = [template renderObject:nil error:&error];
    XCTAssertNotNil(result);
    XCTAssertNil(error);
    
    NSString *expectedResult = [NSString stringWithContentsOfURL:[[NSBundle bundleForClass:[self class]]
                                                                  URLForResource:@"test"
                                                                  withExtension:@"mustache"]
                                                        encoding:NSUTF8StringEncoding
                                                           error:&error];
    XCTAssertNotNil(expectedResult);
    XCTAssertNil(error);
    
    XCTAssertEqualObjects(result, expectedResult);
}

@end
