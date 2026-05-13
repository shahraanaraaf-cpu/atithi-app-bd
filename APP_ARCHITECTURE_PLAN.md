# Three-App Module Separation Plan

**Goal:** Reorganize Atithi App BD into three distinct modules (Stays, Experiences, Services) within a single Next.js app for better performance, maintainability, and UI consistency.

---

## 1. Folder Structure

```
app/
├── (app)/                          # Route groups for each app
│   ├── (stays)/                    # Stays module
│   │   ├── page.tsx                # Homepage (was [locale]/page.tsx)
│   │   ├── search/
│   │   ├── rooms/[id]/
│   │   └── layout.tsx              # Stays-specific layout
│   │
│   ├── (experiences)/              # Experiences module
│   │   ├── page.tsx                # (was [locale]/experiences/page.tsx)
│   │   ├── [id]/
│   │   └── layout.tsx              # Experiences-specific layout
│   │
│   └── (services)/                 # Services module
│       ├── page.tsx                # (was [locale]/services/page.tsx)
│       ├── [id]/
│       └── layout.tsx              # Services-specific layout
│
├── modules/                        # Module-specific code
│   ├── stays/
│   │   ├── components/
│   │   │   ├── StaysCard.tsx       # Unified card (replaces ListingCard)
│   │   │   ├── StaysFilter.tsx
│   │   │   └── StaysSearch.tsx
│   │   ├── data/
│   │   │   ├── staysCategories.ts
│   │   │   └── staysListings.ts
│   │   ├── hooks/
│   │   │   └── useStays.ts
│   │   └── types/
│   │       └── stays.types.ts
│   │
│   ├── experiences/
│   │   ├── components/
│   │   │   ├── ExperienceCard.tsx  # Unified with consistent design
│   │   │   ├── CategoryCarousel.tsx
│   │   │   └── ExperienceFilter.tsx
│   │   ├── data/
│   │   │   ├── experienceCategories.ts
│   │   │   └── experienceData.ts
│   │   ├── hooks/
│   │   │   └── useExperiences.ts
│   │   └── types/
│   │       └── experiences.types.ts
│   │
│   └── services/
│       ├── components/
│       │   ├── ServiceCard.tsx     # Unified with consistent design
│       │   ├── ServiceCategories.tsx
│       │   └── ServiceFilter.tsx
│       ├── data/
│       │   ├── serviceCategories.ts
│       │   └── serviceData.ts
│       ├── hooks/
│       │   └── useServices.ts
│       └── types/
│           └── services.types.ts
│
├── components/
│   ├── shared/                     # Cross-module shared components
│   │   ├── AppShell.tsx            # Common layout wrapper
│   │   ├── GlobalHeader.tsx        # Header with tab navigation
│   │   ├── GlobalFooter.tsx        # Shared footer
│   │   ├── CardBase.tsx            # Base card component (unified)
│   │   ├── PriceDisplay.tsx
│   │   ├── RatingBadge.tsx
│   │   └── WishlistButton.tsx
│   │
│   └── ui/                         # Primitive UI components
│       ├── Button.tsx
│       ├── Input.tsx
│       └── Badge.tsx
│
└── lib/
    ├── utils.ts
    ├── constants.ts
    └── design-system.ts            # Shared Tailwind config extensions
```

---

## 2. Component Unification Strategy

### Unified Card Design System

Create `CardBase.tsx` with consistent props, then module-specific wrappers:

```typescript
// Base card handles: image, badge, wishlist, hover effects
interface CardBaseProps {
  id: string;
  image: string;
  title: string;
  subtitle?: string;
  price: number;
  rating: number;
  badge?: string;
  location?: string;
  aspectRatio?: 'square' | 'portrait' | 'landscape';
}

// Module-specific cards extend base
StaysCard → aspectRatio: 'square', shows: location, host, dates
ExperienceCard → aspectRatio: 'portrait', shows: hostType, "From ৳X/guest"  
ServiceCard → aspectRatio: 'landscape', shows: provider, "৳X/service"
```

### Shared Header with Dynamic Navigation

```typescript
// GlobalHeader reads current route from (app) group
// Shows: Stays | Experiences | Services tabs
// Each tab gets active styling based on current route group
```

---

## 3. Data Layer Separation

### Module-Specific Data Files

| Module | Data File | Purpose |
|--------|-----------|---------|
| stays | `staysCategories.ts` | Bangladesh-specific stay categories |
| stays | `staysListings.ts` | Static listing data + mock data |
| experiences | `experienceCategories.ts` | Activity categories with gradients/icons |
| experiences | `experienceData.ts` | All experience listings |
| services | `serviceCategories.ts` | Service types (chef, driver, etc) |
| services | `serviceData.ts` | Service providers data |

