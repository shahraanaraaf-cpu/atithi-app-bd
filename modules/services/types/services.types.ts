export interface Service {
  id: string
  title: string
  provider: string
  price: number
  rating: number
  image: string
  reviews: number
  location: string
  category?: string
}

export interface ServiceCategory {
  id: string
  name: string
  count: number
  icon: string
  image: string
}

export interface ServiceFilters {
  category?: string
  location?: string
  minPrice?: number
  maxPrice?: number
}
