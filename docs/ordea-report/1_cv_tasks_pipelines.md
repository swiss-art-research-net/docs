Computer vision (CV) plays a pivotal role in the digital transformation of the GLAM sector, as the acquisition of any document, whether visual or textual, necessarily involves an intermediate image format. As a result, CV technologies are of key importance for both visual and textual cultural heritage materials. Applications of CV to GLAM materials showed a great potential of revolutionising archival practices, especially by supporting humans in generating and/or enriching descriptive metadata of cultural heritage documents [@europeana_ai_2023].

This introductory section aims at presenting a high-level categorisation of CV tasks[^1], and to show how CV tasks and models are often combined into subsequent steps to form complex data processing pipelines which, in turn, power innovative user-facing applications [REFINE]. 

### 1.1 Tasks
A first dimension along which CV tasks/models/applications can be organised and classified is the type and modality of their input, as well as the modality (i.e. text or image) of the output they generate. In terms of input, we can distinguish between tasks/models that operate on 1) a single entire input image, 2) individual portions of a single image, or 3) pairs of images. 

1) *Tasks operating on a single entire image*. Here a further distinction can be made based on the modality of input/output. 
	1) Tasks where an *input image* produces a *textual output* are:
			- **image classification**: each input image is assigned a textual label/class, based on a pre-defined set of labels/classes.
			- **image captioning**: for each input image, a short textual description is produced that briefly summarises it content. 
			- **automatic text recognition**: given as input a text-containing image (e.g. digitised image of a book page, of an archival document, etc.), an automatic transcription of the text contained in the image is generated. 
	2) Tasks where an *input text* produces a *visual output*:
			- **image generation**: typically what generative AI models for images do. 
			- **image search by textual query**
			- text prompting for foundational models
3) *Tasks operating on pairs of images*. The main task in this category is **image similarity**, which consists in computing a numerical score that captures the visual similarity between two images (however "similarity" may be defined). 
4) *Tasks operating on portions of a single image*, such as detection and segmentation. These two tasks are very similar; what changes is mostly the precision with which object or stuff are identified (bounding box precision vs pixel-level precision). While in the early CV days the two tasks were performed separately and sequentially, state-of-the-art models are able nowadays to perform end-to-end segmentation without intermediate detection [Refer to Models section below].
	- **Detection**: given an input image, the task consists in predicting the bounding boxes of *things* or *stuff* it contains (bounding boxes are expressed as image coordinates). The task is then further differentiated depending on what is being detected:
		- *object detection*
		- *stuff detection*
	- **Segmentation**
		- *semantic segmentation*
		- *instance segmentation*
		- *panopticon segmentation*

![Image from HuggingFace Community Computer Vision course](https://huggingface.co/datasets/hf-vision/course-assets/resolve/main/segmentation-types.png)

### 1.2 Existing CV formats

| Name       | Serialization format | Dataset examples                                                                            | Tasks                                                         |
| ---------- | -------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| COCO       | JSON                 | MS COCO (# of images), SA1-B (# of images)                                                  | image classification, object detection, instance segmentation |
| Pascal VOC | XML                  | [Pascal VOC 2012 dataset](http://host.robots.ox.ac.uk/pascal/VOC/voc2012/index.html#devkit) |                                                               |
| YOLO       | plain text           |                                                                                             | object detection                                              |
| LabelMe    | JSON                 |                                                                                             |                                                               |

- What are the main affordances/differences of these formats?
- What are the common things/patterns that these formats allow to represent? for example, polygons or bounding boxes.

### 1.3 Pipelines and applications

(What are the type of tasks that are more relevant for GLAM materials and applications? List, explain, and give examples from the literature. Goal of this section: to showcase how CV has been deployed in pipelines to enable user-facing applications). 

**GallicaPix** [^2] [@moreux_dealing_2021] is an ongoing project of the BnF (French National library). It provides access to ≈ 330k images extracted from BnF's digitised sources, organised into five thematic collections. Image classification was employed to automatically enrich image metadata and enable more fine-grained means of searching and filtering (give examples for technique, fonction, genre). Moreover, four different services/models for automatic objected detection (TODO: list models) were used in order to give users the ability to search for images by semantic concepts (e.g., image of a ship, image of a soldier). 

**Newspaper Navigator**[^7], a project developed at the Library of Congress (LOC) [@lee_newspaper_2020], which aimed at developing a scalable pipeline to process the LOC's digitised newspaper holdings (16M of newspaper pages). Classification of visual contents according to a predefined taxonomy. (Specify what type of models they have used for image classification). 

**ArchiMediaL**[^3]: Enriching and linking historical architectural and urban image collections [@mager_computer_2023]. Automatic recognition and identification of buildings in collections of historic photographs. Case study focussed on Amsterdam. 400k architectural images from the Beldbank archives. Creation through crowdsourcing of an annotated dataset for this task, consisting of ~1k image pairs (crowdsourcing of annotations + manual curation). The annotations platform follows a gamification approach in order to keep contributors/annotators engaged. The dataset is used to train a CNN Siamese network to capture similarity between images, with some resiliency to e.g. age of the pictures (the learned representations are domain-invariant). Historical images are compared with a database of current images of building in order to find a matching and thus derive the geolocation (address) of the building depicted in the image.   

**ArtVision**[^4]: visual similarity with human-in-the-loop [@klic_linked_2023]. ArtVision deploys similarity search on top of the vast image collection of Pharos, the International Consortium of Photo Archives [@delmas-glass_fostering_2020]. When aggregating large amount of data from multiple providers, the chances of having duplicates in the aggregated collection increase, thus requiring ways of performing near duplicate detection, which is one of the applications of image similarity models/tools. The ArtVision platform allows Pharos curators to review and validate the results of automatic duplicate detection (performed using Pastec [REF]). The results returned by the CV models are modelled semantically using a combination of CIDOC-CRM and the Similarity Ontology[^8] and then ingested into a ResearchSpace instance, which supports the curation by domain experts. 

**Bilder der Schweiz Online (BSO)**[^5] is a joint project between University of Zurich and SARI which aims at supporting research on the historical image of Switzerland by using a collection of images of Switzerland, namely topographical art and photography from the 18th to the early 20th century. The BSO portal [link] offers a multi-faceted semantic access to this image collection. Among its key features, the portal allows users to search images by places they depict; this is achieved by identifying landscape images with an automatic classifier, trained ad-hoc, and then geo-referencing them by using sMapshot[^6]. Another interesting functionality of this portal is the support for image search by plain text input, a functionality that exploits the capabilities of the multi-modal model CLIP. 

As a sort of conclusion, highlight the importance of automatic classification, as an intermediate step of more complex pipelines. Human-in-the-loop for correction provides a good model for making use of these automatic annotations to enrich metadata of existing collections.

[^1]: Refer to tasks definition in [https://paperswithcode.com/area/computer-vision](https://paperswithcode.com/area/computer-vision). 
[^2]: [https://gallica.bnf.fr/blog/21062021/gallicapix-un-nouvel-outil-dexploration-iconographique](https://gallica.bnf.fr/blog/21062021/gallicapix-un-nouvel-outil-dexploration-iconographique)
[^3]: [http://archimedial.eu/](http://archimedial.eu/)
[^4]: [https://vision.artresearch.net/resource/start](https://vision.artresearch.net/resource/start)
[^5]: [https://bso.swissartresearch.net/](https://bso.swissartresearch.net/)