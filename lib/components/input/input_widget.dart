import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'input_model.dart';
export 'input_model.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    Key? key,
    this.inputname,
    this.callBack,
  }) : super(key: key);

  final String? inputname;
  final Future<dynamic> Function()? callBack;

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late InputModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InputModel());

    _model.emailAddressController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Stack(
        children: [
          TextFormField(
            controller: _model.emailAddressController,
            obscureText: false,
            decoration: InputDecoration(
              labelText: widget.inputname,
              labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    color: Color(0xFF57636C),
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
              hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    color: Color(0xFF57636C),
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFDBE2E7),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 20.0, 24.0),
            ),
            style: FlutterFlowTheme.of(context).bodyMedium,
            maxLines: null,
            validator:
                _model.emailAddressControllerValidator.asValidator(context),
          ),
          if (widget.inputname == 'Search...')
            Align(
              alignment: AlignmentDirectional(1.0, 0.0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: FaIcon(
                  FontAwesomeIcons.search,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  await queryLocationsRecordOnce()
                      .then(
                        (records) => _model.simpleSearchResults = TextSearch(
                          records
                              .map(
                                (record) =>
                                    TextSearchItem(record, [record.name!]),
                              )
                              .toList(),
                        )
                            .search(_model.emailAddressController.text)
                            .map((r) => r.object)
                            .toList(),
                      )
                      .onError((_, __) => _model.simpleSearchResults = [])
                      .whenComplete(() => setState(() {}));

                  setState(() {
                    _model.searchResults = _model.simpleSearchResults
                        .map((e) => e.name)
                        .withoutNulls
                        .toList();
                  });
                  await widget.callBack?.call();
                },
              ),
            ),
        ],
      ),
    );
  }
}
