package com.itheima.stock.vo.req;

import lombok.Data;

/**
 * @author : itheima
 * @date : 2022/9/19 17:21
 * @description : 登录时请求参数封装vo-value object view-object
 */
@Data
public class LoginReqVo {
    /**
     * 用户名
     */
    private String username;
    /**
     * 密码
     */
    private String password;
   private String code;
//    private String rkey;
}
