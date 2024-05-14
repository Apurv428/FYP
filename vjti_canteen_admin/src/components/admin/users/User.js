const User = ({ user }) => {
  const capitalizedUserName = user.name.charAt(0).toUpperCase() + user.name.slice(1);

  return (
    <div className="w-full md:w-1/2 lg:w-1/2 p-2">
      <div className="bg-white rounded-lg shadow-md p-5" style={{ minWidth: '250px',margin:'10px' }}>
        <div className="flex flex-col items-start space-y-3">
          <div className="text-sm font-medium text-slate-900">{capitalizedUserName}</div>
          <div className="text-sm font-medium text-slate-600">{user.email}</div>
          <div className="text-sm font-medium text-slate-600">{user.regId}</div>
        </div>
      </div>
    </div>
  );
};

export default User;