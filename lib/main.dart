import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MovieApp());

/// ---------------------------------------------------------------------------
/// Warna & tema
/// ---------------------------------------------------------------------------
const Color kBackground = Color(0xFF0B0B12);
const Color kAccent = Color(0xFF8B5CF6);
const Color kAccentPink = Color(0xFFEC4899);
const LinearGradient kAccentGradient = LinearGradient(
  colors: [kAccent, kAccentPink],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

/// ---------------------------------------------------------------------------
/// Model & data dummy
/// ---------------------------------------------------------------------------
class Movie {
  final String title;
  final String year;
  final String genre;
  final double rating;
  final String posterUrl;
  final String overview;

  const Movie({
    required this.title,
    required this.year,
    required this.genre,
    required this.rating,
    required this.posterUrl,
    this.overview =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
  });
}

String _poster(String seed) => 'https://picsum.photos/seed/$seed/400/600';

final List<Movie> nowPlaying = [
  Movie(
      title: 'Deadpool & Wolverine',
      year: '2024',
      genre: 'Action',
      rating: 7.7,
      posterUrl: _poster('deadpool')),
  Movie(
      title: 'Inside Out 2',
      year: '2024',
      genre: 'Animation',
      rating: 7.6,
      posterUrl: _poster('insideout')),
  Movie(
      title: 'Twisters',
      year: '2024',
      genre: 'Adventure',
      rating: 6.9,
      posterUrl: _poster('twisters')),
  Movie(
      title: 'Despicable Me 4',
      year: '2024',
      genre: 'Comedy',
      rating: 7.0,
      posterUrl: _poster('despicable')),
];

final List<Movie> trending = [
  Movie(
      title: 'Bad Boys: Ride or Die',
      year: '2024',
      genre: 'Action',
      rating: 7.0,
      posterUrl: _poster('badboys')),
  Movie(
      title: 'Inside Out 2',
      year: '2024',
      genre: 'Animation',
      rating: 7.6,
      posterUrl: _poster('trend2')),
  Movie(
      title: 'Beetlejuice Beetlejuice',
      year: '2024',
      genre: 'Comedy',
      rating: 7.2,
      posterUrl: _poster('trend3')),
  Movie(
      title: 'A Quiet Place: Day One',
      year: '2024',
      genre: 'Horror',
      rating: 6.8,
      posterUrl: _poster('quiet')),
  Movie(
      title: 'Planet of the Apes',
      year: '2024',
      genre: 'Sci-Fi',
      rating: 7.1,
      posterUrl: _poster('trend5')),
];

final List<Movie> popular = [
  Movie(
      title: 'Longlegs',
      year: '2024',
      genre: 'Thriller',
      rating: 6.6,
      posterUrl: _poster('pop1')),
  Movie(
      title: 'Fallout',
      year: '2024',
      genre: 'Drama',
      rating: 8.4,
      posterUrl: _poster('fallout')),
  Movie(
      title: 'Music Country',
      year: '2024',
      genre: 'Music',
      rating: 7.3,
      posterUrl: _poster('pop3')),
  Movie(
      title: 'Borderlands',
      year: '2024',
      genre: 'Action',
      rating: 5.4,
      posterUrl: _poster('pop4')),
  Movie(
      title: 'The Union',
      year: '2024',
      genre: 'Action',
      rating: 6.1,
      posterUrl: _poster('pop5')),
];

final List<Movie> topRated = [
  Movie(
      title: 'Oppenheimer',
      year: '2023',
      genre: 'Drama',
      rating: 8.1,
      posterUrl: _poster('top1')),
  Movie(
      title: 'Anatomie d\'une Chute',
      year: '2023',
      genre: 'Drama',
      rating: 7.6,
      posterUrl: _poster('top2')),
  Movie(
      title: 'Perfect Days',
      year: '2023',
      genre: 'Drama',
      rating: 7.9,
      posterUrl: _poster('top3')),
  Movie(
      title: 'Past Lives',
      year: '2023',
      genre: 'Romance',
      rating: 7.8,
      posterUrl: _poster('top4')),
  Movie(
      title: 'The Zone of Interest',
      year: '2023',
      genre: 'War',
      rating: 7.4,
      posterUrl: _poster('top5')),
];

/// ---------------------------------------------------------------------------
/// App
/// ---------------------------------------------------------------------------
class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark(useMaterial3: true);
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        scaffoldBackgroundColor: kBackground,
        textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
        colorScheme: base.colorScheme.copyWith(primary: kAccent),
      ),
      home: const HomePage(),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Home
