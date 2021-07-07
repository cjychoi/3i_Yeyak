package ai.threeeye.yeyak.service.impl;

import ai.threeeye.yeyak.domain.User;
import ai.threeeye.yeyak.dto.user.LoginUserDTO;
import ai.threeeye.yeyak.repository.UserRepository;
import ai.threeeye.yeyak.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Slf4j
@Service("UserService")
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Override
    public User login(LoginUserDTO payload) throws Exception {
        Optional<User> maybeUser = userRepository.findByUsername(payload.getUsername());
        if (maybeUser.isEmpty()) {
            User user = User.builder()
                    .username(payload.getUsername())
                    .build();

            userRepository.insert(user);

            return user;
        }

        return maybeUser.get();
    }
}
