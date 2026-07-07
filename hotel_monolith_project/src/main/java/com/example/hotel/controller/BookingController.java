package com.example.hotel.controller;

import com.example.hotel.entity.Booking;
import com.example.hotel.service.BookingService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/bookings")
@CrossOrigin(origins = "*")
public class BookingController {

    private final BookingService bookingService;

    public BookingController(BookingService bookingService) {
        this.bookingService = bookingService;
    }

    @GetMapping
    public List<Booking> getAllBookings() {
        return bookingService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Booking> getBookingById(@PathVariable Integer id) {
        return bookingService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/user/{userId}")
    public List<Booking> getBookingsByUser(@PathVariable Integer userId) {
        return bookingService.findByUserId(userId);
    }

    @PostMapping
    public ResponseEntity<?> createBooking(@RequestBody Map<String, Object> payload) {
        try {
            Integer userId = Integer.valueOf(payload.get("userId").toString());
            Integer roomId = Integer.valueOf(payload.get("roomId").toString());

            Booking booking = new Booking();
            booking.setCheckInDate(java.time.LocalDate.parse(payload.get("checkInDate").toString()));
            booking.setCheckOutDate(java.time.LocalDate.parse(payload.get("checkOutDate").toString()));

            Booking saved = bookingService.createBooking(userId, roomId, booking);
            return ResponseEntity.ok(saved);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<?> updateBookingStatus(@PathVariable Integer id, @RequestBody Map<String, String> payload) {
        try {
            Booking updated = bookingService.updateStatus(id, payload.get("status"));
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBooking(@PathVariable Integer id) {
        if (bookingService.findById(id).isPresent()) {
            bookingService.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
