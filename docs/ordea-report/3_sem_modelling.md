### 3.1 Definition & Focus

In an analog context, *provenance* is the record of ownership, custody or location of an object (e.g., a work of art, an archaeological object, etc.). Similarly, with respect to digital objects, *digital provenance* captures the creation, modification and derivation of digital assets. Digital provenance plays a documentation role as it enables users/consumers of digital objects (e.g. data) to understand the chronology of modifications and usages that a given object underwent during and after its creation. Provenance documentation can be produced for any kind of digital objects: texts, images, videos and audio recordings, as well as for  annotations made on any of these objects. The term *annotation* is used to refer to statements about digital objects created by human agents, as well as by machine agents (e.g. algorithms, processing pipelines, etc.). 

This report focusses on digital provenance as a way of unpacking and documenting the chain of processing steps that constitute data processing pipelines, thus including CV pipelines. As the annotations produced as output by a pipeline step become the input of successive step, documenting the provenance of the final annotations (e.g. enrichment) produced by a pipeline entails documenting the intermediate processing steps.

### 3.2 The process of annotating

The goal of this brief section is to provide a precise natural language description of the entities that are at play in the process of annotating digital objects (both texts and images), in the view of defining a semantic model. Key terms/concepts – which should then be modelled semantically – are highlighted in *italic*. 

- **Data, dataset, corpus.** The set of *digital objects* that we run through a CV tool or model for processing (e.g., transformation, enrichment, etc.). These digital objects may be textual documents, visual items (images), or even metadata. They may be organised in the form of a *dataset* (or corpus), described by its own set of metadata. 
- **Annotation.** Annotation is the process of enriching an existing *digital object* with additional information.
	- The *author* of an annotation can be 1) a human – such is the case with ground-truth annotations used to train a model, or with crowd-sourced annotations or 2) a "machine" (proxy term for the tool or model used to produce the annotation) – in this case we use *annotation* to refer to a digital representation that expresses the *prediction* made by the model.
	- The *target* of the annotation (i.e. what the annotation applies to) may be a) the entire object (e.g. for image/text classification), b) a specified portion of an object (e.g. object detection or named entity recognition), or c) pairs of objects[^14] (e.g. image or text similarity).  
	- In the context of machine-generated annotations, each prediction may have a *confidence score* attached,  which represents the model's confidence in making that prediction (usually a value between `0` and `1`). Confidence score – when reliable – are useful to   
- **Models, tools, libraries.** We talk about *models* in the sense of machine learning models (e.g., a YOLO v. 5 object detection model). Programming libraries in various languages are employed to *implement* ML models (e.g. TensorFlow) or to make them more easily shareable, accessible and usable (e.g. the Python HuggingFace library, with its hub where models are shared). A *tool* may use several software *libraries* and may rely on multiple *models* to do what it does. 
- **Pipeline.**  It is a way of defining a processing chain made of several sequential *steps*, and where the *output* of a step becomes the *input* of the following step. The pipeline as a whole has an overall  input and an overall output. Typically, each pipeline step corresponds to calling one tool or model on some input data, and using the output as an input to the following tool or model.  

### 3.3 Previous approaches to digital provenance

#### W3C Provenance ontology (Prov-O)
Prov-O[^10] is a simple and domain-agnostic ontology to represent provenance, developed by the W3C Provenance Incubator Group. It  models provenance as the interplay of three core classes: entities (`prov:Entity`), agents (`prov:Agent`) and activities (`prov:Activity`). *Entities* are the *things* of which we want to describe provenance; *activities* are the events that lead to the creation, modification, use of these *entities*; and *agents* are entities that participate to the *activities* events and are responsible for actions affecting entities. The high level of genericity of this ontology has led to numerous extensions of this ontology be developed to fit a wide variety of domains and use cases.[^9] 

#### Prov-O and the Open Citations Data Model (OCDM)
An interesting application of Prov-O is the one it found in the context of the Open Citations Data Model (OCDM) [REF], which specifies the semantic representation of Open Citations data. Prov-O is used in OCDM to track how a given resource (`prov:Entity`) changes between any two specific points in time (called *snapshots*). OCDM extends Prov-O by providing the ability to specify exactly how an entity has changed; this is obtained by introducing a property called `hasUpdateQuery` which contains the operations (insertions and deletions) that occurred to a given entity between two snapshots. This solution allows the maintainers of OC datasets to revert to the "state of affairs" of any resource at the time of a given snapshot.  

#### Provenance and the Web Annotation Data Model (WADM)
[@cornut_annotations_2023] provide an example of how to model the provenance of both human- and machine-generated annotations on images by using a combination of the Web Annotation Data Model (WADM)[^11] and the Image Interoperability Framework (IIIF) standard. Their approach to machine-generated annotations is particularly of interest for the present report. In their paper they describe how the predictions of an object detection model (`vitrivr`) can be represented by using WADM's classes and properties. In Listing 1 at p. 16 they provide an example encoding of a model prediction that detected an object of type "person" within an image. The annotation's target (`wadm:target`) corresponds to the part of the image concerned by the annotation and point's to the image manifest as well as to the box coordinates via the `source` and `selector` properties respectively. This annotation has three bodies (`wadm:body`) attached to it: one with `purpose=tagging` to identify the annotation's author (i.e. the `vitrivr` software in this cases), one with `purpose=commenting` to encode the model's detection score (represented as a string), and one with `purpose=commenting` to represent the tag `person` assigned by the model to the image portion. 

