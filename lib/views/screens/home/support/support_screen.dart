import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import 'package:gacela_locataire/config/theme/theme.dart';
import 'package:gacela_locataire/models/errors/failure.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import 'package:gacela_locataire/providers/course_provider.dart';
import 'package:gacela_locataire/views/widgets/gacela_widgets.dart';
import 'package:provider/provider.dart';

class SupportScreen extends StatefulWidget {
  static const route = "/course/support";
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String? dropdownValue;
  List<String> supportTypes = [
    "Batterie",
    "Demarreur",
    "Amortisseurs",
    "Vitesses",
    "Moteur",
    "Bruits",
    "Freinage",
    "Climatisation",
    "Autres",
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _message;

  Future<void> sendDemande() async {
    if (_formKey.currentState!.validate()) {
      if (dropdownValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Il faut spécifier le type de support",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: GacelaColors.gacelaRed,
        ));
      } else {
        _formKey.currentState!.save();
        setState(() {
          _isLoading = true;
        });
        try {
          final Map<String, dynamic> result =
              await Provider.of<CourseProvider>(context, listen: false)
                  .sendDemandeSupport(
                      Provider.of<AuthProvider>(context, listen: false).token,
                      dropdownValue,
                      _message);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              result["message"],
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: GacelaColors.gacelaGreen,
          ));
          Navigator.pop(context);
        } on Failure catch (f) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              f.message,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: GacelaColors.gacelaRed,
          ));
        } catch (e) {
          print(e);
        }
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("My reservation" +
        Provider.of<CourseProvider>(context, listen: false)
            .reservationId
            .toString());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
          child: Column(
            children: [
              const SizedBox(height: GacelaTheme.vDivider),
              const Icon(
                Icons.support_agent,
                size: 40,
              ),
              const SizedBox(height: GacelaTheme.vDivider),
              Text("Support client",
                  style: Theme.of(context).textTheme.headline2),
              const SizedBox(height: GacelaTheme.vDivider),
              Text(
                "Il faut décrire votre probleme en détails pour que les agents de gacela peut vous aidez",
                style: TextStyle(color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2 * GacelaTheme.vDivider),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        value: dropdownValue,
                        hint: const Text("Type de support"),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 20,
                        ),
                        elevation: 2,
                        style: const TextStyle(
                            color: GacelaColors.gacelaBlue, fontSize: 18),
                        underline: Container(
                          height: 2,
                          color: GacelaColors.gacelaBlue,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: supportTypes
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: GacelaTheme.vDivider),
                      TextFormField(
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: GacelaColors.gacelaGrey,
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? "Le message est obligatoire"
                            : null,
                        onSaved: (value) => _message = value,
                      ),
                      // gacelaTextFormField(
                      //   hintText: "Message",
                      //   maxLines: 5,
                      //   validator: (value) => value!.isEmpty
                      //       ? "Le message est obligatoire"
                      //       : null,
                      //   onSaved: (value) => _message = value,
                      // ),
                      const SizedBox(height: 2 * GacelaTheme.vDivider),
                      _isLoading
                          ? const CircularProgressIndicator(
                              color: GacelaColors.gacelaBlue)
                          : gacelaButton(
                              onPressed: sendDemande, text: "Envoyer")
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
