export interface Stay {
  id: string
  title: string
  location: string
  host: string
  hostType?: string
  price: number
  rating: number
  images: string[]
  isGuestFavorite?: boolean
  dates?: string
  category?: string
}

export interface StayCategory {
  name: string
  icon: string
  count?: number
}

export interface StaySearchFilters {
  location?: string
  checkIn?: string
  checkOut?: string
  guests?: number
  minPrice?: number
  maxPrice?: number
  category?: string
}
