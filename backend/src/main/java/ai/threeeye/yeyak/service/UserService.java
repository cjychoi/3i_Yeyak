package ai.threeeye.yeyak.service;

import ai.threeeye.yeyak.domain.User;
import ai.threeeye.yeyak.dto.user.LoginUserDTO;

public interface UserService {

    User login(LoginUserDTO payload) throws Exception;

}
