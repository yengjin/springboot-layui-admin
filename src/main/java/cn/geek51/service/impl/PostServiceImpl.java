package cn.geek51.service.impl;

import cn.geek51.dao.BaseRepository;
import cn.geek51.dao.PostDao;
import cn.geek51.domain.Post;
import cn.geek51.service.IPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PostServiceImpl extends BaseServiceImpl<Post> implements IPostService{
}