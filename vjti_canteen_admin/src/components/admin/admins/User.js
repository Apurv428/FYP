import React, { useState } from 'react';
import { AiFillDelete, AiFillEdit } from 'react-icons/ai';
import { confirmAlert } from 'react-confirm-alert';
import { deleteDoc, doc, updateDoc } from 'firebase/firestore';
import { db } from '../../../firebase';

const User = ({ admin }) => {
  const [email, setEmail] = useState(admin.email);
  const [isSuperAdmin, setIsSuperAdmin] = useState(admin.isSuperAdmin);
  const [showModal, setShowModal] = useState(false);

  const onCheckboxChange = (e) => {
    setIsSuperAdmin(e.target.checked);
  };

  const handleUpdate = async () => {
    if (admin.id) {
      const adminReference = doc(db, 'admins', admin.id);
      await updateDoc(adminReference, {
        email: email,
        isSuperAdmin: isSuperAdmin,
      });
    }
  };

  const handleDelete = () => {
    confirmAlert({
      customUI: ({ onClose }) => {
        return (
          <div className="bg-white shadow-2xl rounded-lg px-8 py-5">
            <div className="font-semibold text-slate-700 text-lg">
              Are you sure?
            </div>
            <p className="text-sm text-slate-600 mb-3">
              You want to delete this admin?
            </p>

            <button
              onClick={async () => {
                if (admin.id) {
                  const adminReference = doc(db, 'admins', admin.id);
                  await deleteDoc(adminReference);
                }
                onClose();
              }}
              className="bg-red-700 px-3 py-1 rounded-lg text-sm text-white border hover:bg-white hover:text-red-700 hover:border-red-700 transition mr-3"
            >
              Yes
            </button>
            <button
              className="bg-slate-700 px-3 py-1 rounded-lg text-sm text-white border hover:bg-white hover:text-slate-700 hover:border-slate-700 transition"
              onClick={onClose}
            >
              No
            </button>
          </div>
        );
      },
    });
  };

  return (
    <div className="shadow-lg px-6 py-5 rounded-lg m-2 flex flex-col items-end">
      <div className="flex space-x-5 items-center">
        <div className="bg-red-400 w-11 h-11 rounded-full flex items-center justify-center uppercase text-white text-lg">
          {admin.email[0]}
        </div>
        <div>
          <div className="text-sm font-medium text-slate-900">
            {admin.email}
          </div>
          <div className="text-sm font-medium text-slate-600">
            {admin.isSuperAdmin ? 'Super Admin' : 'Admin'}
          </div>
        </div>
        <div className="space-x-1">
          <button
            className="border-2 rounded-md border-red-400 p-2 mt-3"
            onClick={handleDelete}
          >
            <AiFillDelete color="#ff6d6d" />
          </button>
          <button
            className="border-2 rounded-md border-green-500 p-2 mt-3"
            onClick={() => setShowModal(true)}
          >
            <AiFillEdit color="#15c444" />
          </button>
        </div>
      </div>

      {showModal && (
        <>
          <div className="justify-center items-center flex overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none">
            <div className="relative w-auto my-6 mx-auto max-w-3xl">
              <div className="border-0 rounded-lg shadow-lg relative flex flex-col w-full bg-white outline-none focus:outline-none">
                <div className="bg-white shadow-2xl rounded-lg px-4 py-5 w-[300px]">
                  <div className="font-semibold text-slate-700 text-lg mb-3">
                    Edit Admin
                  </div>
                  <div>
                    <label className="block mb-4">
                      <span className="block text-sm font-medium text-slate-700 mb-0.5">
                        Email
                      </span>
                      <input
                        required
                        type="email"
                        placeholder="Email"
                        className="border border-slate-300 rounded-md outline-none text-sm shadow-sm px-3 py-2 placeholder-slate-400 w-full"
                        defaultValue={admin.email}
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                      />
                    </label>
                    <label className="mb-4 flex items-center space-x-3">
                      <span className="text-sm font-medium text-slate-700">
                        Super Admin
                      </span>
                      <input
                        type="checkbox"
                        defaultChecked={admin.isSuperAdmin}
                        checked={isSuperAdmin}
                        onChange={onCheckboxChange}
                      />
                    </label>
                  </div>
                  <p className="text-sm text-slate-600 mb-3">
                    You want to update admin?
                  </p>
                  <button
                    onClick={() => {
                      handleUpdate();
                      setShowModal(false);
                    }}
                    className="bg-red-700 px-3 py-1 rounded-lg text-sm text-white border hover:bg-white hover:text-red-700 hover:border-red-700 transition mr-3"
                  >
                    Yes
                  </button>
                  <button
                    className="bg-slate-700 px-3 py-1 rounded-lg text-sm text-white border hover:bg-white hover:text-slate-700 hover:border-slate-700 transition"
                    onClick={() => {
                      setShowModal(false);
                    }}
                  >
                    No
                  </button>
                </div>
              </div>
            </div>
          </div>
          <div className="opacity-4.25 fixed inset-0 z-40 bg-dialog-bg"></div>
        </>
      )}
    </div>
  );
};

export default User;