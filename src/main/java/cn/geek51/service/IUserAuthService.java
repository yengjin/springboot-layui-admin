package cn.geek51.service;

import cn.geek51.domain.UserAuth;

public interface IUserAuthService extends AbstractIService<UserAuth> {

    UserAuth login(String username, String password);
}
