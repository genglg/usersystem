package net.yuanma.dao;

import net.yuanma.model.User;

public interface LoginMapper {

	User selectUser(String userName);
}
