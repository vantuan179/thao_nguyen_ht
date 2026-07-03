package com.hotel.management.controller;

import com.hotel.management.dto.ApiResponse;
import com.hotel.management.dto.BookingRequest;
import com.hotel.management.entity.Booking;
import com.hotel.management.service.BookingService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/bookings")
@CrossOrigin(origins = "*")
public class BookingController {

    private final BookingService bookingService;

    public BookingController(BookingService bookingService) {
        this.bookingService = bookingService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<Booking>>> getAllBookings() {
        return ResponseEntity.ok(ApiResponse.success(bookingService.getAllBookings()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<Booking>> getBookingById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.success(bookingService.getBookingById(id)));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<ApiResponse<List<Booking>>> getBookingsByUser(@PathVariable Long userId) {
        return ResponseEntity.ok(ApiResponse.success(bookingService.getBookingsByUser(userId)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Booking>> createBooking(@Valid @RequestBody BookingRequest request) {
        Booking booking = bookingService.createBooking(request);
        return ResponseEntity.ok(ApiResponse.success("Booking created successfully", booking));
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<ApiResponse<Booking>> updateBookingStatus(@PathVariable Long id,
                                                                  @RequestParam String status) {
        Booking booking = bookingService.updateBookingStatus(id, status);
        return ResponseEntity.ok(ApiResponse.success("Booking status updated", booking));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteBooking(@PathVariable Long id) {
        bookingService.deleteBooking(id);
        return ResponseEntity.ok(ApiResponse.success("Booking deleted successfully", null));
    }
}
