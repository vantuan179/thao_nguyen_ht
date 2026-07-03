package com.hotel.management.controller;

import com.hotel.management.dto.ApiResponse;
import com.hotel.management.dto.AvailabilityRequest;
import com.hotel.management.dto.RoomRequest;
import com.hotel.management.entity.Room;
import com.hotel.management.service.RoomService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/rooms")
@CrossOrigin(origins = "*")
public class RoomController {

    private final RoomService roomService;

    public RoomController(RoomService roomService) {
        this.roomService = roomService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<Room>>> getAllRooms() {
        return ResponseEntity.ok(ApiResponse.success(roomService.getAllRooms()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<Room>> getRoomById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.success(roomService.getRoomById(id)));
    }

    @PostMapping("/available")
    public ResponseEntity<ApiResponse<List<Room>>> getAvailableRooms(@Valid @RequestBody AvailabilityRequest request) {
        List<Room> rooms = roomService.getAvailableRooms(request.getCheckInDate(), request.getCheckOutDate());
        return ResponseEntity.ok(ApiResponse.success(rooms));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Room>> createRoom(@Valid @RequestBody RoomRequest request) {
        Room room = roomService.createRoom(request);
        return ResponseEntity.ok(ApiResponse.success("Room created successfully", room));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<Room>> updateRoom(@PathVariable Long id, @Valid @RequestBody RoomRequest request) {
        Room room = roomService.updateRoom(id, request);
        return ResponseEntity.ok(ApiResponse.success("Room updated successfully", room));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteRoom(@PathVariable Long id) {
        roomService.deleteRoom(id);
        return ResponseEntity.ok(ApiResponse.success("Room deleted successfully", null));
    }
}
