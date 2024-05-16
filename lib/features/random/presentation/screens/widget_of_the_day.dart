import 'package:flutter/material.dart';


class WidgetOfTheDay extends StatelessWidget {
  const WidgetOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [

            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150,
                child: _buildGrid()
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.blue,
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Text("Some Text"),
                  )
                ),
              ),
            ),

            // Expanded(
            //   flex: 2,
            //   child: ListView(
            //     scrollDirection: Axis.vertical,
            //     children: const [
            //       ProfileStack(),
            //
            //       CreditCardInfo(
            //         cardNumber: '1234 5678 9012 3456',
            //         expirationDate: '01/25',
            //         cardHolderName: 'John Doe',
            //       ),
            //
            //       TileWidget(title: "CineArts at the Empire", subtitle: '85 W Portal Ave', icon: Icons.theaters),
            //       TileWidget(title: 'The Castro Theater', subtitle: '429 Castro St', icon:  Icons.theaters),
            //       TileWidget(title:'Alamo Drafthouse Cinema', subtitle: '2550 Mission St', icon: Icons.theaters),
            //       TileWidget(title: 'Roxie Theater', subtitle: '3117 16th St', icon: Icons.theaters),
            //       TileWidget(title: 'United Artists Stonestown Twin', subtitle: '501 Buckingham Way', icon: Icons.theaters),
            //       TileWidget(title: 'AMC Metreon 16', subtitle: '135 4th St #3000', icon:  Icons.theaters),
            //
            //       Divider(),
            //
            //       TileWidget(title: 'K\'s Kitchen', subtitle:  '757 Monterey Blvd', icon:  Icons.restaurant),
            //       TileWidget(title: 'Emmy\'s Restaurant', subtitle:  '1923 Ocean Ave', icon:  Icons.restaurant),
            //       TileWidget(title: 'Chaiya Thai Restaurant', subtitle:  '272 Claremont Blvd', icon:  Icons.restaurant),
            //       TileWidget(title: 'La Ciccia', subtitle: '291 30th St', icon:  Icons.restaurant),
            //
            //     ],
            //   ),
            // )
          ],
        )
      ),
    );
  }

  Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 120,
    padding: const EdgeInsets.all(4),
    children: List.generate(6, (index) {
      return Text(
        "Index $index",
      );
    })
  );
}

