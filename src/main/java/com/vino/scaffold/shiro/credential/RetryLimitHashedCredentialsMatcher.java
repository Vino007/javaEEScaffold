package com.vino.scaffold.shiro.credential;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;

import com.vino.scaffold.entity.Constants;

import java.util.concurrent.atomic.AtomicInteger;


public class RetryLimitHashedCredentialsMatcher extends HashedCredentialsMatcher {

    private Cache<String, AtomicInteger> passwordRetryCache;//缓存使用的是Ehcache
    
    public RetryLimitHashedCredentialsMatcher(CacheManager cacheManager) {
        passwordRetryCache = cacheManager.getCache("passwordRetryCache");//在Ehcache中有定义
       
    }

    @Override
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {
        String username = (String)token.getPrincipal();
       
        //retry count + 1
        AtomicInteger retryCount = passwordRetryCache.get(username);
        if(retryCount == null) {
            retryCount = new AtomicInteger(0);
            passwordRetryCache.put(username, retryCount);//初始化缓存
            
        }  
        if(retryCount.incrementAndGet() > Constants.PASSWORD_RETRY_MAX) {              
         
            throw new ExcessiveAttemptsException();//超过PASSWORD_RETRY_MAX次抛出异常，锁定1小时，时间在timeToIdleSeconds中设置
        }
        boolean matches = super.doCredentialsMatch(token, info);
        if(matches) { //如果密码成功则将retryCount缓存清空
            //clear retry count
            passwordRetryCache.remove(username);
        }     
        return matches;
    }
}
