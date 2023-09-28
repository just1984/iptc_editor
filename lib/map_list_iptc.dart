List<int> orderedKeys = [
  //file name
  0x0207, // Edit Status

  // CONTENT #############################
  0x0269, // Headline
  0x0278, // Description
  // iptc subject code
  0x027a, // Description Writer/Editor
  0x020f, // Category
  0x0214, // Other Categories

  // CONTACT #############################
  0x0250, // Creator
  0x0255, // Job-Title
  // address
  0x025a, // City
  0x025f, // Province/State
  0x0264, // PLZ
  0x0265, // Country/Primary Location Name
  // phone
  // email
  // website

  // IMAGE ########################################
  0x0237, // Date Created
  0x023c, // Time Created
  // intellectual genre
  // iptc scene code
  // sublocation
  0x025a, // City
  0x025f, // State
  0x0265, // Country/Primary Location Name
  0x0264, // Country/Primary Location Code

  // STATUS ###########################
  // title
  // job identifier
  // instructions
  // credit line
  // source

  // COPYRIGHT ############################
  0x0274, // Copyright Notice
  // rights usage terms
  // copyright info url

  0x0219, // Keywords

  // Status
  0x020a, // Urgency
  0x0228, // Special Instructions
  0x022a, // Action Advised

  // Contact Info
  0x0276, // Contact

  // Media
  0x0114, // File Format
  0x0116, // File Format Version
  0x0282, // Image Type
  0x0283, // Image Orientation

  // Image Preferences
  0x024b, // Object Cycle

  // Event and Location
  0x025a, // City
  0x025f, // Province/State
  0x0264, // Country/Primary Location Code
  0x0265, // Country/Primary Location Name

  // Locations Taken and Shown
  0x021a, // Content Location Code
  0x021b, // Content Location Name

  // Licensing
  0x02ba, // Short Document ID
  0x02bb, // Unique Document ID
  0x02bc, // Owner ID

  // Others
  0x0100, // Model Version
  0x0105, // Destination
  0x011e, // Service Identifier
  0x0128, // Envelope Number
  0x0132, // Product ID
  0x013c, // Envelope Priority
  0x0146, // Date Sent
  0x0150, // Time Sent
  0x015a, // Coded Character Set
  0x0164, // UNO
  0x0178, // ARM Identifier
  0x017a, // ARM Version
  0x0200, // Record Version
  0x0203, // Object Type Reference
  0x0204, // Object Attribute Reference
  0x0208, // Editorial Update
  0x020c, // Subject Reference
  0x0216, // Fixture Identifier
  0x021e, // Release Date
  0x0223, // Release Time
  0x0225, // Expiration Date
  0x0226, // Expiration Time
  0x022d, // Reference Service
  0x022f, // Reference Date
  0x0232, // Reference Number
  0x023e, // Digital Creation Date
  0x023f, // Digital Creation Time
  0x0241, // Originating Program
  0x0246, // Program Version
  0x025c, // Sub-location
  0x0267, // Original Transmission Reference
  0x027d, // Rasterized Caption
  0x0287 // Language Identifier
];

Map<int, String> iptcTags = {
  // Image Content
  0x0205: "Object Name",
  0x0278: "Description",
  0x0219: "Keywords",
  0x0269: "Headline",
  0x020f: "Category",
  0x0214: "Other Category",

  // Image Rights
  0x0274: "Copyright Notice",

  // Status
  0x0207: "Edit Status",
  0x020a: "Urgency",
  0x0228: "Special Instructions",
  0x022a: "Action Advised",

  // Contact Info
  0x0276: "Contact",

  // Media
  0x0114: "File Format",
  0x0116: "File Format Version",
  0x0282: "Image Type",
  0x0283: "Image Orientation",

  // Image Preferences
  0x024b: "Object Cycle",

  // Event and Location
  0x0237: "Date Created",
  0x023c: "Time Created",
  0x025a: "City",
  0x025f: "Province/State",
  0x0264: "Postal Code",
  0x0265: "Country/Primary Location Name",

  // Locations Taken and Shown
  0x021a: "Content Location Code",
  0x021b: "Content Location Name",

  // CONTACT##################################
  0x0250: "Creator",
  0x0255: "Job Title",

  // Licensing
  0x02ba: "Short Document ID",
  0x02bb: "Unique Document ID",
  0x02bc: "Owner ID",

  // Others
  0x0100: "Model Version",
  0x0105: "Destination",
  0x011e: "Service Identifier",
  0x0128: "Envelope Number",
  0x0132: "Product ID",
  0x013c: "Envelope Priority",
  0x0146: "Date Sent",
  0x0150: "Time Sent",
  0x015a: "Coded Character Set",
  0x0164: "UNO",
  0x0178: "ARM Identifier",
  0x017a: "ARM Version",
  0x0200: "Record Version",
  0x0203: "Object Type Reference",
  0x0204: "Object Attribute Reference",
  0x0208: "Editorial Update",
  0x020c: "Subject Reference",
  0x0216: "Fixture Identifier",
  0x021e: "Release Date",
  0x0223: "Release Time",
  0x0225: "Expiration Date",
  0x0226: "Expiration Time",
  0x022d: "Reference Service",
  0x022f: "Reference Date",
  0x0232: "Reference Number",
  0x023e: "Digital Creation Date",
  0x023f: "Digital Creation Time",
  0x0241: "Originating Program",
  0x0246: "Program Version",
  0x025c: "Sub-location",
  0x0267: "Original Transmission Reference",
  0x027a: "Description Writer/Editor",
  0x027d: "Rasterized Caption",
  0x0287: "Language Identifier",

};