### Type Safety

```typescript
// modules/stays/types/stays.types.ts
export interface Stay {
  id: string;
  title: string;
  location: string;
  host: string;
  price: number;
  rating: number;
  images: string[];
  category: StayCategory;
}

// modules/experiences/types/experiences.types.ts  
export interface Experience {
  id: string;
  title: string;
  hostType: string;
  price: number;
  rating: number;
  image: string;
  category: ExperienceCategory;
  duration?: string;
}

// modules/services/types/services.types.ts
export interface Service {
  id: string;
  title: string;
  provider: string;
  price: number;
  rating: number;
  image: string;
  category: ServiceCategory;
  reviews: number;
}
```

---

## 4. Performance Optimizations

### Code Splitting by Module

```typescript
// Each layout.tsx uses dynamic imports for heavy components
import { lazy, Suspense } from 'react';

const StaysFilter = lazy(() => import('../modules/stays/components/StaysFilter'));
```

### Image Optimization

- Remove `unoptimized` props from all Image components
- Use Next.js Image with proper `sizes` and `priority` attributes
- Add gradient fallbacks for missing images (already done for experiences)

### Server Components by Default

- Make pages Server Components where possible
- Move Client Component logic to hooks in modules
- Only 'use client' for interactive components

---

## 5. Migration Phases

### Phase 1: Foundation (1-2 days)
1. Create `modules/` directory structure
2. Move data constants from pages to module data files
3. Create unified `CardBase` component
4. Set up route groups `(stays)`, `(experiences)`, `(services)`

### Phase 2: Component Migration (2-3 days)
1. Migrate `ListingCard` → `StaysCard` using CardBase
2. Migrate `ExperienceCard` → unified design
3. Migrate `ServiceCard` → unified design
4. Create module-specific layouts with proper headers

### Phase 3: Page Migration (1-2 days)
1. Move stays page to `(stays)/page.tsx`
2. Move experiences page to `(experiences)/page.tsx`
3. Move services page to `(services)/page.tsx`
4. Update all imports and links

### Phase 4: Cleanup (1 day)
1. Remove old duplicate components
2. Consolidate shared components into `components/shared/`
3. Update TypeScript paths if needed
4. Test navigation between all three apps

---

## 6. Consistency Checklist

### Visual Consistency
- [ ] Same card border radius (rounded-2xl)
- [ ] Same shadow styles (shadow-sm, hover:shadow-md)
- [ ] Same price/rating text hierarchy
- [ ] Same Atithi red (#C62D2D) across all badges/icons
- [ ] Same hover transitions (duration-300, ease-out)

### UX Consistency
- [ ] All cards link to detail page
- [ ] All have wishlist heart button
- [ ] All show "Guest favorite" or similar badge
- [ ] All show rating with star icon

### Code Consistency
- [ ] All modules export from index.ts barrel files
- [ ] All use shared types from lib/types/
- [ ] All data files use consistent naming (camelCase)
- [ ] All hooks use React Query or SWR pattern

---

## 7. Shared Resources

### Components to Keep Shared
- `GlobalHeader` - navigation between apps
- `GlobalFooter` - consistent footer
- `CardBase` - unified card foundation
- `PriceDisplay` - consistent ৳ formatting
- `RatingBadge` - consistent star ratings
- `WishlistButton` - consistent heart/favorite UI

### Hooks to Keep Shared
- `useAuth` - authentication state
- `useCurrency` - BDT conversion/display
- `useLocale` - i18n handling

---

## Expected Outcomes

1. **Performance**: Smaller bundles per route, faster navigation
2. **Maintainability**: Clear boundaries, easier to add features
3. **Consistency**: Unified design system across all three apps
4. **Scalability**: Each module can grow independently
5. **Developer Experience**: Clear file organization, predictable patterns

---

## Files to Create/Modify

### New Files (~15)
- `modules/stays/index.ts` (barrel export)
- `modules/experiences/index.ts`
- `modules/services/index.ts`
- `components/shared/CardBase.tsx`
- `components/shared/GlobalHeader.tsx`
- Module-specific component folders
- Module-specific data folders
- Module-specific type folders

### Modified Files (~8)
- Move `app/[locale]/page.tsx` → `app/(app)/(stays)/page.tsx`
- Move `app/[locale]/experiences/page.tsx` → `app/(app)/(experiences)/page.tsx`
- Move `app/[locale]/services/page.tsx` → `app/(app)/(services)/page.tsx`
- Update `Header.tsx` → `GlobalHeader.tsx`
- Update all card components
- Update `next.config.js` if needed for paths
