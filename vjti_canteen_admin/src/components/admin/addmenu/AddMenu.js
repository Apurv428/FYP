import React, { useState } from 'react';
import { db } from '../../../firebase';
import { collection, addDoc } from 'firebase/firestore';

const AddMenu = () => {
  const [name, setName] = useState('');
  const [price, setPrice] = useState('');
  const [category, setCategory] = useState('');
  const [imageURL, setImageURL] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    try {
      await addDoc(collection(db, 'Food'), {
        foodimage: imageURL,
        foodtitle: name,
        foodprice: price,
        foodcategory: category,
      });
      console.log('Document added successfully');
      setName('');
      setPrice('');
      setCategory('');
      setImageURL('');
    } catch (error) {
      console.error('Error adding document: ', error);
    }
    setIsSubmitting(false);
  };

  const [previewImage, setPreviewImage] = useState('');
  const [showPreview, setShowPreview] = useState(false);

  const togglePreview = () => {
    setShowPreview(!showPreview);
  };



  return (
    <div className="flex justify-center mt-5">
      <div className="bg-white rounded-lg shadow-md p-5" style={{ width: '800px', marginLeft: '200px' }}>
        <h2 className="font-semibold mb-4 text-center">Add Menu</h2>
        <form onSubmit={handleSubmit} className="w-full">
          <div className="mb-4">
            <label htmlFor="name" className="block text-sm font-semibold mb-2">
              Item Name
            </label>
            <input
              type="text"
              id="name"
              name="name"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="Enter Item Name"
              className="border border-gray-300 rounded-md p-2 w-full"
              required
            />
          </div>
          <div className="mb-4">
            <label htmlFor="price" className="block text-sm font-semibold mb-2">
              Price
            </label>
            <input
              type="number"
              id="price"
              name="price"
              value={price}
              onChange={(e) => setPrice(e.target.value)}
              placeholder="Enter Price"
              className="border border-gray-300 rounded-md p-2 w-full"
              required
            />
          </div>
          <div className="mb-4">
            <label htmlFor="category" className="block text-sm font-semibold mb-2">
              Category
            </label>
            <select
              className="border border-slate-300 rounded-md outline-none text-sm shadow-sm px-3 py-2 placeholder-slate-400 right-5"
              value={category}
              onChange={(e) => setCategory(e.target.value)}
            >
              <option value="All">All</option>
              <option value="Snacks">Snacks</option>
              <option value="Breakfast">Breakfast</option>
              <option value="Lunch">Lunch</option>
              <option value="Beverages">Beverages</option>
              <option value="Confectionery">Confectionery</option>
            </select>
          </div>
          <div className="mb-4">
            <label htmlFor="image_url" className="block text-sm font-semibold mb-2">
              Image URL
            </label>
            <input
              type="text"
              id="image_url"
              name="image_url"
              value={imageURL}
              onChange={(e) => {
                setImageURL(e.target.value);
                setPreviewImage(e.target.value);
              }}
              placeholder="Enter Image URL"
              className="border border-gray-300 rounded-md p-2 mr-10 w-full"
              required
            />
            <div className="flex justify-center">
              <button
                type='button'
                onClick={togglePreview}
                className="bg-amber-500 text-white px-4 py-2 rounded-md mb-2 mt-2"
              >
                {showPreview ? 'Hide Preview Image' : 'Preview Image'}
              </button>
            </div>

          </div>
          {showPreview && (
            <div className="mb-4">
              <div className="flex justify-center">
                <img src={previewImage} alt="Preview" className="w-full h-50 rounded-lg" />
              </div>
            </div>
          )}
          <button
            type="submit"
            className="bg-amber-500 text-white px-4 py-2 rounded-md w-full"
            disabled={isSubmitting}
          >
            {isSubmitting ? 'Adding...' : 'Add Menu'}
          </button>
        </form>
      </div>
    </div>
  );
};

export default AddMenu;
