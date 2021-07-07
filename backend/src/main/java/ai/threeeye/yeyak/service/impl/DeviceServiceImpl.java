package ai.threeeye.yeyak.service.impl;

import ai.threeeye.yeyak.common.define.ApiErrorCode;
import ai.threeeye.yeyak.common.exception.ApiException;
import ai.threeeye.yeyak.domain.Device;
import ai.threeeye.yeyak.dto.device.CreateDeviceDTO;
import ai.threeeye.yeyak.repository.DeviceRepository;
import ai.threeeye.yeyak.service.DeviceService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.util.List;
import java.util.Optional;

@Service("DeviceService")
@RequiredArgsConstructor
public class DeviceServiceImpl implements DeviceService {

    private final DeviceRepository deviceRepository;
    private final MongoTemplate mongo;

    @Override
    public List<Device> list() throws Exception {
        List<Device> devices = deviceRepository.findAll();

        return devices;
    }

    @Override
    public Device create(CreateDeviceDTO payload) throws Exception {
        Query query = new Query();
        query.addCriteria(Criteria.where("code").is(payload.getCode()));
        Device maybeDevice = mongo.findOne(query, Device.class);
        if (!ObjectUtils.isEmpty(maybeDevice)) {
            throw new ApiException(ApiErrorCode.DEVICE_ALREADY_EXISTS);
        }

        Device device = Device.builder()
                .manufacturer(payload.getManufacturer())
                .code(payload.getCode())
                .model(payload.getModel())
                .color(payload.getColor())
                .os(payload.getOs())
                .availability(payload.getAvailability())
                .description(payload.getDescription())
                .build();

        deviceRepository.insert(device);

        return device;
    }

    @Override
    public Device load(String id) throws Exception {
        Optional<Device> maybeDevice = deviceRepository.findById(id);
        if (maybeDevice.isEmpty()) {
            throw new ApiException(ApiErrorCode.DEVICE_NOT_FOUND);
        }

        return maybeDevice.get();
    }

    @Override
    public Boolean delete(String id) throws Exception {
        Optional<Device> maybeDevice = deviceRepository.findById(id);
        if (maybeDevice.isEmpty()) {
            throw new ApiException(ApiErrorCode.DEVICE_NOT_FOUND);
        }

        deviceRepository.deleteById(id);

        return true;
    }

}
