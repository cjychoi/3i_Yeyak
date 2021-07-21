package ai.threeeye.yeyak.repository;

import ai.threeeye.yeyak.domain.Device;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface DeviceRepository extends MongoRepository<Device, String> {

    Optional<Device> findByCode(String code);

}
