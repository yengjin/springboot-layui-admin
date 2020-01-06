package cn.geek51.dao;

import cn.geek51.domain.Post;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

/**
 * 公告Post持久层
 * 继承AbstractBaseDao, 使用抽象模版设计模式
 */
@Repository
public class PostDao extends BaseRepository<Post> {
}
