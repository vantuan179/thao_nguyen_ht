import api from './axiosConfig';

export const getAllBookings = () => api.get('/bookings');

export const getBookingById = (id) => api.get(`/bookings/${id}`);

export const getBookingsByUser = (userId) => api.get(`/bookings/user/${userId}`);

export const createBooking = (booking) => api.post('/bookings', booking);

export const updateBookingStatus = (id, status) =>
  api.put(`/bookings/${id}/status?status=${status}`);

export const deleteBooking = (id) => api.delete(`/bookings/${id}`);
