# Design System Strategy: Ethereal Geometry

## 1. Overview & Creative North Star
The Creative North Star for this design system is **"The Digital Sanctuary."** 

This system transcends traditional flat UI by merging the mathematical precision of Islamic geometry with the fluid, light-refracting properties of futuristic glassmorphism. We are not building a dashboard; we are crafting a contemplative space. The experience must feel "weightless" yet grounded in heritage. 

To break the "template" look, we utilize **Intentional Asymmetry**. Layouts should avoid perfect 50/50 splits, opting instead for overlapping "glass" containers that break the container bounds, mimicking the way light spills across a room. High-contrast typography scales—pairing massive, thin headlines with compact, functional body text—create an editorial rhythm that feels premium and curated.

---

## 2. Colors & Atmospheric Depth
Our palette is rooted in the "Deep Night" of the `surface` and the "Radiant Light" of our emerald and gold accents.

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1px solid borders for sectioning or layout containment. Boundaries must be defined strictly through:
1.  **Background Color Shifts:** Placing a `surface_container_high` card against a `surface_dim` background.
2.  **Tonal Transitions:** Using soft gradients to suggest where one area ends and another begins.

### Surface Hierarchy & Nesting
Treat the UI as a physical stack of semi-transparent materials.
*   **Base:** `surface_dim` (#0b1326) provides the infinite depth of a night sky.
*   **The Mid-Plane:** Use `surface_container` for primary content areas.
*   **The Focal Plane:** Use `surface_container_highest` for active modals or hovering elements to pull them toward the user.

### The "Glass & Gradient" Rule
To achieve the "Futuristic Islamic" feel, primary CTAs and hero elements must utilize a **Refractive Gradient**. Transition from `primary` (#4edea3) to `on_primary_container` (#00a471) at a 135-degree angle. This provides a "soul" to the UI that flat fills cannot replicate.

### Signature Textures
Integrate Islamic motifs (Star/Octagon) as subtle, low-opacity SVG patterns nested within the `surface_container_lowest` layer. These should act as "watermarks of quality"—visible only upon second glance, using the `outline_variant` at 5% opacity.

---

## 3. Typography
The typography system uses a dual-sans approach to balance modern tech with editorial elegance.

*   **Display & Headlines (Plus Jakarta Sans):** These are our "Architectural" weights. Use `display-lg` and `headline-lg` with tight letter-spacing (-2%) to create a sense of authority and modernity. 
*   **Title & Body (Inter):** These are our "Functional" weights. Inter’s neutral, high-legibility profile ensures that even against complex "glass" backgrounds, the content remains accessible.
*   **The Hierarchy Goal:** Use extreme scale contrast. A `display-sm` title paired with a `label-md` caption creates a sophisticated, "high-fashion" layout rhythm that signals premium quality.

---

## 4. Elevation & Depth
In this system, depth is a result of light, not shadow.

### The Layering Principle
Stacking `surface` tokens is the primary method of organization. For example, a "Search Bar" should not have a shadow; it should be a `surface_container_lowest` pill sitting inside a `surface_container_high` header.

### Ambient Shadows & Glowing Edges
When a floating effect is required (e.g., a top-level modal):
*   **Shadows:** Use a blur radius of 40px–60px with the color `surface_container_lowest` at 15% opacity.
*   **Inner Glow:** To simulate "glass edges," apply a 1px inner stroke using `primary` at 20% opacity. This creates a "light-catching" edge characteristic of premium glassmorphism.

### The "Ghost Border" Fallback
If accessibility requirements demand a border, use the `outline_variant` token at **15% opacity**. This creates a "Ghost Border"—a suggestion of a boundary that does not interrupt the visual flow of the glass.

---

## 5. Components

### Glass Cards
*   **Styling:** Background-blur (backdrop-filter: blur(20px)), `surface_variant` at 40% opacity.
*   **Rule:** No dividers. Use `surface_container_low` for nested metadata blocks within the card to create separation.

### Buttons
*   **Primary:** A gradient-filled container (`primary` to `on_primary_container`) with `on_primary` text. Use `xl` (1.5rem) roundedness for a soft, modern feel.
*   **Secondary:** Ghost-style. No fill, `outline` at 20% opacity, with `primary` colored text.
*   **Interaction:** On hover, increase the inner-glow opacity rather than changing the background color.

### Input Fields
*   **Structure:** `surface_container_lowest` fill. 
*   **Focus State:** The `outline` transitions from 20% opacity to a glowing `secondary` (#e9c349) at 50% opacity.

### Selection Chips
*   **State:** Unselected chips should be `surface_container_high`. Selected chips should glow with a `primary_container` background and `primary` text.

### Floating Geometric Accents (New Component)
*   Small, 8-point star motifs (`secondary_fixed_dim`) placed at the intersection of glass cards to act as "structural pins" for the layout.

---

## 6. Do’s and Don’ts

### Do:
*   **Embrace Negative Space:** Allow the `surface_dim` background to breathe between glass cards.
*   **Layer Patterns:** Place geometric patterns *behind* the glass blur for a "frosted" look.
*   **Use Tonal Text:** Use `on_surface_variant` for secondary info to maintain the "calm" atmosphere.

### Don't:
*   **Don't use pure black (#000):** It kills the depth of the "Deep Blue" brand identity.
*   **Don't use hard drop shadows:** They make the UI feel heavy and dated.
*   **Don't use Dividers:** Never use a horizontal line to separate list items. Use a 12px or 16px gap from the Spacing Scale or a subtle shift to `surface_container_low`.
*   **Don't Over-Saturate:** Keep the `emerald green` and `soft gold` for "moments of delight" (CTAs, Icons, Active States) rather than large background fills.