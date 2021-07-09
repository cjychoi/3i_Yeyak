package ai.threeeye.yeyak.service.impl;

import ai.threeeye.yeyak.common.define.ApiErrorCode;
import ai.threeeye.yeyak.common.exception.ApiException;
import ai.threeeye.yeyak.domain.Device;
import ai.threeeye.yeyak.domain.Reservation;
import ai.threeeye.yeyak.domain.User;
import ai.threeeye.yeyak.dto.reservation.CreateReservationDTO;
import ai.threeeye.yeyak.repository.DeviceRepository;
import ai.threeeye.yeyak.repository.ReservationRepository;
import ai.threeeye.yeyak.repository.UserRepository;
import ai.threeeye.yeyak.service.ReservationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service("ReservationService")
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {

    private final UserRepository userRepository;
    private final DeviceRepository deviceRepository;
    private final ReservationRepository reservationRepository;

    private final MongoTemplate mongo;

    @Override
    public List<Reservation> list() throws Exception {
        List<Reservation> reservationList = reservationRepository.findAll();

        return reservationList;
    }

    @Override
    public Reservation create(CreateReservationDTO payload) throws Exception {
        Optional<Device> maybeDevice = deviceRepository.findById(payload.getDeviceId());
        if (maybeDevice.isEmpty()) {
            throw new ApiException(ApiErrorCode.DEVICE_NOT_FOUND);
        }
        Optional<User> maybeUser = userRepository.findById(payload.getUserId());
        if (maybeUser.isEmpty()) {
            throw new ApiException(ApiErrorCode.USER_NOT_FOUND);
        }

        User user = maybeUser.get();
        Device device = maybeDevice.get();

        Query query = new Query();
        query.addCriteria(new Criteria().andOperator(
                Criteria.where("device").is(device.get_id()),
                new Criteria().orOperator(
                        new Criteria().andOperator(
                                Criteria.where("startedAt").lte(payload.getStartedAt()),
                                Criteria.where("endedAt").gt(payload.getStartedAt())
                        ),
                        new Criteria().andOperator(
                                Criteria.where("startedAt").lt(payload.getEndedAt()),
                                Criteria.where("endedAt").gte(payload.getEndedAt())
                        )
                )));
        List<Reservation> reservationList = mongo.find(query, Reservation.class);
        if (reservationList.size() > 0) {
            throw new ApiException(ApiErrorCode.ALREADY_RESERVED_DEVICE);
        }

        Reservation reservation = Reservation.builder()
                .device(device)
                .user(user)
                .startedAt(payload.getStartedAt())
                .endedAt(payload.getEndedAt())
                .build();

        reservationRepository.insert(reservation);

        return reservation;
    }
}
