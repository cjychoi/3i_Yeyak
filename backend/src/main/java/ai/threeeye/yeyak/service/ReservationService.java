package ai.threeeye.yeyak.service;

import ai.threeeye.yeyak.domain.Reservation;
import ai.threeeye.yeyak.dto.reservation.CreateReservationDTO;

import java.util.List;

public interface ReservationService {

    List<Reservation> list() throws Exception;

    //load userReservation data
    Reservation loadUser(String id) throws Exception;
    //load deviceReservation data
    Reservation loadDevice(String id) throws Exception;

    Reservation create(CreateReservationDTO payload) throws Exception;

}
