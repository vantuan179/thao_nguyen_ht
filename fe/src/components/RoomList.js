import React, { useEffect, useState } from 'react';
import { getAllRooms, getAvailableRooms, deleteRoom } from '../api/roomApi';

function RoomList() {
  const [rooms, setRooms] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [checkIn, setCheckIn] = useState('');
  const [checkOut, setCheckOut] = useState('');

  const fetchRooms = async () => {
    try {
      setLoading(true);
      const response = await getAllRooms();
      setRooms(response.data.data || []);
      setError('');
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchRooms();
  }, []);

  const handleSearchAvailable = async (e) => {
    e.preventDefault();
    if (!checkIn || !checkOut) {
      setError('Please select both check-in and check-out dates');
      return;
    }
    try {
      setLoading(true);
      const response = await getAvailableRooms(checkIn, checkOut);
      setRooms(response.data.data || []);
      setError('');
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this room?')) return;
    try {
      await deleteRoom(id);
      setRooms(rooms.filter((room) => room.id !== id));
    } catch (err) {
      setError(err.message);
    }
  };

  return (
    <div>
      <h2>Room Management</h2>

      <div className="card">
        <h3>Search Available Rooms</h3>
        <form onSubmit={handleSearchAvailable}>
          <div className="form-group">
            <label>Check-in Date</label>
            <input
              type="date"
              value={checkIn}
              onChange={(e) => setCheckIn(e.target.value)}
              required
            />
          </div>
          <div className="form-group">
            <label>Check-out Date</label>
            <input
              type="date"
              value={checkOut}
              onChange={(e) => setCheckOut(e.target.value)}
              required
            />
          </div>
          <button type="submit" className="btn btn-primary">Search</button>
          <button
            type="button"
            className="btn btn-success"
            onClick={fetchRooms}
            style={{ marginLeft: '0.5rem' }}
          >
            Show All
          </button>
        </form>
      </div>

      {error && <div className="alert alert-error">{error}</div>}

      {loading ? (
        <p>Loading rooms...</p>
      ) : (
        <div className="grid">
          {rooms.map((room) => (
            <div key={room.id} className="room-card">
              <h3>Room {room.roomNumber}</h3>
              <p><strong>Type:</strong> {room.type}</p>
              <p><strong>Capacity:</strong> {room.capacity} person(s)</p>
              <p><strong>Price:</strong> {Number(room.pricePerNight).toLocaleString('vi-VN')} VND/night</p>
              <p><strong>Description:</strong> {room.description || 'N/A'}</p>
              <p>
                <span className={`status ${room.status.toLowerCase()}`}>
                  {room.status}
                </span>
              </p>
              <button
                className="btn btn-danger"
                onClick={() => handleDelete(room.id)}
              >
                Delete
              </button>
            </div>
          ))}
        </div>
      )}

      {!loading && rooms.length === 0 && <p>No rooms found.</p>}
    </div>
  );
}

export default RoomList;
