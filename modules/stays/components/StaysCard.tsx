import { CardBase } from '@/components/shared/CardBase'
import type { Stay } from '../types/stays.types'

import { useTranslations, useLocale } from 'next-intl'
import { locationTranslations, hostTranslations } from '../utils/translations'

interface StaysCardProps {
  stay: Stay
}

export function StaysCard({ stay }: StaysCardProps) {
  const t = useTranslations('Experiences')
  const ti = useTranslations('Index')
  const locale = useLocale() as 'en' | 'bn'

  const localizedLocation = locationTranslations[stay.location]?.[locale] || stay.location
  const localizedHost = hostTranslations[stay.host]?.[locale] || stay.host

  return (
    <CardBase
      id={stay.id}
      href={`/${locale}/rooms/${stay.id}`}
      image={stay.images[0] || ''}
      title={localizedLocation}
      subtitle={`${stay.rating.toFixed(2)}`}
      price={stay.price}
      rating={stay.rating}
      badge={stay.isGuestFavorite ? t('guestFavorite') : undefined}
      location={localizedHost}
      priceLabel={ti('pricePerNight')}
      aspectRatio="square"
    />
  )
}
