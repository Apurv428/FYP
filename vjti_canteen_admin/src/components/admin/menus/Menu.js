import { useState } from 'react';
import { LazyLoadImage } from 'react-lazy-load-image-component';
import { FaPen, FaTimes ,FaTrash} from 'react-icons/fa';
import { collection, updateDoc,deleteDoc } from 'firebase/firestore';
import { db } from '../../../firebase';

const Menu = ({ menu }) => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editedMenu, setEditedMenu] = useState(menu);
  const [previewImage, setPreviewImage] = useState(menu.image);
  const [showPreview, setShowPreview] = useState(false);

  const openModal = () => {
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setEditedMenu({ ...editedMenu, [name]: value });
  };

  const handleImageChange = (e) => {
    const imageUrl = e.target.value;
    setPreviewImage(imageUrl);
    setEditedMenu({ ...editedMenu, image: imageUrl });
  };

  const togglePreview = () => {
    setShowPreview(!showPreview);
  };

  const handleSubmit = async () => {
    const menuRef = collection(db, 'Food').doc(menu.id);
    await updateDoc(menuRef, editedMenu);
    console.log('Menu updated successfully:', editedMenu);
    closeModal();
  };

  const handleDelete = async () => {
    const menuRef = collection(db, 'Food').doc(menu.id);
    await deleteDoc(menuRef);
    console.log('Menu deleted successfully:', menu);
    closeModal();
  };

  return (
    <div className="shadow-xl p-5 w-50 rounded-lg m-3 relative">
      <LazyLoadImage
        src={previewImage}
        alt={`${menu.name}_image`}
        className="mb-3 rounded-lg w-[200px] h-[133.2px] object-cover"
        width={200}
        height={133.2}
      />
      <div className="flex justify-between items-center">
        <div>
          <div className="text-sm text-slate-700 font-medium">{menu.name}</div>
          <p className="text-sm text-slate-600 font-semibold">Rs. {menu.price}</p>
        </div>
        <FaPen color='black' className="cursor-pointer" onClick={openModal} />
        <FaTrash color='red' className="cursor-pointer ml-1" onClick={handleDelete} />
      </div>
      {isModalOpen && (
        <div className="fixed inset-0 flex justify-center items-center bg-black bg-opacity-50 z-50">
          <div className="bg-white p-8 rounded-lg max-h-[80vh] overflow-y-auto w-96">
            <div className="flex justify-between items-center mb-4">
              <h2 className="text-lg font-semibold mb-0">Edit Menu</h2>
              <FaTimes className="text-gray-500 cursor-pointer" onClick={closeModal} />
            </div>
            <label htmlFor="name" className="text-sm font-semibold mb-2 block">
              Menu Name
            </label>
            <input
              type="text"
              id="name"
              name="name"
              value={editedMenu.name}
              onChange={handleInputChange}
              placeholder="Menu Name"
              className="border border-gray-300 rounded-md p-2 mb-4 w-full"
            />
            <label htmlFor="price" className="text-sm font-semibold mb-2 block">
              Price
            </label>
            <input
              type="number"
              id="price"
              name="price"
              value={editedMenu.price}
              onChange={handleInputChange}
              placeholder="Price"
              className="border border-gray-300 rounded-md p-2 mb-4 w-full"
            />
            <label htmlFor="category" className="text-sm font-semibold mb-2 block">
              Category
            </label>
            <input
              type="text"
              id="category"
              name="category"
              value={editedMenu.type}
              onChange={handleInputChange}
              placeholder="Category"
              className="border border-gray-300 rounded-md p-2 mb-4 w-full"
            />
            <label htmlFor="image_url" className="text-sm font-semibold mb-2 block">
              Image URL
            </label>
            <input
              type="text"
              id="image_url"
              name="image_url"
              value={editedMenu.image}
              onChange={handleImageChange}
              placeholder="Image URL"
              className="border border-gray-300 rounded-md p-2 mb-4 w-full"
            />
            <div className="text-center">
              <button
                onClick={togglePreview}
                className="bg-amber-500 text-white px-4 py-2 rounded-md mb-2"
              >
                {showPreview ? 'Hide Preview Image' : 'Preview Image'}
              </button>
              {showPreview && (
                <div className="mb-4">
                  <div className="flex justify-center">
                    <img src={previewImage} alt="Preview" className="w-full h-50 rounded-lg" />
                  </div>
                </div>
              )}
            </div>
            <div className="flex justify-center mt-5">
              <button
                onClick={handleSubmit}
                className="bg-amber-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 mr-2"
              >
                Save Changes
              </button>
              <button
                onClick={closeModal}
                className="bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400"
              >
                Cancel
              </button>
            </div>

          </div>
        </div>
      )}
    </div>
  );
};

export default Menu;