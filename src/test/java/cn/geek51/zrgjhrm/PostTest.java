package cn.geek51.zrgjhrm;

import cn.geek51.dao.PostDao;
import cn.geek51.domain.Post;
import cn.geek51.service.IPostService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class PostTest extends BaseApplicationTest {
    @Autowired
    IPostService service;
    @Test
    public void postDaoTest() {
       // List<Post> list = dao.selectAll();
        //System.out.println(list);
    }

    @Test
    public void postServiceTest() {
        Post post = service.listOneById(1);
        System.out.println(post);
    }
}
