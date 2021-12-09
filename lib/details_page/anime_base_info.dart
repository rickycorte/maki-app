import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maki/models/anime_details.dart';
import 'package:maki/models/user.dart';

class AnimeBaseInfo extends StatefulWidget {
  AnimeDetails? anime;

  final bool expandedDesc;

  AnimeBaseInfo({Key? key, required this.anime, this.expandedDesc = false})
      : super(key: key);

  @override
  State<AnimeBaseInfo> createState() => AnimeBaseInfoState();
}

class AnimeBaseInfoState extends State<AnimeBaseInfo> {
  //variabile per tener conto delle linee da far vedere nella descrizione dell'anime
  int? number_of_line = 3;

  //Variabile per nascondere la descrizione con effetto fade oppure no
  TextOverflow descripton_exposure = TextOverflow.fade;

  //Variabile per controllare la forma del botton con cui nascondere la descrizione
  IconData botton_description = Icons.keyboard_arrow_down_outlined;

  void _onAddItemToListButtonPress() async {
    // msg be generated before the add/remove methond changes the anime state
    String msg = widget.anime!.isInUserList()
        ? "Removed ${widget.anime!.title} from your list"
        : "Added ${widget.anime!.title} to your list";

    if (widget.anime!.isInUserList()) {
      // show dialog to ask confirmation
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text(
              "Are you sure you want to remove `${widget.anime!.title}` from your list?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // remove item
                await User.current!.removeFromList(widget.anime!);
                //dismiss dialog
                Navigator.of(context).pop();
                // show confirmation as a snackbar
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(msg),
                ));
                // update page state
                setState(() {});
              },
              child: const Text("Proceed"),
            ),
          ],
        ),
      );
    } else {
      await User.current!.addToPlanning(widget.anime!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
      ));
      setState(() {});
    }
  }

  Widget _buildTitleBlock(context) {
    // prepare data to output
    String formattedGenres = "";
    for (int i = 0; i < widget.anime!.genres.length; i++) {
      formattedGenres += " - " + widget.anime!.genres[i];
    }

    formattedGenres = formattedGenres.isNotEmpty
        ? formattedGenres.substring(3)
        : formattedGenres; // remove the " - " characters added by the first element

    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0), // 15
            child: Text(
              widget.anime!.title,
              textAlign: TextAlign.center,
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
          ),
          if (formattedGenres.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                formattedGenres,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: _onAddItemToListButtonPress,
                child: Text(widget.anime!.isInUserList()
                    ? "- Remove From My List"
                    : "+ Add To My List"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Funzione per cambiare lo stato per nascondere o no la descrizione
  void updateDescription() {
    setState(
      () {
        if (number_of_line == null) {
          number_of_line = 3;
          descripton_exposure = TextOverflow.fade;
          botton_description = Icons.keyboard_arrow_down_outlined;
        } else {
          number_of_line = null;
          descripton_exposure = TextOverflow.visible;
          botton_description = Icons.keyboard_arrow_up_outlined;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const elementPadding = 20.0;

    return Column(
      children: [
        _buildTitleBlock(context),
        const SizedBox(height: elementPadding),
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Text(
            widget.anime!.description
                .replaceAll("<br>", "\n")
                .replaceAll(RegExp(r"<\/?b>|<\/?i>"), ""),
            overflow: descripton_exposure,
            maxLines: widget.expandedDesc ? 100 : number_of_line,
            textAlign: TextAlign.center,
          ),
        ),
        !widget.expandedDesc
            ? Center(
                // ignore: prefer_const_constructors
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  // ignore: prefer_const_constructors
                  child: SizedBox(
                    height: 22.0,
                    width: 55.0,
                    child: IconButton(
                      // ignore: prefer_const_constructors
                      icon: Icon(
                        botton_description,
                        size: 25,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        updateDescription();
                      },
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
