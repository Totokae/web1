# Project Specification: Virtual Classroom MVP

## 1. Core Concept
A 2D multiplayer virtual world for educational purposes.
- **Visual Style:** Simple 2D Pixel Art aesthetic / Retro.
- **Perspective:** Top-down view (RPG style).
- **Characters:** Simple colored spheres/circles (user picks color on entry).

## 2. Technical Stack (Strict)
- **Framework:** Next.js 14+ (App Router).
- **Language:** TypeScript.
- **Styling:** Tailwind CSS (for UI overlay and modals).
- **Icons:** Lucide React.
- **Rendering:** HTML5 Canvas API (managed via React `useRef` loop).
- **Backend/Infra:** Supabase (Database + Auth + Realtime).

## 3. Key Features & Architecture

### A. Authentication & Roles (Hybrid Model)
1.  **Admin (Teacher):**
    - Authenticated via Supabase Auth (Email/Password).
    - Capabilities: Can EDIT the content of interactive objects (whiteboards).
2.  **Guest (Student):**
    - **No Auth Required** (Anonymous).
    - Entry Flow: Input "Nickname" + Select "Color" -> Store in local React State/Context -> Join Room.
    - Capabilities: Can VIEW objects, move, and chat (optional).

### B. Multiplayer Logic (Supabase Realtime)
- **Channel Type:** `broadcast` (Ephemeral).
- **Data Transmitted:** `{ userId, x, y, color, nickname }`.
- **Frequency:** Throttled updates (e.g., every 50-100ms) to avoid flooding.
- **Persistence:** Player positions are **NOT** stored in the Postgres DB.
- **Presence:** Use Supabase Presence to show a "Who is Online" list.

### C. Interactive Objects (The "Whiteboard")
- **Database Schema:**
    - Table: `interactive_objects`
    - Columns: `id` (uuid), `type` (text, e.g., 'whiteboard'), `content` (text), `position_x` (int), `position_y` (int).
- **Interaction Logic:**
    - Collision detection (distance check) between Avatar and Object.
    - When close: Show "Press E to Interact" tooltip.
    - Interaction: Opens a UI Modal over the canvas.
    - **RLS (Row Level Security):**
        - SELECT: Public (everyone sees content).
        - UPDATE: Authenticated users only (Admins).

## 4. Initial Design Constraints
- **Canvas:** Full screen or large central container.
- **Assets:** Use `ctx.arc` for players and `ctx.fillRect` for the whiteboard. No external images yet.