package net.yuanma.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import net.yuanma.dto.UserInfoDto;
import net.yuanma.model.UserInfo;
import net.yuanma.model.UserInfoExample;

public interface UserInfoMapper {
    int countByExample(UserInfoExample example);

    int deleteByExample(UserInfoExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(UserInfo record);

    int insertSelective(UserInfo record);

    List<UserInfo> selectByExample(UserInfoExample example);

    UserInfo selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") UserInfo record, @Param("example") UserInfoExample example);

    int updateByExample(@Param("record") UserInfo record, @Param("example") UserInfoExample example);

    int updateByPrimaryKeySelective(UserInfo record);

    int updateByPrimaryKey(UserInfo record);
    
    UserInfo selectUserByName(@Param("userName")String userName,@Param("password")String password);
    
    UserInfoDto selectUserInfoById(int id);
}