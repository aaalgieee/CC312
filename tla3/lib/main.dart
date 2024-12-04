import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MovieExplorerApp());
}

class MovieExplorerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Explorer',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/genres': (context) => GenresScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/search': (context) => SearchScreen(),
        '/details': (context) => MovieDetailsScreen(),
      },
    );
  }
}

// Stateless Widgets
class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _popularMovies = [
    {
      'title': 'Inception',
      'poster': 'https://via.placeholder.com/150',
      'rating': 8.8
    },
    {
      'title': 'The Matrix',
      'poster': 'https://via.placeholder.com/150',
      'rating': 8.7
    },
    {
      'title': 'Interstellar',
      'poster': 'https://via.placeholder.com/150',
      'rating': 8.6
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Explorer'),
      ),
      body: ListView(
        children: [
          _buildSectionTitle('Popular Movies'),
          _buildPopularMovies(context),
          _buildSectionTitle('Quick Actions'),
          _buildQuickActions(context),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPopularMovies(BuildContext context) {
    return Container(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _popularMovies.length,
        itemBuilder: (context, index) {
          var movie = _popularMovies[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: movie);
            },
            child: Container(
              width: 150,
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(movie['poster'], height: 180, fit: BoxFit.cover),
                  Text(
                    movie['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Rating: ${movie['rating']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/genres'),
          child: Text('Genres'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/search'),
          child: Text('Search Movies'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/favorites'),
          child: Text('My Favorites'),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Genres'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.pushNamed(context, '/genres');
            break;
          case 2:
            Navigator.pushNamed(context, '/search');
            break;
        }
      },
    );
  }
}

// Stateful Hook Widget for Search Screen
class SearchScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final searchResults = useState<List<String>>([]);

    void performSearch(String query) {
      // Simulated search functionality
      searchResults.value = [
        'Movie 1 about $query',
        'Movie 2 related to $query',
        'Movie 3 matching $query'
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for movies...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => performSearch(searchController.text),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.value.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults.value[index]),
                  onTap: () {
                    Navigator.pushNamed(context, '/details');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Stateful Hook Widget for Favorites Screen
class FavoritesScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = useState<List<String>>([
      'Inception',
      'The Matrix',
      'Interstellar'
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.value.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(favorites.value[index]),
            onDismissed: (direction) {
              favorites.value.removeAt(index);
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(favorites.value[index]),
              trailing: Icon(Icons.favorite, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}

// Stateless Widget for Genres Screen
class GenresScreen extends StatelessWidget {
  final List<String> _genres = [
    'Action', 'Comedy', 'Drama', 'Sci-Fi', 'Thriller'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Genres'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        itemCount: _genres.length,
        itemBuilder: (context, index) {
          return Card(
            child: Center(
              child: Text(
                _genres[index],
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Stateless Widget for Movie Details Screen
class MovieDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?
        ?? {'title': 'Unknown Movie', 'poster': 'https://via.placeholder.com/300', 'rating': 'N/A'};

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(movie['poster'], height: 300, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(
              movie['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rating: ${movie['rating']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add to favorites logic would go here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to Favorites!'))
                );
              },
              child: Text('Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}