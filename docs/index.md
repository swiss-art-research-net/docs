# About

This website record and collect the documentation produced within the **S**wiss **A**rt **R**esearch **I**nfrastructure project- **SARI**. The project uses a semantic web infrastructure to record and expose reference resources useful for Digital Art History & Digital Humanities projects. 

Achieving these objectives meant overcoming common challenges and also creating several documentation resources which are collected into these main categories:

1. Ontological Modelling Patterns
2. Reference Data Models
3. Ontology Extensions

#### Ontological Modelling Patterns

The modelling patterns are nothing else than a series of generalisable formulas for the modelling of entities used within SARI and their properties. The patterns provided here do always come from a real use-case scenario and are made explicit both using a Turtle (.ttl) file and a graphical output.

#### Reference Data Models

With the term Reference Data Models we denote a re-usable template of common descriptors grounded on the analysis of select sources determined to be of relevance to the entity being modelled.  

Each available template is a collection of descriptors for a specific entity, and each descriptor is mapped to the CIDOC-CRM ontology. The aim is manifold: to provide reference implementations to be used by institutions and projects not familiar with CIDOC-CRM, to create usable guidelines to generate input interfaces for born-CRM semantic data and to guide mapping processes from extant sources into the CRM conformant reference model using tools such as 3M. 

The Semantic Reference Data Models are produced by the [Swiss Art Research Infrastructure (SARI)](https://swissartresearch.net) in collaboration with [George Bruseker](https://twitter.com/GBruseker) and [Nicola Carboni](https://twitter.com/wlpbloyd) and describe the following entities: 

+ [Persons](et/persons.md)
+ [Artworks](et/artwork.md)
+ [Group](et/group.md)
+ [Built Work](et/built_work.md)
+ [Place](et/place.md)
+ [Digital Document](et/do.md)
+ [Events](et/event.md)
+ [Bibliographic Entity](et/bibliographic_item.md)

Each of the Models listed above present an initial introduction of the sources and the methodology used for grounding the model. Following this introduction, each descriptor is defined, and its modelling in provided in textual, graphical form and RDF turtle representation.
Graphical representations use [CRITERIA](https://github.com/chin-rcip/CRITERIA), an open source python app (MIT license) developed by the (c) 2020 Canadian Heritage Information Network, Canadian Heritage, Government of Canada - Réseau Canadien d'information sur le patrimoine, Patrimoine canadien, Gouvernement du Canada.

#### Ontology Extension

Within the project some (very few really) properties and classes have been created as an extension of CIDOC-CRM or other ontologies. In this section we list them, pointing to the reader to their usefulness and where they can be found.