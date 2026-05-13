import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: 'Atithi App BD',
  description: 'Discover and book unique stays, experiences, and services across Bangladesh',
  keywords: ['accommodation', 'travel', 'Bangladesh', 'stays', 'experiences', 'services'],
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return children;
}
