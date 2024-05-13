import { configureStore } from '@reduxjs/toolkit';
import adminReducer from './redux/admin/adminSlice';

const store = configureStore({
  reducer: {
    admin: adminReducer,
  },
});

export const RootState = store.getState;
export const AppDispatch = store.dispatch;

export default store;
