-- ==========================================
-- SCRIPT DE ACTUALIZACIÓN BLESSED BARBER STUDIO (10 SERVICIOS + 9 FOTOS/VIDEOS GALERÍA)
-- ==========================================
-- Pega todo este código en el "SQL Editor" de Supabase y dale a "Run" (Correr).

-- Limpiar tablas
DROP TABLE IF EXISTS public.barbers;
TRUNCATE TABLE public.services;
TRUNCATE TABLE public.gallery;

-- 1. Insertar servicios
INSERT INTO public.services (name, price, description, category) VALUES
('Corte de pelo (fade al 0 moderno)', '14€', 'Degradado super candela + corte a tijera.', 'Cortes'),
('Corte + cejas', '15€', 'Degradado bien afeitado + perfilado de cejas.', 'Cortes'),
('Corte + barba', '18€', 'El combo de siempre. Corte completo + arreglo de barba.', 'Cortes'),
('Corte + barba + cejas', '20€', 'El pack completo.', 'Combos'),
('Corte niño', 'desde 12€', 'Para los pequeños. Hasta los 10 años.', 'Cortes'),
('Barba moderna', '8€', 'Degradado de barba con perfilado.', 'Barba'),
('Cejas', '3€', 'Perfilado con cuchilla o portanavajas.', 'Barba'),
('Mechas rubias', '30€', 'Mechas con acabado natural.', 'Color'),
('Mechas + tinte', '35€', 'Mechas estructuradas tirando al blanco.', 'Color'),
('Decoloración + corte', '50€', 'Decoloración completa + corte.', 'Color');

-- 2. Insertar los 9 elementos de la galería original (3 fotos, 3 videos, 3 fotos)
INSERT INTO public.gallery (media_url, type, order_index) VALUES
('./images/corte-01.jpg?v=2', 'image', 0),
('./images/corte-02.jpg?v=2', 'image', 1),
('./images/corte-03.jpg?v=2', 'image', 2),
('./images/video1.mp4', 'video', 3), -- Video real en el bundle
('./images/video2.mp4', 'video', 4), -- Video real en el bundle
('./images/video3.mp4', 'video', 5), -- Video real en el bundle
('./images/corte-07.jpg', 'image', 6),
('./images/corte-08.jpg?v=2', 'image', 7),
('./images/corte-09.jpg', 'image', 8);

-- 3. Tabla de Trabajadores (Barbers)
CREATE TABLE IF NOT EXISTS public.barbers (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name text NOT NULL,
    role text DEFAULT 'Barbero Especialista',
    emoji text DEFAULT '💈',
    order_index integer DEFAULT 0,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

ALTER TABLE public.barbers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Barbers are viewable by everyone." ON public.barbers
    FOR SELECT USING (true);

-- Insertar trabajadores por defecto
INSERT INTO public.barbers (name, role, emoji, order_index) VALUES
('Gus', 'Maestro Barbero', '💈', 0),
('Deiby', 'Barbero Especialista', '💈', 1),
('David', 'Barbero Especialista', '💈', 2);
