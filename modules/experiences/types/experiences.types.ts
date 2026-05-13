export interface Experience {
  id: string
  title: string
  hostType: string
  price: number
  rating: number
  image: string
  location?: string
  badge?: string
  category?: string
  duration?: string
}

export interface ExperienceCategory {
  id: string
  name: string
  count: number
  gradient: string
  icon: string
  image: string
}

export interface ExperienceFilters {
  category?: string
  location?: string
  date?: string
  minPrice?: number
  maxPrice?: number
}
