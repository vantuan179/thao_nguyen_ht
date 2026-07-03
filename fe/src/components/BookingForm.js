import React, { useEffect, useState } from 'react';
import { getAvailableRooms } from '../api/roomApi';
import { createBooking, getAllBookings, updateBookingStatus, deleteBooking } from '../api/bookingApi';

function BookingForm() {
  const [rooms, setRooms] = useState([]);
  const [bookings, setBookings] = useState([]);
  const [form, setForm] = useState({
    userId: 2,
    roomId: '',
    checkInDate: '',
    checkOutDate: '',
  });
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState({ type: '', text: '' });

  const today = new Date().toISOString().split('T')[0];

  const fetchBookings = async () => {
    try {
      const response = await getAllBookings();
      setBookings(response.data.data || []);
    } catch (err) {
      setMessage({ type: 'error', text: err.message });
    }
  };

  useEffect(() => {
    fetchBookings();
  }, []);

  useEffect(() => {
    const loadAvailableRooms = async () => {
      if (form.checkInDate && form.checkOutDate) {
        try {
          const response = await getAvailableRooms(form.checkInDate, form.checkOutDate);
          setRooms(response.data.data || []);
        } catch (err) {
          setMessage({ type: 'error', text: err.message });
        }
      }
    };
    loadAvailableRooms();
  }, [form.checkInDate, form.checkOutDate]);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setMessage({ type: '', text: '' });
    try {
      const response = await createBooking(form);
      setMessage({ type: 'success', text: response.data.message || 'Booking created successfully!' });
      setForm({ userId: 2, roomId: '', checkInDate: '', checkOutDate: '' });
      setRooms([]);
      fetchBookings();
    } catch (err) {
      setMessage({ type: 'error', text: err.message });
    } finally {
      setLoading(false);
    }
  };

  const handleStatusChange = async (id, status) => {
    try {
      await updateBookingStatus(id, status);
      fetchBookings();
    } catch (err) {
      setMessage({ type: 'error', text: err.message });
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to cancel this booking?')) return;
    try {
      await deleteBooking(id);
      fetchBookings();
    } catch (err) {
      setMessage({ type: 'error', text: err.message });
    }
  };

  return (
    <div>
      <h2>Booking Management</h2>

      <div className="card">
        <h3>Create New Booking</h3>
        {message.text && (
          <div className={`alert alert-${message.type}`}>{message.text}</div>
        )}
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label>User ID</label>
            <input
              type="number"
              name="userId"
              value={form.userId}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <label>Check-in Date</label>
            <input
              type="date"
              name="checkInDate"
              min={today}
              value={form.checkInDate}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <label>Check-out Date</label>
            <input
              type="date"
              name="checkOutDate"
              min={form.checkInDate || today}
              value={form.checkOutDate}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <label>Available Room</label>
            <select
              name="roomId"
              value={form.roomId}
              onChange={handleChange}
              required
              disabled={rooms.length === 0}
            >
              <option value="">
                {rooms.length === 0 ? 'Select dates to see available rooms' : 'Select a room'}
              </option>
              {rooms.map((room) => (
                <option key={room.id} value={room.id}>
                  Room {room.roomNumber} - {room.type} ({Number(room.pricePerNight).toLocaleString('vi-VN')} VND/night)
                </option>
              ))}
            </select>
          </div>
          <button type="submit" className="btn btn-primary" disabled={loading}>
            {loading ? 'Booking...' : 'Create Booking'}
          </button>
        </form>
      </div>

      <div className="card">
        <h3>All Bookings</h3>
        <table className="table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Room</th>
              <th>User</th>
              <th>Check-in</th>
              <th>Check-out</th>
              <th>Total</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {bookings.map((booking) => (
              <tr key={booking.id}>
                <td>{booking.id}</td>
                <td>{booking.room?.roomNumber}</td>
                <td>{booking.user?.fullName || booking.user?.username}</td>
                <td>{booking.checkInDate}</td>
                <td>{booking.checkOutDate}</td>
                <td>{Number(booking.totalPrice).toLocaleString('vi-VN')} VND</td>
                <td>
                  <span className={`status ${booking.status.toLowerCase()}`}>
                    {booking.status}
                  </span>
                </td>
                <td>
                  {booking.status === 'CONFIRMED' && (
                    <button
                      className="btn btn-danger"
                      onClick={() => handleStatusChange(booking.id, 'CANCELLED')}
                    >
                      Cancel
                    </button>
                  )}
                  <button
                    className="btn btn-danger"
                    onClick={() => handleDelete(booking.id)}
                    style={{ marginLeft: '0.5rem' }}
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {bookings.length === 0 && <p>No bookings found.</p>}
      </div>
    </div>
  );
}

export default BookingForm;
