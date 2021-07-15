package ai.threeeye.yeyak.service;

import ai.threeeye.yeyak.domain.Reservation;
import ai.threeeye.yeyak.dto.reservation.CreateReservationDTO;

import java.util.List;

public interface ReservationService {

    List<Reservation> list(String deviceId, String userId) throws Exception;

    Reservation create(CreateReservationDTO payload) throws Exception;

}
