import { IoFastFoodSharp, IoAddCircleSharp } from 'react-icons/io5';
import {
  FaClock,
  FaHistory,
  FaUsers,
  FaBan
} from 'react-icons/fa';
import { useAppSelector } from '../redux/hook';

const options = [
  'Menus',
  'Add Menu',
  'Unavailable Items',
  'Orders',
  'History',
  'All Users',
];

const restricted = [true, true, true, true, true, true];

const icons = [
  IoFastFoodSharp,
  IoAddCircleSharp,
  FaBan,
  FaClock,
  FaHistory,
  FaUsers
];

const Sidebar = ({ active, setActive }) => {
  const admin = useAppSelector((store) => store.admin);

  return (
    <div className="flex fixed bottom-0 top-[80px]">
      <div className="w-[280px] shadow-lg py-5 px-4 flex flex-col justify-between">
        <div className="overflow-x-auto	no-scrollbar">
          {options.map((name, index) => {
            const Icon = icons[index];
            return (
              <div key={index}>
                {(admin.isSuperAdmin || restricted[index]) && (
                  <div
                    className={`flex items-center space-x-2 px-3 py-3 rounded-md my-2 cursor-pointer transition ${
                      active === name && 'bg-slate-300'
                    }`}
                    onClick={() => setActive(name)}
                  >
                    <Icon size={15} />
                    <p className="text-sm">{name}</p>
                  </div>
                )}
              </div>
            );
          })}
        </div>

        <div className="text-sm font-light text-slate-400">
          By Apurv Sonawane
        </div>
      </div>
    </div>
  );
};

export default Sidebar;
