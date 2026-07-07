package com.example.hotel.service;

import com.example.hotel.entity.Booking;
import com.example.hotel.entity.Room;
import com.example.hotel.entity.User;
import com.example.hotel.repository.BookingRepository;
import com.example.hotel.repository.RoomRepository;
import com.example.hotel.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

@Service
public class BookingService {

    private final BookingRepository bookingRepository;
    private final UserRepository userRepository;
    private final RoomRepository roomRepository;

    public BookingService(BookingRepository bookingRepository,
                          UserRepository userRepository,
                          RoomRepository roomRepository) {
        this.bookingRepository = bookingRepository;
        this.userRepository = userRepository;
        this.roomRepository = roomRepository;
    }

    public List<Booking> findAll() {
        return bookingRepository.findAll();
    }

    public Optional<Booking> findById(Integer id) {
        return bookingRepository.findById(id);
    }

    public List<Booking> findByUserId(Integer userId) {
        return bookingRepository.findByUserId(userId);
    }

    @Transactional
    public Booking createBooking(Integer userId, Integer roomId, Booking booking) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        Room room = roomRepository.findById(roomId)
                .orElseThrow(() -> new RuntimeException("Room not found"));

        long nights = ChronoUnit.DAYS.between(booking.getCheckInDate(), booking.getCheckOutDate());
        if (nights <= 0) {
            throw new RuntimeException("Check-out date must be after check-in date");
        }

        BigDecimal totalPrice = room.getPricePerNight().multiply(BigDecimal.valueOf(nights));

        booking.setUser(user);
        booking.setRoom(room);
        booking.setTotalPrice(totalPrice);
        booking.setStatus("BOOKED");

        return bookingRepository.save(booking);
    }

    @Transactional
    public Booking updateStatus(Integer id, String status) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus(status);
        return bookingRepository.save(booking);
    }

    public void deleteById(Integer id) {
        bookingRepository.deleteById(id);
    }
}
