package cn.geek51.service.impl;

import cn.geek51.dao.UserAuthDao;
import cn.geek51.domain.UserAuth;
import cn.geek51.service.IUserAuthService;
import cn.geek51.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserAuthServiceImpl extends BaseServiceImpl<UserAuth> implements IUserAuthService {
    @Autowired
    private UserAuthDao dao;

    @Override
    public UserAuth login(String username, String password) {
        UserAuth currentUser = dao.checkLogin(username, password);
        if (currentUser == null) {
            throw new RuntimeException("帐号或密码错误!");
        }
        UserContext.setCurrentUser(currentUser);
        return currentUser;
    }
}
