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
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get attachment_urls => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;

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
      {String? id,
      String title,
      String? description,
      List<String> attachment_urls,
      String user_id,
      DateTime created_at});
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
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? attachment_urls = null,
    Object? user_id = null,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      attachment_urls: null == attachment_urls
          ? _value.attachment_urls
          : attachment_urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
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
      {String? id,
      String title,
      String? description,
      List<String> attachment_urls,
      String user_id,
      DateTime created_at});
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
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? attachment_urls = null,
    Object? user_id = null,
    Object? created_at = null,
  }) {
    return _then(_$AddSupportCaseRequestImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      attachment_urls: null == attachment_urls
          ? _value._attachment_urls
          : attachment_urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddSupportCaseRequestImpl implements _AddSupportCaseRequest {
  const _$AddSupportCaseRequestImpl(
      {this.id,
      required this.title,
      this.description,
      final List<String> attachment_urls = const [],
      required this.user_id,
      required this.created_at})
      : _attachment_urls = attachment_urls;

  factory _$AddSupportCaseRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddSupportCaseRequestImplFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final String? description;
  final List<String> _attachment_urls;
  @override
  @JsonKey()
  List<String> get attachment_urls {
    if (_attachment_urls is EqualUnmodifiableListView) return _attachment_urls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachment_urls);
  }

  @override
  final String user_id;
  @override
  final DateTime created_at;

  @override
  String toString() {
    return 'AddSupportCaseRequest(id: $id, title: $title, description: $description, attachment_urls: $attachment_urls, user_id: $user_id, created_at: $created_at)';
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
                .equals(other._attachment_urls, _attachment_urls) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_attachment_urls),
      user_id,
      created_at);

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
      {final String? id,
      required final String title,
      final String? description,
      final List<String> attachment_urls,
      required final String user_id,
      required final DateTime created_at}) = _$AddSupportCaseRequestImpl;

  factory _AddSupportCaseRequest.fromJson(Map<String, dynamic> json) =
      _$AddSupportCaseRequestImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  List<String> get attachment_urls;
  @override
  String get user_id;
  @override
  DateTime get created_at;
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
