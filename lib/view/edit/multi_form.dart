import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_student/view/edit/form_model.dart';
import 'package:global_student/view/edit/form_widget.dart';

class MultiContactFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MultiContactFormWidgetState();
  }
}

class _MultiContactFormWidgetState extends State<MultiContactFormWidget> {
  List<ContactFormItemWidget> contactForms = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Multi Contacts"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            onSave();
          },
          child: Text("Save"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          onAdd();
        },
      ),
      body: contactForms.isNotEmpty
          ? ListView.builder(
              itemCount: contactForms.length,
              itemBuilder: (_, index) {
                return contactForms[index];
              })
          : Center(child: Text("Tap on + to Add Contact")),
    );
  }

  //Validate all forms and submit
  onSave() {
    bool allValid = true;

    //If any form validation function returns false means all forms are not valid
    // contactForms
    //     .forEach((element) => allValid = (allValid && element.isValidated()));

    if (allValid) {
      for (int i = 0; i < contactForms.length; i++) {
        ContactFormItemWidget item = contactForms[i];
        debugPrint("Name: ${item.contactModel.name}");
        debugPrint("Number: ${item.contactModel.number}");
        debugPrint("Email: ${item.contactModel.email}");
      }
      //Submit Form Here
    }
    // else {
    //   debugPrint("Form is Not Valid");
    // }
  }

  //Delete specific form
  onRemove(ContactModel contact) {
    setState(() {
      int index = contactForms
          .indexWhere((element) => element.contactModel.id == contact.id);

      if (contactForms != null) contactForms.removeAt(index);
    });
  }

  //Add New Form
  onAdd() {
    setState(() {
      ContactModel _contactModel = ContactModel(id: contactForms.length);
      contactForms.add(ContactFormItemWidget(
        index: contactForms.length,
        contactModel: _contactModel,
        onRemove: () => onRemove(_contactModel),
      ));
    });
  }
}
