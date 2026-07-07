package com.example.hotel.service;

import com.example.hotel.entity.Room;
import com.example.hotel.repository.RoomRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoomService {

    private final RoomRepository roomRepository;

    public RoomService(RoomRepository roomRepository) {
        this.roomRepository = roomRepository;
    }

    public List<Room> findAll() {
        return roomRepository.findAll();
    }

    public Optional<Room> findById(Integer id) {
        return roomRepository.findById(id);
    }

    public List<Room> findAvailable() {
        return roomRepository.findByStatus("AVAILABLE");
    }

    public Room save(Room room) {
        return roomRepository.save(room);
    }

    public void deleteById(Integer id) {
        roomRepository.deleteById(id);
    }
}
