// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddSupportCaseRequest _$AddSupportCaseRequestFromJson(
    Map<String, dynamic> json) {
  return _AddSupportCaseRequest.fromJson(json);
}

/// @nodoc
mixin _$AddSupportCaseRequest {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get attachmentUrls => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddSupportCaseRequestCopyWith<AddSupportCaseRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddSupportCaseRequestCopyWith<$Res> {
  factory $AddSupportCaseRequestCopyWith(AddSupportCaseRequest value,
          $Res Function(AddSupportCaseRequest) then) =
      _$AddSupportCaseRequestCopyWithImpl<$Res, AddSupportCaseRequest>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      List<String> attachmentUrls,
      String userId,
      DateTime createdAt});
}

/// @nodoc
class _$AddSupportCaseRequestCopyWithImpl<$Res,
        $Val extends AddSupportCaseRequest>
    implements $AddSupportCaseRequestCopyWith<$Res> {
  _$AddSupportCaseRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? attachmentUrls = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrls: null == attachmentUrls
          ? _value.attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddSupportCaseRequestImplCopyWith<$Res>
    implements $AddSupportCaseRequestCopyWith<$Res> {
  factory _$$AddSupportCaseRequestImplCopyWith(
          _$AddSupportCaseRequestImpl value,
          $Res Function(_$AddSupportCaseRequestImpl) then) =
      __$$AddSupportCaseRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      List<String> attachmentUrls,
      String userId,
      DateTime createdAt});
}

/// @nodoc
class __$$AddSupportCaseRequestImplCopyWithImpl<$Res>
    extends _$AddSupportCaseRequestCopyWithImpl<$Res,
        _$AddSupportCaseRequestImpl>
    implements _$$AddSupportCaseRequestImplCopyWith<$Res> {
  __$$AddSupportCaseRequestImplCopyWithImpl(_$AddSupportCaseRequestImpl _value,
      $Res Function(_$AddSupportCaseRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? attachmentUrls = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_$AddSupportCaseRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrls: null == attachmentUrls
          ? _value._attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddSupportCaseRequestImpl implements _AddSupportCaseRequest {
  const _$AddSupportCaseRequestImpl(
      {required this.id,
      required this.title,
      this.description,
      final List<String> attachmentUrls = const [],
      required this.userId,
      required this.createdAt})
      : _attachmentUrls = attachmentUrls;

  factory _$AddSupportCaseRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddSupportCaseRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  final List<String> _attachmentUrls;
  @override
  @JsonKey()
  List<String> get attachmentUrls {
    if (_attachmentUrls is EqualUnmodifiableListView) return _attachmentUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachmentUrls);
  }

  @override
  final String userId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'AddSupportCaseRequest(id: $id, title: $title, description: $description, attachmentUrls: $attachmentUrls, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddSupportCaseRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._attachmentUrls, _attachmentUrls) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      const DeepCollectionEquality().hash(_attachmentUrls), userId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddSupportCaseRequestImplCopyWith<_$AddSupportCaseRequestImpl>
      get copyWith => __$$AddSupportCaseRequestImplCopyWithImpl<
          _$AddSupportCaseRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddSupportCaseRequestImplToJson(
      this,
    );
  }
}

abstract class _AddSupportCaseRequest implements AddSupportCaseRequest {
  const factory _AddSupportCaseRequest(
      {required final String id,
      required final String title,
      final String? description,
      final List<String> attachmentUrls,
      required final String userId,
      required final DateTime createdAt}) = _$AddSupportCaseRequestImpl;

  factory _AddSupportCaseRequest.fromJson(Map<String, dynamic> json) =
      _$AddSupportCaseRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  List<String> get attachmentUrls;
  @override
  String get userId;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AddSupportCaseRequestImplCopyWith<_$AddSupportCaseRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Attachment {
  String get path => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  AttachmentUploadStatus get uploadStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AttachmentCopyWith<Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentCopyWith<$Res> {
  factory $AttachmentCopyWith(
          Attachment value, $Res Function(Attachment) then) =
      _$AttachmentCopyWithImpl<$Res, Attachment>;
  @useResult
  $Res call(
      {String path,
      String? url,
      String name,
      AttachmentUploadStatus uploadStatus});
}

/// @nodoc
class _$AttachmentCopyWithImpl<$Res, $Val extends Attachment>
    implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? url = freezed,
    Object? name = null,
    Object? uploadStatus = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uploadStatus: null == uploadStatus
          ? _value.uploadStatus
          : uploadStatus // ignore: cast_nullable_to_non_nullable
              as AttachmentUploadStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttachmentImplCopyWith<$Res>
    implements $AttachmentCopyWith<$Res> {
  factory _$$AttachmentImplCopyWith(
          _$AttachmentImpl value, $Res Function(_$AttachmentImpl) then) =
      __$$AttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String path,
      String? url,
      String name,
      AttachmentUploadStatus uploadStatus});
}

/// @nodoc
class __$$AttachmentImplCopyWithImpl<$Res>
    extends _$AttachmentCopyWithImpl<$Res, _$AttachmentImpl>
    implements _$$AttachmentImplCopyWith<$Res> {
  __$$AttachmentImplCopyWithImpl(
      _$AttachmentImpl _value, $Res Function(_$AttachmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? url = freezed,
    Object? name = null,
    Object? uploadStatus = null,
  }) {
    return _then(_$AttachmentImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uploadStatus: null == uploadStatus
          ? _value.uploadStatus
          : uploadStatus // ignore: cast_nullable_to_non_nullable
              as AttachmentUploadStatus,
    ));
  }
}

/// @nodoc

class _$AttachmentImpl implements _Attachment {
  const _$AttachmentImpl(
      {required this.path,
      this.url,
      this.name = '',
      this.uploadStatus = AttachmentUploadStatus.uploading});

  @override
  final String path;
  @override
  final String? url;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final AttachmentUploadStatus uploadStatus;

  @override
  String toString() {
    return 'Attachment(path: $path, url: $url, name: $name, uploadStatus: $uploadStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uploadStatus, uploadStatus) ||
                other.uploadStatus == uploadStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, url, name, uploadStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      __$$AttachmentImplCopyWithImpl<_$AttachmentImpl>(this, _$identity);
}

abstract class _Attachment implements Attachment {
  const factory _Attachment(
      {required final String path,
      final String? url,
      final String name,
      final AttachmentUploadStatus uploadStatus}) = _$AttachmentImpl;

  @override
  String get path;
  @override
  String? get url;
  @override
  String get name;
  @override
  AttachmentUploadStatus get uploadStatus;
  @override
  @JsonKey(ignore: true)
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
