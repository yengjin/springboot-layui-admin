package cn.geek51.zrgjhrm;

import cn.geek51.Application;
import org.junit.After;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.security.RunAs;

@SpringBootTest(classes = Application.class)
@RunWith(SpringJUnit4ClassRunner.class)
class BaseApplicationTest {

    @Before
    public void init() {
        System.out.println("-------测试开始-------");
    }

    @After
    public void after() {
        System.out.println("-------测试结束-------");
    }

}
