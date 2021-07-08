package ai.threeeye.yeyak.service;

import ai.threeeye.yeyak.domain.Device;
import ai.threeeye.yeyak.dto.device.CreateDeviceDTO;

import java.util.List;

public interface DeviceService {

    List<Device> list() throws Exception;

    Device create(CreateDeviceDTO payload) throws Exception;

    Device load(String id) throws Exception;

    Boolean delete(String id) throws Exception;

}
