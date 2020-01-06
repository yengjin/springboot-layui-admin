package cn.geek51.dao;

import cn.geek51.domain.UserAuth;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户权限EmpAuth持久层
 * 继承AbstractBaseDao, 使用抽象模版设计模式
 */
@Repository
public class UserAuthDao extends BaseRepository {
    private final String namespace = "cn.geek51.domain.UserAuth.";
    //执行登录,查看用户是否合法
    public UserAuth checkLogin(String username, String password) {
        if (username == null || password == null) return null;
        Map<String, Object> map = new HashMap<>();
        map.put("username", username);
        map.put("password", password);
        List<UserAuth> list = selectAllByParams(map, namespace);
        return list == null ? null : list.get(0);
    }
}
