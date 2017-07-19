//
//  JDHookCode.m
//  HookSystemCode
//
//  Created by 王金东 on 2016/7/19.
//  Copyright © 2016年 王金东. All rights reserved.
//

#import "JDHookCode.h"
#import <objc/runtime.h>

struct jd_objc_method {
    SEL method_name;        // 方法名称
    const char *method_typesE;    // 参数和返回类型的描述字串
    IMP method_imp;         // 方法的具体的实现的指针
};


@implementation JDProperty
- (NSString *)description {
    return [NSString stringWithFormat:@"%@=%@",self.name,self.value];
}
- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@=%@",self.name,self.value];
}
@end
@implementation JDVar
- (NSString *)description {
    return [NSString stringWithFormat:@"%@=%@",self.name,self.value];
}
- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@=%@",self.name,self.value];
}
@end
@implementation JDMethod
- (NSString *)description {
    return [NSString stringWithFormat:@"%@=%@",NSStringFromSelector(self.sel),self.type];
}
- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@=%@",NSStringFromSelector(self.sel),self.type];
}
@end
@implementation JDCode



- (NSString *)description {
    return [self descriptionPrivate];
}
- (NSString *)debugDescription {
    return [self descriptionPrivate];
}
- (NSString *)descriptionPrivate {
    NSMutableString *str = [NSMutableString stringWithString:@"{"];
    [str appendFormat:@"\r\n *******vars***********"];
    for (unsigned int i = 0; i < self.vars.count; i++) {
        JDVar *v = self.vars[i];
        [str appendFormat:@"\r\n \"%@\" = %@,\n",v.name, v.value];
    }
    [str appendFormat:@"\r\n ******properties*****"];
    for (unsigned int i = 0; i < self.propertys.count; i++) {
        JDProperty *p = self.propertys[i];
        [str appendFormat:@"\r\n \"%@\" = %@,\n",p.name, p.value];
    }
    [str appendFormat:@"\r\n *******methods******"];
    for (unsigned int i = 0; i < self.methods.count; i++) {
        JDMethod *m = self.methods[i];
        [str appendFormat:@"\r\n \"%@\":%@,\n",NSStringFromSelector(m.sel),m.type];
    }
    
    [str appendFormat:@"\r\n *******superclass******"];
    if (self.superCode) {
        [str appendFormat:@"\r\n%@",self.superCode.description];
    }
    [str appendString:@"\r\n}"];
    return str;
}



@end


@implementation JDHookCode


+ (JDCode *)hookClass:(NSObject *)obj {
    Class clss = object_getClass(obj);
    return  [self hookClass:obj class:clss];
}

+ (JDCode *)hookClassWithSuper:(NSObject *)obj {

    JDCode *code = [self hookClass:obj];
    
    Class clss = object_getClass(obj);
    Class superClass = class_getSuperclass(clss);
    JDCode *currentCode = code;
    while (superClass) {
        JDCode *c = [self hookClass:obj class:superClass];
        currentCode.superCode = c;
        currentCode = c;
        superClass = class_getSuperclass(superClass);
    }
    return code;
}

+ (JDCode *)hookClass:(NSObject *)obj class:(Class)clss {
    JDCode *code = [[JDCode alloc] init];
    unsigned int methodCount;
    Method *methods = class_copyMethodList(clss, &methodCount);
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(clss, &propertyCount);
    unsigned int varCount;
    Ivar *ivars = class_copyIvarList(clss, &varCount);
    
    //处理方法
    NSMutableArray *methodArray = [NSMutableArray array];
    for(unsigned int i = 0; i < methodCount;i++){
        Method method = methods[i];
        struct jd_objc_method *m = (struct jd_objc_method *)method;
        JDMethod *jdM = [[JDMethod alloc] init];
        jdM.sel  = m->method_name;
        jdM.type = [NSString stringWithUTF8String:m->method_typesE];
        jdM.imp = m->method_imp;
        [methodArray addObject:jdM];
    }
    //处理属性
    NSMutableArray *propertyArray = [NSMutableArray array];
    for(unsigned int i = 0; i < propertyCount;i++){
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        JDProperty *p = [[JDProperty alloc] init];
        p.name = [NSString stringWithUTF8String:name];
        @try {
             p.value = [obj valueForKey:p.name];
        } @catch (NSException *exception) {
            NSLog(@"property[%@] no have value",p.name);
        } @finally {
        }
       
        [propertyArray addObject:p];
    }
    //处理变量
    NSMutableArray *varArray = [NSMutableArray array];
    for(unsigned int i = 0; i < varCount;i++){
        Ivar var = ivars[i];
        JDVar *v = [[JDVar alloc] init];
        //得到这个成员变量的类型
        const char *type = ivar_getTypeEncoding(var);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        v.type = stringType;
        //得到成员变量名
        v.name = [NSString stringWithUTF8String:ivar_getName(var)];
        @try {
            v.value = [obj valueForKey:v.name];
        }@catch (NSException *exception) {
             NSLog(@"var[%@] no have value",v.name);
        } @finally {
        }
        [varArray addObject:v];
    }
    
    code.methods = methodArray;
    code.propertys = propertyArray;
    code.vars = varArray;
    free(methods);
    free(properties);
    free(ivars);
    return code;

}



@end