#### CRMdig extension
CRMdig is an extension of the CIDOC-CRM ontology aimed at providing a generic framework for representing provenance, as well as a specialisation for representing the provenance of digital objects across a wide variety of domains. At a high-level, CRMdig displays substantial similarities with Prov-O as they are both event-based ontologies; the naming differs slightly as Prov-O talks about entities, agents (with roles) and activities, while CRMdig describes provenances in terms of entities, actors (with roles) and events. Classes/properties of CRMdig that are relevant for describing machine-generated annotations are: `D1 Digital Object`, `D10 Software execution` (event), `D9 Data Object`, `D14 Software`, `D35 Area`.

#### Other approaches
It is worth mentioning other approaches we are aware of concerning the modelling of predictions made by CV models:
- *Modelling of image similarity*. In [@klic_linked_2023] the similarity between pairs of images is modelled by using the Similarity Ontology[^13]: the tool used to measure the similarity becomes the employed method (`sim:AssociationMethod`), whose `sim:weight` is the numerical value that expresses the similarity between two images. This pattern allows for expressing the fact that the similarity of an image pair can be measure by different tools thus leading to different similarity scores.  
- *Modelling of colour-scheme extraction*. In the BSO knowledge graph, the extraction of colour-scheme from images is modelled as follows: the Python code (Jupyter notebook) that contains the programming logic for computing the colour-scheme of an image is modelled as a *specific technique* (`crm:E29 Design or Procedure`) used by an attribute assignment activity (`crm:E13 Attribute Assignment`), whose time-span corresponds to the execution time/date of the Jupyter notebook. 
- *Modelling of geo-referencing of images*. In the BSO knowledge graph, images (of paintings) are enriched with geo-referencing information created by using the Smapshot tool. The process of geo-referencing is modelled as an instance of  `crmsci:S7 Simulation or Prediction` from the Scientific Observation Model (CRMsci)[^12], which in turn is a specialisation of `crm:E13 Attribute Assignment`. Geo-referencing an image is represented as the observation (performed by using a tool) of a given site, which occupies a geographical place represented in a given painting (`E36 Visual Item`).   

### 3.4 Towards a unified approach

#### 3.4.1 Discussion of previous approaches

