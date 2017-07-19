//
//  JDHookCode.h
//  HookSystemCode
//
//  Created by 王金东 on 2016/7/19.
//  Copyright © 2016年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JDProperty : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) id value;
@end

@interface JDVar : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) id value;
@property (nonatomic,copy) NSString *type;
@end

@interface JDMethod : NSObject

@property (nonatomic,assign) SEL sel;//方法名称
@property (nonatomic,assign) IMP imp; // 方法的具体的实现的指针
@property (nonatomic,copy) NSString *type; // 参数和返回类型的描述字串
@end


@interface JDCode : NSObject
@property (nonatomic,strong) JDCode *superCode;

@property (nonatomic,copy) NSString *className;
@property (nonatomic,strong) NSArray<JDProperty *> *propertys;
@property (nonatomic,strong) NSArray<JDVar *> *vars;
@property (nonatomic,strong) NSArray<JDMethod *> *methods;
@end

@interface JDHookCode : NSObject

+ (JDCode *)hookClass:(NSObject *)obj;
+ (JDCode *)hookClassWithSuper:(NSObject *)obj;
@end
