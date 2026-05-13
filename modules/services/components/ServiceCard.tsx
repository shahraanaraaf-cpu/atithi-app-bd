import { CardBase } from '@/components/shared/CardBase'
import type { Service } from '../types/services.types'

import { useTranslations, useLocale } from 'next-intl'
import { srvTitleTranslations, srvProviderTranslations, srvLocationTranslations } from '../utils/translations'

interface ServiceCardProps {
  service: Service
}

export function ServiceCard({ service }: ServiceCardProps) {
  const t = useTranslations('Services')

  const locale = useLocale() as 'en' | 'bn'

  const localizedTitle = srvTitleTranslations[service.title]?.[locale] || service.title
  const localizedProvider = srvProviderTranslations[service.provider]?.[locale] || service.provider
  const localizedLocation = srvLocationTranslations[service.location]?.[locale] || service.location

  return (
    <CardBase
      id={service.id}
      href={`/${locale}/services/${service.id}`}
      image={service.image}
      title={localizedTitle}
      subtitle={`${service.rating} (${service.reviews}) · ${localizedLocation}`}
      price={service.price}
      rating={service.rating}
      badge={service.reviews > 200 ? t('topRated') : undefined}
      location={`${t('by')} ${localizedProvider}`}
      priceLabel={t('perService')}
      aspectRatio="square"
    />
  )
}
