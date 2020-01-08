package cn.geek51.controller;

import cn.geek51.domain.PageHelper;
import cn.geek51.domain.UserAuth;
import cn.geek51.service.IUserAuthService;
import cn.geek51.util.ResponseUtil;
import cn.geek51.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.xml.ws.Response;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class UserAuthController {
    @Autowired
    IUserAuthService service;

    @PostMapping("/auths/login")
    public Object login(String username, String password) {
        UserAuth auth = null;
        try {
            auth = service.login(username, password);
        } catch (RuntimeException e) {
            return ResponseUtil.general_response("login fail!", ResponseUtil.CODE_ERROR);
        }
        return ResponseUtil.general_response("login success!", auth);
    }

    @GetMapping("/auths/logout")
    public Object logout() {
        try {
            UserContext.doLogout();
            return ResponseUtil.general_response("logout success!");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseUtil.general_response("logout fail!", ResponseUtil.CODE_ERROR);
        }

    }

    // 新建管理员
    @PostMapping("/auths")
    public Object postUserAuths(UserAuth auth) {
        System.out.println(auth);
        service.save(auth);
        return ResponseUtil.general_response("success create userauth!");
    }
    // 查询
    @GetMapping("/auths")
    public Object getUserAuths(PageHelper pageHelper) {
        Map<Object, Object> map = pageHelper.getMap();
        List<UserAuth> userAuthList = service.listAll(map);
        if (map == null) map = new HashMap<>();
        else map.clear();
        map.put("size", service.count());
        return ResponseUtil.general_response(userAuthList, map);
    }
    @GetMapping("/auths/{id}")
    public Object getUserAuth(@PathVariable("id") Integer id) {
        UserAuth userAuth = service.listOneById(id);
        return ResponseUtil.general_response(userAuth);
    }

    // 更新
    @PutMapping("/auths/{id}")
    public Object updateUserAuth(@PathVariable("id") Integer id, @RequestBody UserAuth auth) {
        auth.setId(id);
        //System.out.println(auth);
        service.update(auth);
        return ResponseUtil.general_response("auth update success!");
    }

    // 删除
    @DeleteMapping("/auths/{id}")
    public Object deleteUserAuth(@PathVariable("id") Integer id) {
        service.delete(id);
        return ResponseUtil.general_response("auth delete success!");
    }
}
