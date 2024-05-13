/**
 * Represents the structure of a menu item.
 * @typedef {Object} MenuInterface
 * @property {string} id - The ID of the menu item.
 * @property {string} image - The URL of the menu item image.
 * @property {string} name - The name of the menu item.
 * @property {boolean} popular - Indicates whether the menu item is popular.
 * @property {number} price - The price of the menu item.
 * @property {number} [imageRef] - The reference number of the menu item image (optional).
 * @property {string} type - The type of the menu item.
 */

/**
 * Represents the structure of an item in an order.
 * @typedef {Object} OrderItemInterface
 * @property {string} id - The ID of the order item.
 * @property {string} image - The URL of the order item image.
 * @property {string} name - The name of the order item.
 * @property {number} price - The price of the order item.
 * @property {number} total - The total quantity of the order item.
 */

/**
 * Represents the structure of an order.
 * @typedef {Object} OrderInterface
 * @property {string} id - The ID of the order.
 * @property {string} date - The date of the order.
 * @property {string} email - The email of the customer who placed the order.
 * @property {string} name - The name of the customer who placed the order.
 * @property {string} phone - The phone number of the customer who placed the order.
 * @property {number} total - The total amount of the order.
 * @property {boolean} served - Indicates whether the order has been served.
 * @property {OrderItemInterface[]} items - The list of ordered items.
 * @property {string} createdAt - The timestamp of when the order was created.
 */

/**
 * Represents the structure of a user.
 * @typedef {Object} UsersInterface
 * @property {string} email - The email of the user.
 * @property {string} name - The name of the user.
 * @property {string} picture - The URL of the user's profile picture.
 */

/**
 * Represents the structure of the admin state.
 * @typedef {Object} AdminStateInterface
 * @property {string} [id] - The ID of the admin (optional).
 * @property {string} email - The email of the admin.
 * @property {boolean} isSuperAdmin - Indicates whether the admin is a super admin.
 */

/**
 * Represents the structure of a menu item for today's special.
 * @typedef {Object} TodaysMenuInterface
 * @property {string} id - The ID of the menu item.
 * @property {string} image - The URL of the menu item image.
 * @property {string} name - The name of the menu item.
 * @property {number} [imageRef] - The reference number of the menu item image (optional).
 * @property {boolean} today - Indicates whether the menu item is featured as today's special.
 */
