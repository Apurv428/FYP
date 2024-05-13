import { createSlice } from '@reduxjs/toolkit';
import { AdminStateInterface } from '../../modle';

const initialState = {
  email: '',
  isSuperAdmin: false,
};

export const adminSlice = createSlice({
  name: 'admin',
  initialState,
  reducers: {
    setAdmin: (state, action) => {
      state.email = action.payload.email;
      state.isSuperAdmin = action.payload.isSuperAdmin;
    },
    clearAdmin: (state) => {
      state.email = '';
      state.isSuperAdmin = false;

      localStorage.setItem('canteenhubadmin', '');
    },
  },
});

export const { setAdmin, clearAdmin } = adminSlice.actions;

export default adminSlice.reducer;