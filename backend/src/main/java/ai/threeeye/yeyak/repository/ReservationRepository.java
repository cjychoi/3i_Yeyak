package ai.threeeye.yeyak.repository;

import ai.threeeye.yeyak.domain.Reservation;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ReservationRepository extends MongoRepository<Reservation, String> {
}
