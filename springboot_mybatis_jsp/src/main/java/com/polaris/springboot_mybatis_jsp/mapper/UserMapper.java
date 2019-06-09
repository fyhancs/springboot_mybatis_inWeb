package com.polaris.springboot_mybatis_jsp.mapper;

import com.polaris.springboot_mybatis_jsp.pojo.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

import java.util.List;

@Mapper
@Service
public interface UserMapper {

    @Select("select * from user")
    List<User> findAll();

    @Insert("insert into user(username,password)values(#{username},#{password}")
    public int add(User user);
}