The approach to model digital provenance adopted by OCDM seems more viable in cases where we want to track, at a fine-grained level, the evolution of resources/documents over time (creation, modification, merge), but it seems less viable as an approach in the case of (machine-)annotations, as they tend to be highly volatile (i.e. they are replaced by those produced by a new model's run).

Prov-O is highly generic, thus it needs to be specialised in order be useful. At the same time, it is very similar to CRMdig (as both are event-based), which may be an argument in favour of adopting CRMdig, which has the advantage of being already integrated into the CIDOC-CRM ecosystem. The semantic encoding of machine-generated annotations put forward by the BSO project at SARI demonstrates the feasibility of employing classes and properties from CIDOC-CRM to this end. However, this approach will need to be generalised so that it can be applied to a broader variety of use cases, including e.g. representing the results of computing similarity between pairs of images [@klic_linked_2023]. 

When working with visual contents the WADM approach has the big advantage that it integrates seamlessly with IIIF as a way to express the target of annotations (be it the entire image or just a portion). This may be in itself a reason for choosing this approach especially in cases where it is planned to render in a user-facing applications the annotations on images generated by a tool or model. At the same time, this approach seems to sacrifice the precision of semantic descriptions. A good example of this loss of semantic precision is the fact the model's confidence score is represented as a string in the example above; it's a rendering-oriented solution that may work less well when e.g. we want to filter annotations by confidence score.

#### 3.4.2 Ontological foundations and methodology

TBD, cfr. CORDh presentation. CRMDig, aaao, SRDM. 

Entities and properties are elicited by considering a number of real-world use cases (see below) and, successively, they are mapped on ontological patterns. These modelling patterns are made available in the documentation tool Zellij, developed by Takin solutions. 

#### 3.4.3 Modelling use cases

As use cases for the modelling of digital provenance, we consider a broad set of data processing pipelines. While some of them are quite generic and can be applied to several media types (classification and similarity), others are more specific to the domain of computer vision. These use cases do not aim at exhaustive coverage of all possible cases, but they rather aim to cover a broad variety of situations that one is faced with when documenting the provenance of machine-generated annotations.  

##### Image classification

*Classification* is the task of assigning a textual label (representing a class) to an input digital object (e.g., text, image, etc.), based on a pre-defined taxonomy. Class labels can be purely textual (strings) or concepts from other existing graphs (SKOS taxonomy, Wikidata, etc.). 

As an example of image classification, we considered the pipeline developed by SARI for the BSO project [^15]. This pipeline aims at classifying images as being landscape paintings or not; thus the model can assign either the label `landscape` or the one `not landscape`. The pipeline is implemented as a set of Jupyter notebooks and consists of four steps:

1. image annotation;
2. model training based on annotated images;
3. image classification;
4. serialization of the output as an RDF graph. 

##### Image similarity detection

*Image similarity detection* is the task of computing a numerical score that captures the visual similarity between two images. The spectrum of similarity is wide-ranging, encompassing anything from the visual relatedness of an image pair to the fact that one image is a duplicate (or copy) of another.

As an example of image similarity detection, we considered the similarity search API developed by SARI for the gta [REF] project, available at the address [https://researchportal-staging.gta.arch.ethz.ch/sparql](https://researchportal-staging.gta.arch.ethz.ch/sparql). This API accepts queries in the format of SPARQL queries and returns a list of images that are similar to the input one; for each pair of similar images, a similarity score (expressed as a percentage) captures the degree of similarity between the two images. Here is an example of query to retrieve gta images that are similar to [`cms-182741`](https://iiif.gta.arch.ethz.ch/iiif/2/cms-182741/full/300,/0/default.jpg):

```sparql
PREFIX clip: <https://service.swissartresearch.net/clip/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
SELECT ?subject ((ROUND(?scoreFull * 1000 )) / 10  AS ?score) WHERE {
  SERVICE <http://clip-service:5000/sparql> {
    ?request rdf:type clip:Request;
      clip:queryURL <https://iiif.gta.arch.ethz.ch/iiif/2/cms-182741/full/300,/0/default.jpg>;
      clip:minScore 0.2;
      clip:score ?scoreFull;
      clip:iiifUrl ?subject.
  }
}
LIMIT 2

```

Behind the scenes, the API uses a CLIP (Contrastive Language-Image Pretraining) model[^16] to compute the similarity between images. 

##### Image segmentation

*Image segmentation* is the task of segmenting an input image into areas of interest (typically polygons), and it is typically used to locate objects and object boundaries within images. Object detection and also layout recognition are all forms of image segmentation. 

As an example of image segmentation, we consider ...

##### Geo-referencing of images

##### Color scheme extraction

#### 3.4.4 Modelling recipes

##### Modelling of a digital reading pipeline

What is common to all five use cases outlined above: each processing pipeline is a **digital workflow** which can be represented as  a sequence of steps, having dependencies between one another, where each step typically has an input, produces an output, and is performed by means of some purpose-fit software (code/tool/API). 

![](./imgs/general_annotation_workflow.png)
/// caption
Modelling of a digital reading pipeline step 
///
<!-- Image source: https://app.diagrams.net/#G15cGd82BeaOiToVGrIG5AcnHjNMaLEgBT#%7B%22pageId%22%3A%22XA0bDlMVGcgs2SM-xyzw%22%7D -->

While the modelling of digital reading pipelines tends to be quite generic (i.e., all pipeline steps tend to have a substantial number of common properties), the modelling of the semantics of the predictions (i.e., propositional statemennts) made by a given pipeline depends on the specific task at hand. 

##### Modelling of image classification

##### Modelling of image similarity detection

![](./imgs/gta-similarity.png)
/// caption
Modelling of image similarity detection 
///
<!-- Image source: https://app.diagrams.net/#G15cGd82BeaOiToVGrIG5AcnHjNMaLEgBT#%7B%22pageId%22%3A%22g5mR7cSpMyBNkxGoOB5w%22%7D -->

##### Modelling of image segmentation

[^8]: [https://lov.linkeddata.es/dataset/lov/vocabs/sim](https://lov.linkeddata.es/dataset/lov/vocabs/sim)
[^9]: [https://blogs.ncl.ac.uk/paolomissier/2021/02/07/w3c-prov-some-interesting-extensions-to-the-core-standard/#aml](https://blogs.ncl.ac.uk/paolomissier/2021/02/07/w3c-prov-some-interesting-extensions-to-the-core-standard/#aml)
[^10]: [https://www.w3.org/TR/prov-o/](https://www.w3.org/TR/prov-o/)
[^11]: [https://w3c.github.io/web-annotation/model/wd2/](https://w3c.github.io/web-annotation/model/wd2/)
[^12]: [https://cidoc-crm.org/crmsci/](https://cidoc-crm.org/crmsci/)
[^13]: [https://lov.linkeddata.es/dataset/lov/vocabs/sim](https://lov.linkeddata.es/dataset/lov/vocabs/sim)
[^14]: In CIDOC-CRM parlance, a *pair of object* can be seen as a subclass of `E78_Collection` with a maximum cardinality of 2.  
[^15]: [https://github.com/swiss-art-research-net/bso-image-classification](https://github.com/swiss-art-research-net/bso-image-classification)
[^16]: [https://github.com/openai/CLIP](https://github.com/openai/CLIP)