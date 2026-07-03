package com.hotel.management.service;

import com.hotel.management.dto.BookingRequest;
import com.hotel.management.entity.Booking;
import com.hotel.management.entity.Room;
import com.hotel.management.entity.User;
import com.hotel.management.exception.ResourceNotFoundException;
import com.hotel.management.repository.BookingRepository;
import com.hotel.management.repository.RoomRepository;
import com.hotel.management.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

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

    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }

    public Booking getBookingById(Long id) {
        return bookingRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Booking not found with id: " + id));
    }

    public List<Booking> getBookingsByUser(Long userId) {
        if (!userRepository.existsById(userId)) {
            throw new ResourceNotFoundException("User not found with id: " + userId);
        }
        return bookingRepository.findByUserId(userId);
    }

    @Transactional
    public Booking createBooking(BookingRequest request) {
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + request.getUserId()));

        Room room = roomRepository.findById(request.getRoomId())
                .orElseThrow(() -> new ResourceNotFoundException("Room not found with id: " + request.getRoomId()));

        if (!room.getStatus().equals("AVAILABLE")) {
            throw new IllegalStateException("Room is not available for booking");
        }

        if (!request.getCheckOutDate().isAfter(request.getCheckInDate())) {
            throw new IllegalStateException("Check-out date must be after check-in date");
        }

        List<Booking> overlapping = bookingRepository.findOverlappingBookings(
                room.getId(), request.getCheckInDate(), request.getCheckOutDate());

        if (!overlapping.isEmpty()) {
            throw new IllegalStateException("Room is already booked for the selected dates");
        }

        long nights = ChronoUnit.DAYS.between(request.getCheckInDate(), request.getCheckOutDate());
        BigDecimal totalPrice = room.getPricePerNight().multiply(BigDecimal.valueOf(nights));

        Booking booking = new Booking();
        booking.setUser(user);
        booking.setRoom(room);
        booking.setCheckInDate(request.getCheckInDate());
        booking.setCheckOutDate(request.getCheckOutDate());
        booking.setTotalPrice(totalPrice);
        booking.setStatus("CONFIRMED");
        booking.setUpdatedAt(LocalDateTime.now());

        return bookingRepository.save(booking);
    }

    @Transactional
    public Booking updateBookingStatus(Long id, String status) {
        Booking booking = getBookingById(id);
        booking.setStatus(status);
        booking.setUpdatedAt(LocalDateTime.now());
        return bookingRepository.save(booking);
    }

    @Transactional
    public void deleteBooking(Long id) {
        Booking booking = getBookingById(id);
        bookingRepository.delete(booking);
    }
}
