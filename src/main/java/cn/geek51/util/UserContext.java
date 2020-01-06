package cn.geek51.util;

import cn.geek51.domain.UserAuth;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

// 封装当前登录用户的上下文信息
public class UserContext {

    private static final String USER_IN_SESSION = "user_in_session";

    // 获取HttpSession对象
    public static HttpSession getSession() {
        return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
    }

    public static void setCurrentUser(UserAuth currentUser) {
        if (currentUser == null) {
            getSession().invalidate();
        } else {
            getSession().setAttribute(USER_IN_SESSION, currentUser);
        }
    }

    // 获取当前用户
    public static UserAuth getCurrentUser() {
        return (UserAuth) getSession().getAttribute(USER_IN_SESSION);
    }

    // 进行注销
    public static void doLogout() {
        getSession().invalidate();
    }
}
