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
import com.mongodb.lang.Nullable;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

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
    public List<Reservation> list(@Nullable String deviceId, @Nullable String userId) throws Exception {
        List<Reservation> reservationList;
        Query query = new Query();
        if (StringUtils.hasText(deviceId) && StringUtils.hasText(userId)) { // 둘다 있을 경우
            log.info("deviceId and userId exists");
            query.addCriteria(new Criteria().andOperator(
               Criteria.where("device.$_id").is(deviceId),
               Criteria.where("user.$_id").is(userId)
            ));

            reservationList = mongo.find(query, Reservation.class);
        } else if (StringUtils.hasText(deviceId)) { // deviceId 만 있을 경우
            log.info("Only deviceId exists");
            query.addCriteria(Criteria.where("device").is(deviceId));

            reservationList = mongo.find(query, Reservation.class);
        } else if (StringUtils.hasText(userId)) { // userId 만 있을 경우
            log.info("Only userId exists");
            query.addCriteria(Criteria.where("user").is(userId));

            reservationList = mongo.find(query, Reservation.class);
        } else { // 둘다 없을 경우
            log.info("No criteria");
            reservationList = reservationRepository.findAll();
        }

        return reservationList;
    }

    @Override
    public Reservation create(CreateReservationDTO payload) throws Exception {
        if (payload.getStartedAt().isAfter(payload.getEndedAt())) {
            throw new ApiException(ApiErrorCode.INVALID_PARAMETER, "시간을 알맞게 입력해주세요");
        }

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
        query.addCriteria(new Criteria().andOperator( // And &&
                Criteria.where("device").is(device.get_id()),
                new Criteria().orOperator( // Or ||
                        new Criteria().andOperator( // DB에 있는 startedAt 과 비교, endedAt < payload.startedAt <= startedAt
                                Criteria.where("startedAt").lte(payload.getStartedAt()), // Less than or equals
                                Criteria.where("endedAt").gt(payload.getStartedAt()) // Greater than, Criteria.where("startedAt").gte(LocalDateTime.now())
                        ),
                        new Criteria().andOperator( // DB에 있는 endedAt 과 비교, endedAt <= payload.endedAt < startedAt
                                Criteria.where("startedAt").lt(payload.getEndedAt()), // Less than
                                Criteria.where("endedAt").gte(payload.getEndedAt()) // Greater than or equals
                        )
                )));
        List<Reservation> reservationList = mongo.find(query, Reservation.class); // 위 Criteria 로 예약된 목록을 가져와서 해당 시간 사이에 있는 예약 확인
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
