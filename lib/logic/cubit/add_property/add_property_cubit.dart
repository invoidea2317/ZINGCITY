import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/model/agency/agency_details_model.dart';
import 'package:real_estate/presentation/utils/utils.dart';

import '../../../data/model/auth/auth_error_model.dart';
import '../../../data/model/create_property/additional_info_dto.dart';
import '../../../data/model/create_property/edit_info/edit_info_model.dart';
import '../../../data/model/create_property/edit_info/existing_slider.dart';
import '../../../data/model/create_property/nearest_location_dto.dart';
import '../../../data/model/create_property/property_location.dart';
import '../../../data/model/create_property/property_plan_dto.dart';
import '../../../data/model/create_property/property_video_dto.dart';
import '../../../data/model/home/home_data_model.dart';
import '../../../data/model/product/nearest_location_model.dart';
import '../../../presentation/error/failure.dart';
import '../../../presentation/screens/property_details/component/property_images_slider.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/property_repository.dart';
import 'add_property_state_model.dart';

part 'add_property_state.dart';

class AddPropertyCubit extends Cubit<AddPropertyModel> {
  final PropertyRepository _repository;
  final LoginBloc _loginBloc;

  AddPropertyCubit({
    required PropertyRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const AddPropertyModel());

  List<NearestLocationModel> locationModel = <NearestLocationModel>[];
  EditInfoModel? editedInfo;

  void changeType(String text) {
    emit(state.copyWith(purpose: text, addState: const AddPropertyInitial()));
  }

  void changeCity(String text, String id) {
    emit(state.copyWith(city: text, addState: const AddPropertyInitial(),cityId: id));
  }

  void changeAmenities(String text,bool isAdd) {

    if(isAdd){
      emit(state.copyWith(aminities: List.of(state.aminities)..add(text), addState: const AddPropertyInitial()));}
    else{
      emit(state.copyWith(aminities: List.of(state.aminities)..remove(text), addState: const AddPropertyInitial()));
    }
  }
  void addAminitiesValue(List<String>? text,bool isAdd) {

      emit(state.copyWith(aminities: text, addState: const AddPropertyInitial()));

  }

  void changeCountry(String text) {
    emit(state.copyWith(country: text, addState: const AddPropertyInitial()));
  }

void changeAddress(String text) {
    emit(state.copyWith(address: text, addState: const AddPropertyInitial()));
  }

  void changeState(String text, String id) {
    debugPrint("$text");
    emit(state.copyWith(state: text, addState: const AddPropertyInitial(),stateId: id));
  }

  void changeRentPeriod(String text) {
    emit(state.copyWith(
      rentPeriod: text,
      addState: const AddPropertyInitial(),
    ));
  }

  void changeSeoTitle(String text) {
    emit(state.copyWith(
      seoTitle: text,
      addState: const AddPropertyInitial(),
    ));
  }

  void changeSeoDescription(String text) {
    emit(state.copyWith(
      seoMetaDescription: text,
      addState: const AddPropertyInitial(),
    ));
  }

  void changeTypeId(String text,String categoryId) {
    // debugPrint('category-id $categoryId');
    // debugPrint('type-id $text');
    emit(state.copyWith(typeId: text, addState: const AddPropertyInitial(),categoryId: categoryId));
  }

  void changePossessionStatus(String possession) {
    // debugPrint('category-id $categoryId');
    // debugPrint('type-id $text');
    emit(state.copyWith(possessionStatus: possession, addState: const AddPropertyInitial()));
  }

  void changePropertyTypeId(String text,String categoryId) {
    // debugPrint('category-id $categoryId');
    // debugPrint('type-id $text');
    emit(state.copyWith(propertyType: text, addState: const AddPropertyInitial(),propertyTypeId: categoryId));
  }
  void changeRoomType(String text,String roomTypeId) {
    emit(state.copyWith(roomType: text, addState: const AddPropertyInitial(),roomTypeId: roomTypeId));
  }




  void changeNearestLocation(List<Map<String, dynamic>> data) {
    List<String> tempNearestLocation = [];
    List<String> tempDistance = [];

    data.forEach((element) {

      tempNearestLocation.add(element['id'].toString());
      tempDistance.add(element['value'].toString());
      // emit(state.copyWith(nearestLocationList: List.of(state.nearestLocationList)..add(NearestLocationDto(locationId: element['id'],distances: element['distance'])), addState: const AddPropertyInitial()));
    });

    emit(state.copyWith(nearestLocation: tempNearestLocation, addState: const AddPropertyInitial(),distance: tempDistance));
  }

  void changeTitle(String text) {
    emit(state.copyWith(
        title: text,
        slug: Utils.convertToSlug(text),
        addState: const AddPropertyInitial()));
  }

  void changeTotalPrice(String text) {
    emit(state.copyWith(price: text, addState: const AddPropertyInitial()));
  }

  void changeTotalArea(String text) {
    emit(state.copyWith(totalArea: text, addState: const AddPropertyInitial()));
  }

  void changeTotalUnit(String text) {
    emit(state.copyWith(totalUnit: text, addState: const AddPropertyInitial()));
  }

  void changeTotalBedroom(String text) {
    emit(state.copyWith(
        totalBedroom: text, addState: const AddPropertyInitial()));
  }

  void changeTotalBathroom(String text) {
    emit(state.copyWith(
        totalBathroom: text, addState: const AddPropertyInitial()));
  }
  void addAdditionalKey(List<String>? keys,) {
    emit(state.copyWith(
        additionalKeys: keys, addState: const AddPropertyInitial()));
  }

  void addAdditionalValue(List<String>? keys,) {
    emit(state.copyWith(
        additionalValues: keys, addState: const AddPropertyInitial()));
  }

  void changeTotalKitchen(String text) {
    emit(state.copyWith(
        totalKitchen: text, addState: const AddPropertyInitial()));
  }
  void changeTotalBalconies(String text) {
    emit(state.copyWith(
        totalBalcony: text, addState: const AddPropertyInitial()));
  }

  void changeTotalGarage(String text) {
    emit(state.copyWith(
        totalGarage: text, addState: const AddPropertyInitial()));
  }

  void changeDescription(String text) {
    emit(state.copyWith(
        description: text, addState: const AddPropertyInitial()));
  }

  void propertyImage(String image) {
    emit(state.copyWith(image: image, addState: const AddPropertyInitial()));
  }

  void addGalleryImage(ExistingSlider slider) {
    final updatedImg = List.of(state.galleryImage)..add(slider);
    emit(state.copyWith(
        galleryImage: updatedImg, addState: const AddPropertyInitial()));
  }

  void addSliders(List<File> images) {
    // final updatedImg = List.of(state.galleryImage)..add(slider);
    log('slider-images ${images.length}');
    emit(state.copyWith(
        sliderImages: images, addState: const AddPropertyInitial()));
  }
  void addThumbNails(String images) {
    // final updatedImg = List.of(state.galleryImage)..add(slider);
    emit(state.copyWith(
        thumbNailImage: images, addState: const AddPropertyInitial()));
  }

  void updateGalleryImage(int index, ExistingSlider slider) {
    final updatedGalleryImages = List.of(state.galleryImage);
    if (index >= 0 && index < updatedGalleryImages.length) {
      updatedGalleryImages[index] = slider;
      emit(state.copyWith(
          galleryImage: updatedGalleryImages,
          addState: const AddPropertyInitial()));
    }
  }

  void deleteGalleryImage(int index) {
    final updatedGalleryImages = List.of(state.galleryImage)..removeAt(index);
    emit(state.copyWith(
        galleryImage: updatedGalleryImages,
        addState: const AddPropertyInitial()));
  }

  void addAminities(String id) {
    final updatedIds = List.of(state.aminities);
    if (updatedIds.contains(id)) {
      updatedIds.remove(id);
    } else {
      updatedIds.add(id);
    }
    emit(state.copyWith(
        aminities: updatedIds, addState: const AddPropertyInitial()));
  }

  void addVideoSection(PropertyVideoDto video) {
    emit(state.copyWith(
        propertyVideoDto: video, addState: const AddPropertyInitial()));
  }

  void addPropertyLocation(PropertyLocationDto video) {
    emit(state.copyWith(
        propertyLocationDto: video, addState: const AddPropertyInitial()));
  }

  ///nearest location start
  void addNearestLocation(NearestLocationDto location) {
    final updatedLocations = List.of(state.nearestLocationList)
      ..add(location.copyWith(distances: ''));
    emit(state.copyWith(
        nearestLocationList: updatedLocations,
        addState: const AddPropertyInitial()));
  }

  void updateNearestLocation(int index, NearestLocationDto location) {
    final updatedLocations = List.of(state.nearestLocationList);
    if (index >= 0 && index < updatedLocations.length) {
      updatedLocations[index] = location;
      emit(state.copyWith(
          nearestLocationList: updatedLocations,
          addState: const AddPropertyInitial()));
    }
  }

  void deleteNearestLocation(int index) {
    final locations = List.of(state.nearestLocationList)..removeAt(index);
    emit(state.copyWith(
        nearestLocationList: locations, addState: const AddPropertyInitial()));
  }

  ///nearest location end

  ///addition info start
  void addAdditionalInfo(AdditionalInfoDto location) {
    final updatedLocations = List.of(state.addtionalInfoList)
      ..add(location.copyWith(addKeys: '', addValues: ''));
    emit(state.copyWith(
        addtionalInfoList: updatedLocations,
        addState: const AddPropertyInitial()));
  }

  void updateAdditionalInfo(int index, AdditionalInfoDto location) {
    final updatedLocations = List.of(state.addtionalInfoList);
    if (index >= 0 && index < updatedLocations.length) {
      updatedLocations[index] = location;
      emit(state.copyWith(
          addtionalInfoList: updatedLocations,
          addState: const AddPropertyInitial()));
    }
  }

  void deleteAdditionalInfo(int index) {
    final locations = List.of(state.addtionalInfoList)..removeAt(index);
    emit(state.copyWith(
        addtionalInfoList: locations, addState: const AddPropertyInitial()));
  }

  ///addition info end

  ///property plan start
  void addPropertyPlan(PropertyPlanDto location) {
    final updatedLocations = List.of(state.propertyPlanDto)
      ..add(location.copyWith(
          planImages: '', planTitles: '', planDescriptions: ''));
    emit(state.copyWith(
        propertyPlanDto: updatedLocations,
        addState: const AddPropertyInitial()));
  }

  void updatePropertyPlan(int index, PropertyPlanDto location) {
    final updatedLocations = List.of(state.propertyPlanDto);
    if (index >= 0 && index < updatedLocations.length) {
      updatedLocations[index] = location;
      emit(state.copyWith(
          propertyPlanDto: updatedLocations,
          addState: const AddPropertyInitial()));
    }
  }

  Future<void> deletePropertyPlan(String index) async {
    emit(state.copyWith(addState: const AddPropertyLoading()));
    final result = await _repository.createProperty(
        state);
    result.fold(
          (failure) {
        if (failure is InvalidAuthData) {
          final errorState = AddPropertyFormError(failure.errors);
          emit(state.copyWith(addState: errorState));
        } else {
          final errors = AddPropertyError(failure.message, failure.statusCode);
          emit(state.copyWith(addState: errors));
        }
      },
          (success) {
        emit(state.copyWith(addState: AddPropertyLoaded(success)));
      },
    );
  }

  ///property plan end

  Future<void> addProperty() async {
    // debugPrint('add-property-body ${state.toMap()}');
    emit(state.copyWith(addState: const AddPropertyLoading()));
    final result = await _repository.createProperty(
        state);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errorState = AddPropertyFormError(failure.errors);
          emit(state.copyWith(addState: errorState));
        } else {
          final errors = AddPropertyError(failure.message, failure.statusCode);
          emit(state.copyWith(addState: errors));
        }
      },
      (success) {
        emit(state.copyWith(addState: AddPropertyLoaded(success)));
      },
    );
  }
  Future<dynamic> getData() async {
    debugPrint('add-property-body ${state.toMap()}');
    emit(state.copyWith(addState: const AddPropertyLoading()));
    final result = await _repository.getPropertyData();
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errorState = AddPropertyFormError(failure.errors);
          emit(state.copyWith(addState: errorState));
          return false;
        } else {
          final errors = AddPropertyError(failure.message, failure.statusCode);
          emit(state.copyWith(addState: errors));
          return false;
        }
      },
      (success) {
        debugPrint("Success");
        emit(state.copyWith(staticInfo: success,addState: const AddPropertyInitial()));
        return true;
      },
    );
  }

  Future<void> updateProperty(String id) async {
    debugPrint('add-property-body ${state.toMap()}');
    debugPrint('add-thumbnail ${state.image}');
    emit(state.copyWith(addState: const AddPropertyLoading()));
    final result = await _repository.updateProperty(
        id, state);
    result.fold(
          (failure) {
        if (failure is InvalidAuthData) {
          final errorState = AddPropertyFormError(failure.errors);
          emit(state.copyWith(addState: errorState));
        } else {
          final errors = AddPropertyError(failure.message, failure.statusCode);
          emit(state.copyWith(addState: errors));
        }
      },
          (success) {
        emit(state.copyWith(addState: AddPropertyLoaded(success)));
      },
    );
  }

  Future<void> getEditedProperty(String id) async {
    emit(state.copyWith(addState: const AddPropertyEditing()));
    final result = await _repository.getPropertyEditInfo(
        id, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        final errors =
            AddPropertyEditingError(failure.message, failure.statusCode);
        emit(state.copyWith(addState: errors));
      },
      (data) {
        if (state.propertyPlanDto.isNotEmpty) {
          emit(state.copyWith(propertyPlanDto: <PropertyPlanDto>[]));
        }
        if (state.addtionalInfoList.isNotEmpty) {
          emit(state.copyWith(addtionalInfoList: <AdditionalInfoDto>[]));
        }
        if (state.nearestLocationList.isNotEmpty) {
          emit(state.copyWith(nearestLocationList: <NearestLocationDto>[]));
        }
        if (state.galleryImage.isNotEmpty) {
          emit(state.copyWith(galleryImage: <ExistingSlider>[]));
        }
        if (state.aminities.isNotEmpty) {
          emit(state.copyWith(aminities: <String>[]));
        }
        editedInfo = data;
        if (editedInfo != null) {
          emit(state.copyWith(title: data.property.title));
          emit(state.copyWith(slug: data.property.slug));
          emit(state.copyWith(purpose: data.property.purpose));
          emit(state.copyWith(seoTitle: data.property.seoTitle));
          emit(state.copyWith(
              seoMetaDescription: data.property.seoMetaDescription));
          emit(state.copyWith(typeId: data.property.propertyTypeId.toString()));
          emit(state.copyWith(
              rentPeriod: data.property.rentPeriod.isNotEmpty
                  ? data.property.rentPeriod
                  : ''));
          //  debugPrint('rent-period ${data.property.rentPeriod}');
          emit(state.copyWith(price: data.property.price.toString()));
          emit(state.copyWith(totalArea: data.property.totalArea.toString()));
          emit(state.copyWith(totalUnit: data.property.totalUnit.toString()));
          emit(state.copyWith(
              totalBedroom: data.property.totalBedroom.toString()));
          emit(state.copyWith(
              totalBathroom: data.property.totalBathroom.toString()));
          emit(state.copyWith(
              totalGarage: data.property.totalGarage.toString()));
          emit(state.copyWith(
              totalKitchen: data.property.totalKitchen.toString()));
          emit(state.copyWith(
              description: Utils.htmlTextConverter(data.property.description)));
          emit(state.copyWith(status: data.property.status));
          emit(state.copyWith(tempImage: data.property.thumbnailImage));
          //emit(state.copyWith(image: data.property.thumbnailImage));
          List<String> tempAminities = [];
          List<ExistingSlider> tempGallery = [];
          List<NearestLocationDto> tempLocation = [];
          List<AdditionalInfoDto> tempAdditional = [];
          List<PropertyPlanDto> tempPlan = [];
          if (tempAminities.isNotEmpty) {
            tempAminities.clear();
          }
          if (tempGallery.isNotEmpty) {
            tempGallery.clear();
          }
          if (tempLocation.isNotEmpty) {
            tempLocation.clear();
          }
          if (tempAdditional.isNotEmpty) {
            tempAdditional.clear();
          }
          if (tempPlan.isNotEmpty) {
            tempPlan.clear();
          }
          if (data.existingAminities.isNotEmpty) {
            for (int i = 0; i < data.existingAminities.length; i++) {
              data.aminities.map((e) {
                if (e.id == data.existingAminities[i].aminityId) {
                  tempAminities.add(e.id.toString());
                }
              }).toList();
            }
            emit(state.copyWith(aminities: tempAminities));
          }
          if (data.existingSliders.isNotEmpty) {
            for (int i = 0; i < data.existingSliders.length; i++) {
              final slider = data.existingSliders[i];
              if (slider.image.isNotEmpty) {
                tempGallery.add(
                  ExistingSlider(
                    id: slider.id,
                    propertyId: slider.propertyId,
                    image: slider.image,
                  ),
                );
              }
            }
            emit(state.copyWith(galleryImage: tempGallery));
          }
          emit(state.copyWith(
              propertyVideoDto: PropertyVideoDto(
                  videoThumbnail: data.property.videoThumbnail,
                  videoId: data.property.videoId,
                  videoDescription: data.property.videoDescription)));
          emit(state.copyWith(
            propertyLocationDto: PropertyLocationDto(
                cityId: data.property.cityId,
                address: data.property.address,
                addressDescription: data.property.addressDescription,
                googleMap: data.property.googleMap),
          ));

          //placing nearest locations image in the state
          if (data.existingNearest.isNotEmpty) {
            for (int i = 0; i < data.existingNearest.length; i++) {
              //final item = data.existingNearest[i];
              // tempModel.add(NearestLocationModel(
              //     id: item.id,
              //     location: item.nearestLocationId.toString(),
              //     status: 0));
              // debugPrint('nearest-location-idssss ${item.nearestLocationId} | ${item.id}');
              tempLocation.add(NearestLocationDto(
                  id: data.existingNearest[i].id,
                  locationId: data.existingNearest[i].nearestLocationId,
                  distances: data.existingNearest[i].distance));
            }

            emit(state.copyWith(nearestLocationList: tempLocation));
          }
          if (data.existingAddInfo.isNotEmpty) {
            for (int i = 0; i < data.existingAddInfo.length; i++) {
              final item = data.existingAddInfo[i];
              tempAdditional.add(AdditionalInfoDto(
                  id: item.id, addKeys: item.addKey, addValues: item.addValue));
            }
            emit(state.copyWith(addtionalInfoList: tempAdditional));
          }
          if (data.existingPlan.isNotEmpty) {
            for (int i = 0; i < data.existingPlan.length; i++) {
              final item = data.existingPlan[i];
              tempPlan.add(
                PropertyPlanDto(
                  id: item.id,
                  planImages: item.image,
                  planTitles: item.title,
                  planDescriptions: item.description,
                ),
              );
            }
            emit(state.copyWith(propertyPlanDto: tempPlan));
          }
        }
        emit(state.copyWith(addState: AddPropertyEdited(data)));
      },
    );
  }

  FutureOr<void> resetData() {

    emit(
      state.copyWith(
        addState: const AddPropertyInitial(),
        propertyPlanDto: <PropertyPlanDto>[],
        addtionalInfoList: <AdditionalInfoDto>[],
        nearestLocationList: <NearestLocationDto>[],
        galleryImage: <ExistingSlider>[],
        aminities: <String>[],
        image: '',
        tempImage: '',
        title: '',
        price: '',
        totalArea: '',
        totalUnit: '',
        totalBathroom: '',
        totalBedroom: '',
        totalKitchen: '',
        totalGarage: '',
        description: '',
        seoTitle: '',
        seoMetaDescription: '',
        propertyLocationDto: const PropertyLocationDto(
            cityId: 0, address: '', addressDescription: '', googleMap: ''),
        propertyVideoDto: const PropertyVideoDto(
            videoThumbnail: '', videoId: '', videoDescription: ''),
      ),
    );
  }

  Future<void> getProperties() async {

    debugPrint('add-property-body ${state.toMap()}');
    emit(state.copyWith(addState: const AddPropertyLoading()));
    final result = await _repository.getMyProperties();
    result.fold(
          (failure) {
        if (failure is InvalidAuthData) {
          final errorState = AddPropertyFormError(failure.errors);
          emit(state.copyWith(addState: errorState));
        } else {
          final errors = AddPropertyError(failure.message, failure.statusCode);
          emit(state.copyWith(addState: errors));
        }
      },
          (success) {
        debugPrint("Success");
        emit(state.copyWith(properties: success,addState: const AddPropertyInitial()));
      },
    );

  }

  void editProperty(Properties? property,BuildContext context) {
    emit(state.copyWith(addState: const AddPropertyLoading()));
    debugPrint("Property Type Id: ${property!.bhkType.toString()}");
    state.staticInfo?.city?.forEach((element){


      if(element.id.toString() == property.cityId.toString()){
        context
            .read<AddPropertyCubit>()
            .changeCity(element.name ?? "", element.id.toString());
      }
    });
    List<File> sliderImages = [];
    (property.sliders ?? []).skip(1).forEach((element) {
      sliderImages.add(File(element.image));
    });

    context
        .read<AddPropertyCubit>()
        .state
        .staticInfo
        ?.roomType
        ?.forEach((element) {
      debugPrint("element ==> ${element.id}");

      context.read<AddPropertyCubit>().changeRoomType(
          element.name ?? "",
          property!.bhkType.toString());

    });

    context.read<AddPropertyCubit>().addSliders(sliderImages);

    List<String> aminities = [];
    property.aminityItemDto?.forEach((element){
      aminities.add(element.aminityId.toString());
    });
    context.read<AddPropertyCubit>().addAminitiesValue(
        aminities,false);

    List<String> keys = [];
    List<String> values = [];
    property.propertyAdditionInfo?.forEach((element){
     keys.add(element.addKey);
     values.add(element.addValue);
    });

    context.read<AddPropertyCubit>().addAdditionalKey(keys);
    context.read<AddPropertyCubit>().addAdditionalValue(values);

    List<Map<String, dynamic>> nearestLocation = [];
    property.propertyLocation?.forEach((element){
      nearestLocation.add({"id":element.location?.id,"value":element.distance});

    });


    String roomType = "";
    String roomTypeId = "";
    context.read<AddPropertyCubit>().state.staticInfo?.roomType?.forEach((element) {
      if(element.id.toString() == property.bhkType.toString()){
        roomType = element.name ?? "";
        roomTypeId = element.id.toString();
      }
    });
    context.read<AddPropertyCubit>().changeNearestLocation(nearestLocation);
    emit(state.copyWith(
      addState: const AddPropertyInitial(),
      purpose: (property.purpose ?? '').toString() == "1"? "buy" : "rent",
      title: property.title ?? '',
      price: property.price.toString() ?? '',
      totalArea: property.totalArea ?? '',
      totalUnit: property.totalUnit ?? '',
      totalBedroom: property.totalBedroom ?? '',
      roomType: roomType,
      roomTypeId: roomTypeId,
      totalBathroom: property.totalBathroom ?? '',
      // totalBalcony: property?.totalBalcony ?? '',
      totalKitchen: property.totalKitchen ?? '',
      totalGarage: property.totalGarage ?? '',
      description: property.description ?? '',
      cityId: property.cityId.toString()?? '',
      stateId: property.stateId.toString()?? '',
      rentPeriod: capitalizeFirstLetter(property.rentPeriod ?? ''),
      address: property.address ?? '',
      thumbNailImage: property.thumbnailImage ?? '',
      categoryId: property.categoryId ?? '',
      propertyTypeId: property.propertyTypeId.toString(),
      // roomTypeId: property.bhkType.toString(),

      // categoryId: property?.categoryId ?? '',
    ));


    // changeCity(property?. ?? '', property?.cityId.toString() ?? '');
    // changeState(property?.state ?? '', property?.stateId.toString() ?? '');
  }

  void changeFurnished(String? value) {

    emit(state.copyWith(furnished: value, addState: const AddPropertyInitial()));
  }

  void changeElevator(String? value) {

    emit(state.copyWith(elevator: value, addState: const AddPropertyInitial()));
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

}
