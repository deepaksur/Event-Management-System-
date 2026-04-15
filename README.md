🚀 Event Management System
SAP ABAP Cloud RAP – Unmanaged Model
📌 Project Overview

This project is a complete Event Management System built using the SAP ABAP Cloud RAP (Unmanaged Model).

It allows users to:

📅 Create and manage events
🎤 Add sessions (items) under events
✏️ Update event details
🗑️ Delete events or sessions
💾 Use draft functionality (auto-save work in progress)
🧠 What is RAP Unmanaged Model?
⚙️ Developer handles CRUD operations manually
🧩 Full control over database transactions
🚗 Works like manual transmission (vs managed = automatic)
🏗️ Architecture Overview
📦 Package: ZCIT_EVT_22IT061

├── 🗄️ Database Tables
│   ├── ZCIT_EVT_H (Header)
│   └── ZCIT_EVT_I (Item)

├── 📊 CDS Views
│   ├── Interface Views (HI / II)
│   └── Consumption Views (HC / IC)

├── 🎨 Metadata Extensions
│   ├── UI Annotations (Header & Item)

├── ⚙️ Behavior Layer
│   ├── Behavior Definition (Unmanaged)
│   ├── Handler Classes (lhc_)
│   └── Saver Class (lsc_)

├── 🔄 Draft Tables
│   ├── ZCIT_EVT_HD
│   └── ZCIT_EVT_ID

└── 🌐 Service Layer
    ├── Service Definition
    └── Service Binding (OData V4)
🧱 Key Components
🗄️ Database Tables
ZCIT_EVT_H → Event Header
ZCIT_EVT_I → Event Sessions
📊 CDS Views
ZCIT_EVT_HI → Root Interface View
ZCIT_EVT_II → Child Interface View
ZCIT_EVT_HC → Header Consumption
ZCIT_EVT_IC → Item Consumption
⚙️ Behavior & Classes
🧠 ZCIT_EVT_UTIL → Buffer Utility
🔧 ZCIT_EVT_H_CL → Header Handler
🔧 ZCIT_EVT_I_H → Item Handler
💾 ZCIT_EVT_I_CL → Saver Class
🌐 Service
ZCIT_EVT_SD → Service Definition
ZCIT_EVT_SB → OData V4 Binding
✨ Features
✅ Create Event with details
✅ Add multiple sessions
✅ Update records
✅ Delete events/sessions
✅ Draft handling (Resume / Discard / Activate)
✅ Fiori UI preview support
⚙️ Prerequisites
🖥️ Eclipse with ABAP Development Tools (ADT)
☁️ SAP BTP ABAP Environment / S4HANA 2022+
📦 Package: ZCIT_EVT_22IT061
🔑 Developer authorization
🧾 Data Element: ZCIT_EVTID
🚀 How to Run
🔧 Activate all objects
🌐 Open Service Binding (ZCIT_EVT_SB)
▶️ Click Publish / Activate
🔍 Click Preview
🟢 Click Go to load data
🧪 Demo Flow
➕ Create Event
Click Create
Enter Event ID + details
Save → ✅ Event Created
🎤 Add Session
Open event → Session tab
Click Create → Save
✅ Session Created
✏️ Update
Click Edit → Modify → Save
✅ Event Updated
🗑️ Delete
Select record → Delete
✅ Deleted Successfully
💾 Draft Feature
Edit without saving
Close & reopen → Resume draft
⚠️ Common Issues & Fixes
❌ Issue	✅ Solution
CDS activation error	Activate both views together
Class not found	Use Ctrl+1 (Quick Fix)
Draft table missing	Auto-create using Quick Fix
No data in preview	Click Go button
Data not saving	Check Saver class
📋 Build Checklist
 DB Tables Created
 CDS Views Activated
 Metadata Extensions Added
 Behavior Definition Done
 Draft Tables Created
 Classes Implemented
 Service Published
 CRUD Working
👨‍💻 Author

Deepak S
🎓 SAP ABAP Cloud Developer
🚀 Full Stack Developer (MERN)

🎉 Conclusion

✅ Fully functional RAP Unmanaged Application
✅ End-to-end CRUD + Draft handling
✅ Ready for real-world SAP Fiori apps

If you want, I can also:

🔥 Make a GitHub banner image
📊 Add architecture diagram
🧾 Convert this into PDF or PPT for viva

Just tell 👍
