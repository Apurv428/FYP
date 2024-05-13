import { collection, getDocs, query, where } from 'firebase/firestore';
import { useState } from 'react';
import { FaEye, FaEyeSlash } from 'react-icons/fa';
import { db } from '../firebase';

import { toast, ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

import { useAppDispatch } from '../redux/hook';
import { setAdmin } from '../redux/admin/adminSlice';

const Login = () => {
  const dispatch = useAppDispatch();

  const [showPassword, setShowPassword] = useState(false);

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const error = () => {
    toast.error(`Incorrect email and password`, {
      position: 'top-right',
      autoClose: 2000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
      theme: 'light',
    });
  };

  const handleLogin = async (e) => {
    e.preventDefault();

    const adminReference = query(
      collection(db, 'admin'),
      where('email', '==', email)
    );

    const querySnapshot = await getDocs(adminReference);

    if (querySnapshot.empty) {
      error();
    } else {
      querySnapshot.forEach((doc) => {
        if (password === doc.data().password) {
          // Authorized user
          dispatch(setAdmin({ email, isSuperAdmin: doc.data().isSuperAdmin }));
          localStorage.setItem(
            'canteenhubadmin',
            JSON.stringify({
              email: email,
              isSuperAdmin: doc.data().isSuperAdmin,
            })
          );
        } else {
          error();
        }
      });
    }
  };

  return (
    <div className="flex items-center justify-center min-h-[88vh]">
      <form
        className="shadow-md px-10 py-10 rounded-lg w-[400px] mt-20"
        onSubmit={handleLogin}
      >
        <div className="text-2xl font-semibold mb-5">Canteen Hub Login</div>
        <label className="block mb-4">
          <span className="block text-sm font-medium text-slate-700 mb-1">
            Email
          </span>
          <input
            type="email"
            placeholder="Email"
            className="border border-slate-300 rounded-md outline-none text-sm shadow-sm px-3 py-2 placeholder-slate-400 w-full"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
        </label>
        <label className="block mb-4">
          <span className="block text-sm font-medium text-slate-700 mb-1">
            Password
          </span>
          <div className="relative">
            <input
              type={showPassword ? 'text' : 'password'}
              placeholder="Password"
              className="border border-slate-300 rounded-md outline-none text-sm shadow-sm px-3 py-2 placeholder-slate-400 w-full"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
            <div className="absolute right-2 top-3 cursor-pointer">
              {showPassword ? (
                <FaEyeSlash onClick={() => setShowPassword(!showPassword)} />
              ) : (
                <FaEye onClick={() => setShowPassword(!showPassword)} />
              )}
            </div>
          </div>
        </label>
        <button className="bg-slate-700 px-5 py-2 rounded-lg text-sm text-white border hover:bg-white hover:text-slate-700 hover:border-slate-700 transition">
          Log In
        </button>
      </form>

      <ToastContainer />
    </div>
  );
};

export default Login;