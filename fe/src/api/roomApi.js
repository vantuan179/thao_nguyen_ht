import api from './axiosConfig';

export const getAllRooms = () => api.get('/rooms');

export const getRoomById = (id) => api.get(`/rooms/${id}`);

export const getAvailableRooms = (checkInDate, checkOutDate) =>
  api.post('/rooms/available', { checkInDate, checkOutDate });

export const createRoom = (room) => api.post('/rooms', room);

export const updateRoom = (id, room) => api.put(`/rooms/${id}`, room);

export const deleteRoom = (id) => api.delete(`/rooms/${id}`);
