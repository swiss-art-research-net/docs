# Photo Reference Data Model


The photo reference data model provides a list of standard fields that are often used to describe a photo. However, with respect to other entities, the description of a photo is quite the complex operation, which requires tracking in great details two major entities:

* [An Image](img.md)
* [A Physical Information Carrier](carrier.md)


In order to express the semantic interconnections between the two entities, as well as their diversity in nature and scope, we decide to provide to the user two different models, that combined can track the generation of an image as intellectual content reproduced across multiple manifestations as well as the historical traces and connections of their physical support.
These two models are accompanied by a third, the [Digital Object Reference Model](do.md), which can be used to document the digitisation process of a photograph and track its provenance.