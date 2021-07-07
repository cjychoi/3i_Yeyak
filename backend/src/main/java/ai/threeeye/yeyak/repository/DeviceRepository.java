package ai.threeeye.yeyak.repository;

import ai.threeeye.yeyak.domain.Device;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface DeviceRepository extends MongoRepository<Device, String> {
}
