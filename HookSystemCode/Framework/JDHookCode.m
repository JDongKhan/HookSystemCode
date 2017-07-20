//
//  JDHookCode.m
//  HookSystemCode
//
//  Created by 王金东 on 2016/7/19.
//  Copyright © 2016年 王金东. All rights reserved.
//

#import "JDHookCode.h"


struct jd_objc_method {
    SEL method_name;        // 方法名称
    const char *method_types;    // 参数和返回类型的描述字串
    IMP method_imp;         // 方法的具体的实现的指针
};


@implementation JDProperty
- (NSString *)description {
    return [NSString stringWithFormat:@"%@=%@",self.name,self.value];
}
- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@=%@",self.name,self.value];
}
- (instancetype)initWithProperty:(objc_property_t)property object:(NSObject *)obj{
    if (self = [super init]) {
        _property = property;
        const char *name = property_getName(property);
        _name = [NSString stringWithUTF8String:name];
        if (_name.length) {
            if (!_getter) {
                _getter = NSSelectorFromString(_name);
            }
            if (!_setter) {
                _setter = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [_name substringToIndex:1].uppercaseString, [_name substringFromIndex:1]]);
            }
        }
        NSString *attrs = @(property_getAttributes(property));
        NSUInteger dotLoc = [attrs rangeOfString:@","].location;
        NSString *code = nil;
        NSUInteger loc = 1;
        if (dotLoc == NSNotFound) { // 没有,
            code = [attrs substringFromIndex:loc];
        } else {
            code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
        }
        _typeEncoding = code;
        
        @try {
            _value = [obj valueForKey:_name];
        } @catch (NSException *exception) {
            NSLog(@"property[%@] no have value",_name);
        } @finally {
        }
        
    }
    return self;
}
@end
@implementation JDVar
- (NSString *)description {
    return [NSString stringWithFormat:@"%@=%@",self.name,self.value];
}
- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@=%@",self.name,self.value];
}
- (instancetype)initWithVar:(Ivar)var object:(NSObject *)obj{
    if (self = [super init]) {
        //得到这个成员变量的类型
        const char *type = ivar_getTypeEncoding(var);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        _type = stringType;
        //得到成员变量名
        _name = [NSString stringWithUTF8String:ivar_getName(var)];
        const char *typeEncoding = ivar_getTypeEncoding(var);
        if (typeEncoding) {
            _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
        }
        @try {
            _value = [obj valueForKey:_name];
        }@catch (NSException *exception) {
            NSLog(@"var[%@] no have value",_name);
        } @finally {
            
        }

    }
    return self;
}
@end
@implementation JDMethod
- (NSString *)description {
    return [NSString stringWithFormat:@"%@=%@",NSStringFromSelector(self.sel),self.type];
}
- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@=%@",NSStringFromSelector(self.sel),self.type];
}
- (instancetype)initWithMethod:(Method)method {
    if (self = [super init]) {
        struct jd_objc_method *m = (struct jd_objc_method *)method;
        _sel  = m->method_name;
        _type = [NSString stringWithUTF8String:m->method_types];
        _imp = m->method_imp;
        const char *name = sel_getName(_sel);
        if (name) {
            _name = [NSString stringWithUTF8String:name];
        }
        char *returnType = method_copyReturnType(method);
        if (returnType) {
            _returnTypeEncoding = [NSString stringWithUTF8String:returnType];
            free(returnType);
        }
        unsigned int argumentCount = method_getNumberOfArguments(method);
        if (argumentCount > 0) {
            NSMutableArray *argumentTypes = [NSMutableArray new];
            for (unsigned int i = 0; i < argumentCount; i++) {
                char *argumentType = method_copyArgumentType(method, i);
                NSString *type = argumentType ? [NSString stringWithUTF8String:argumentType] : nil;
                [argumentTypes addObject:type ? type : @""];
                if (argumentType) free(argumentType);
            }
            _argumentTypeEncodings = argumentTypes;
        }

    }
    return self;
}
@end


@implementation JDClass
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

+ (JDClass *)hookClass:(NSObject *)obj class:(Class)clss {
    JDClass *code = [[JDClass alloc] init];
    code.className = NSStringFromClass(clss);
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
        JDMethod *jdM = [[JDMethod alloc] initWithMethod:method];
        [methodArray addObject:jdM];
    }
    //处理属性
    NSMutableArray *propertyArray = [NSMutableArray array];
    for(unsigned int i = 0; i < propertyCount;i++){
        objc_property_t property = properties[i];
        JDProperty *p = [[JDProperty alloc] initWithProperty:property object:obj];
        [propertyArray addObject:p];
    }
    //处理变量
    NSMutableArray *varArray = [NSMutableArray array];
    for(unsigned int i = 0; i < varCount;i++){
        Ivar var = ivars[i];
        JDVar *v = [[JDVar alloc] initWithVar:var object:obj];
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


@implementation JDHookCode


+ (JDClass *)hookClass:(NSObject *)obj {
   return [JDHookCode hookClass:obj supportSuper:NO];
}

+ (JDClass *)hookClassWithSuper:(NSObject *)obj {
    return [JDHookCode hookClass:obj supportSuper:YES];
}



+ (JDClass *)hookClass:(NSObject *)obj supportSuper:(BOOL)supportSuper{
    if (!obj) return nil;
    
    Class clss = object_getClass(obj);
    static CFMutableDictionaryRef classCache;
    static dispatch_once_t onceToken;
    static dispatch_semaphore_t lock;
    dispatch_once(&onceToken, ^{
        classCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
    });
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    __weak id key = obj;
    JDClass *code = CFDictionaryGetValue(classCache, (__bridge const void *)(key));
    dispatch_semaphore_signal(lock);
    if(supportSuper && code.superCode == nil)code = nil;
    if (!code) {
        //hook
        JDClass *currentCode = nil;
        do{
            JDClass *c = [JDClass hookClass:obj class:clss];
            if(code == nil){
                code = c;
            }
            if(!supportSuper)break;
            currentCode.superCode = c;
            currentCode = c;
            clss = class_getSuperclass(clss);
        }while (clss);
        
        
        if (code) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            CFDictionarySetValue(classCache, (__bridge const void *)(key), (__bridge const void *)(code));
            dispatch_semaphore_signal(lock);
        }
    }
    return code;
}






@end
