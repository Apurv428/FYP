import { FaUserCircle, FaSignOutAlt } from 'react-icons/fa';
import { clearAdmin } from '../redux/admin/adminSlice';
import { useAppDispatch, useAppSelector } from '../redux/hook';

const Navbar = () => {
  const dispatch = useAppDispatch();
  const admin = useAppSelector((store) => store.admin);

  return (
    <div className="flex items-center justify-between px-10 py-3 border fixed left-0 right-0 bg-white z-10">
      <img src="/images/logo.png" alt="Canteen Hub Logo" className="w-14" />

      {admin.email.length > 0 && (
        <div className="flex space-x-5">
          <button className="flex items-center space-x-1 cursor-pointer">
            <FaUserCircle />
            <p className="font-normal text-sm text-slate-700">{admin.email}</p>
          </button>
          <button
            className="flex items-center space-x-1 cursor-pointer bg-slate-700 px-3 py-2 rounded-lg"
            onClick={() => dispatch(clearAdmin())}
          >
            <FaSignOutAlt color="white" />
            <p className="font-normal text-sm text-white">Logout</p>
          </button>
        </div>
      )}
    </div>
  );
};

export default Navbar;
