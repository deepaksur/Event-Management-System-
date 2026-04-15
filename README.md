# 🚀 Event Management System  
### SAP ABAP Cloud RAP – Unmanaged Model 📌

---

## 📖 Project Overview  

This project is a complete **Event Management System** built using  
**SAP ABAP Cloud RAP (Unmanaged Model)**.

---

## ✨ Features  

- 📅 Create and manage events  
- 🎤 Add sessions (items) under events  
- ✏️ Update event details  
- 🗑️ Delete events & sessions  
- 💾 Draft functionality (auto-save work in progress)  

---

## 🧠 RAP Unmanaged Model  

- ⚙️ Developer handles CRUD operations manually  
- 🧩 Full control over database transactions  
- 🚗 Works like **manual transmission**  
  *(managed = automatic)*  

---

## 🏗️ Architecture Overview  
📦 Package: ZCIT_EVT_22IT061

├── 🗄️ Database Tables
│ ├── ZCIT_EVT_H (Header)
│ └── ZCIT_EVT_I (Item)

├── 📊 CDS Views
│ ├── Interface Views (HI / II)
│ └── Consumption Views (HC / IC)

├── 🎨 Metadata Extensions
│ └── UI Annotations (Header & Item)

├── ⚙️ Behavior Layer
│ ├── Behavior Definition (Unmanaged)
│ ├── Handler Classes (lhc_)
│ └── Saver Class (lsc_)

├── 🔄 Draft Tables
│ ├── ZCIT_EVT_HD
│ └── ZCIT_EVT_ID

└── 🌐 Service Layer
├── Service Definition
└── Service Binding (OData V4)


---

## 🔑 Key Components  

### 🗄️ Database Tables  
- `ZCIT_EVT_H` → Event Header  
- `ZCIT_EVT_I` → Event Sessions  

### 📊 CDS Views  
- `ZCIT_EVT_HI` → Root Interface View  
- `ZCIT_EVT_II` → Child Interface View  
- `ZCIT_EVT_HC` → Header Consumption View  
- `ZCIT_EVT_IC` → Item Consumption View  

### ⚙️ Behavior & Classes  
- 🧠 `ZCIT_EVT_UTIL` → Buffer Utility  
- 🔧 `ZCIT_EVT_H_CL` → Header Handler  
- 🔧 `ZCIT_EVT_I_H` → Item Handler  
- 💾 `ZCIT_EVT_I_CL` → Saver Class  

### 🌐 Service  
- `ZCIT_EVT_SD` → Service Definition  
- `ZCIT_EVT_SB` → OData V4 Binding  

---

## 🚀 How to Run  

1. Activate all objects  
2. Open **Service Binding (ZCIT_EVT_SB)**  
3. Click **Publish / Activate**  
4. Click **Preview**  
5. Click **Go** to load data  

---

## 🧪 Demo  

### ➕ Create Event  
- Click **Create**  
- Enter details  
- Save → ✅ Event Created  

### 🎤 Add Session  
- Open event → Session tab  
- Create session → Save  
- ✅ Session Created  

### ✏️ Update  
- Edit → Modify → Save  
- ✅ Event Updated  

### 🗑️ Delete  
- Select → Delete  
- ✅ Deleted  

### 💾 Draft  
- Edit without saving  
- Resume later  

---

## ⚠️ Common Issues  

| ❌ Problem | ✅ Solution |
|-----------|-----------|
| CDS activation error | Activate both views together |
| Class error | Use Ctrl+1 (Quick Fix) |
| Draft table missing | Auto-create |
| No data in preview | Click Go |
| Data not saving | Check saver class |

---

## 👨‍💻 Author  

**Deepak S**  
🎓 SAP ABAP Cloud Developer  
🚀 Full Stack Developer  

---

## 🎉 Conclusion  

✔️ Complete RAP Unmanaged Application  
✔️ CRUD + Draft Support  
✔️ Ready for SAP Fiori UI  

---