/// ---------------------------------------------------------------------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang blur mengikuti poster yang sedang aktif
          Positioned.fill(child: _AmbientBackground(movie: nowPlaying[_index])),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 32),
              children: [
                const _Header(),
                const SizedBox(height: 12),
                CarouselSlider.builder(
                  itemCount: nowPlaying.length,
                  options: CarouselOptions(
                    height: 400,
                    viewportFraction: 0.72,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.22,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    onPageChanged: (i, _) => setState(() => _index = i),
                  ),
                  itemBuilder: (context, i, _) =>
                      NowPlayingCard(movie: nowPlaying[i]),
                ),
                const SizedBox(height: 14),
                _DotsIndicator(count: nowPlaying.length, current: _index),
                const SizedBox(height: 20),
                MovieSection(title: 'Trending', movies: trending),
                MovieSection(title: 'Popular', movies: popular),
                MovieSection(title: 'Top Rated', movies: topRated),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientBackground extends StatelessWidget {
  final Movie movie;
  const _AmbientBackground({required this.movie});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      child: SizedBox.expand(
        key: ValueKey(movie.posterUrl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
              child: Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const ColoredBox(color: kBackground),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black38, kBackground],
                  stops: [0.0, 0.62],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Discover',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(170),
                        letterSpacing: 1.2)),
                const SizedBox(height: 2),
                ShaderMask(
                  shaderCallback: (r) => kAccentGradient.createShader(r),
                  child: const Text('Now Playing',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
          const _GlassCircle(
            size: 42,
            child: Icon(Icons.search_rounded, size: 22),
          ),
        ],
      ),
    );
  }
}

class _GlassCircle extends StatelessWidget {
  final double size;
  final Widget child;
  const _GlassCircle({required this.size, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withAlpha(45)),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int current;
  const _DotsIndicator({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 24 : 6,
          height: 6,
          decoration: BoxDecoration(
            gradient: active ? kAccentGradient : null,
            color: active ? null : Colors.white24,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Kartu carousel "Now Playing"
/// ---------------------------------------------------------------------------
class NowPlayingCard extends StatelessWidget {
  final Movie movie;
  const NowPlayingCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: kAccent.withAlpha(70),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            PosterImage(url: movie.posterUrl),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
            // Badge rating
            Positioned(
                top: 14, left: 14, child: RatingBadge(rating: movie.rating)),
            // Panel kaca di bawah
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(90),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withAlpha(35)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                movie.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  _Chip(text: movie.year),
                                  const SizedBox(width: 6),
                                  _Chip(text: movie.genre),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movie.overview,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10,
                                    height: 1.4,
                                    color: Colors.white.withAlpha(190)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            gradient: kAccentGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward_rounded,
                              size: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 9)),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;
  final bool small;
  const RatingBadge({super.key, required this.rating, this.small = false});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: small ? 6 : 10, vertical: small ? 3 : 5),
          color: Colors.black.withAlpha(120),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_rounded,
                  size: small ? 11 : 15, color: const Color(0xFFFFC53D)),
              const SizedBox(width: 3),
              Text(rating.toStringAsFixed(1),
                  style: TextStyle(
                      fontSize: small ? 9 : 11, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Section horizontal (Trending / Popular / Top Rated)
/// ---------------------------------------------------------------------------
class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  const MovieSection({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 18,
                  decoration: BoxDecoration(
                    gradient: kAccentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withAlpha(30)),
                  ),
                  child: const Text('More', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 238,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) => PosterCard(movie: movies[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class PosterCard extends StatelessWidget {
  final Movie movie;
  const PosterCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 14,
                    offset: Offset(0, 8)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  PosterImage(url: movie.posterUrl),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: RatingBadge(rating: movie.rating, small: true),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
          const SizedBox(height: 1),
          Text('${movie.year} • ${movie.genre}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: 9, color: Colors.white.withAlpha(140))),
        ],
      ),
    );
  }
}

/// Gambar poster dengan loading & error fallback
class PosterImage extends StatelessWidget {
  final String url;
  const PosterImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : const ColoredBox(color: Color(0xFF1C1C28)),
      errorBuilder: (_, __, ___) => const ColoredBox(
        color: Color(0xFF1C1C28),
        child: Center(child: Icon(Icons.movie_rounded, color: Colors.white38)),
      ),
    );
  }
}
