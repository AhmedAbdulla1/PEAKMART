// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
//
// import '../toast.dart';
//
// void reportDialog({
//   required SingleMessageScreenNotifier sn,
//
// }) {
//   showDialog(
//       context: AppConfig().appContext,
//       builder: (context) {
//         return Dialog(
//           child: ReportDialog(sn: sn,
//
//           ),
//         );
//       });
// }
//
// class ReportDialog extends StatefulWidget {
//   final  SingleMessageScreenNotifier sn;
//
//   const  ReportDialog({
//     Key? key,
//     required this.sn,
//   }) : super(key: key);
//
//   @override
//   State<ReportDialog> createState() => _ReportDialogState();
// }
//
// class _ReportDialogState extends State<ReportDialog> {
//   ImagePicker picker = ImagePicker();
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<SingleMessageScreenNotifier>.value(
//       value: widget.sn,
//       child: Container(
//         // height: 0.3.sh,
//         width: 0.99.sw,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     Translation.current.report,
//                     style: TextStyle(
//                         fontSize: 50.sp,
//                         fontWeight: FontWeight.bold
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                       labelText: Translation.current.reason,
//                     ),
//                     style: const TextStyle(
//                       color: AppColors.black,
//                     ),
//
//                     cursorColor: AppColors.mansourDarkOrange3,
//                     controller: widget.sn.reasonController,
//                     // onFieldSubmitted: (term) {
//                     //   sn.reason=term;
//                     //
//                     // },
//                     // onChanged: (value) {
//                     //   sn.reason=value;
//                     // },
//                   ),
//                   Gaps.vGap64,
//                   BlocConsumer<MessagesCubit,MessagesState>(
//                     bloc: widget.sn.reportCubit,
//                     builder: (context, state) {
//                     return state.maybeMap(
//                         messagesLoadingState: (value) {
//                         return const CircularProgressIndicator.adaptive();
//                       },
//                        orElse: (){
//                          return  CustomMansourButton(
//                            titleText: Translation.current.confirm,
//                            textColor: AppColors.lightFontColor,
//                            onPressed: () {
//                              widget.sn.reasonController.text.trim();
//                              if(widget.sn.reasonController.text != '' || widget.sn.reasonController.text != null || widget.sn.reasonController.text.isNotEmpty){
//                                widget.sn.reportConversation();
//                              }else{
//                                Toast.show(Translation.current.A_blank_report_cannot_be_added);
//                              }
//                            },
//                          );
//
//                        }
//                     );
//                   }, listener: (context, state) {
//                     state.maybeMap(messagesReportState: (value) {
//                       Toast.show(Translation.current.The_report_has_been_added_successfully);
//                       widget.sn.reasonController.clear();
//                       Nav.pop();
//                       Nav.pop();
//                     },
//                       messagesErrorState: (value) {
//                         Toast.show(Translation.current.An_error_occurred_when_adding_the_report);
//                       },
//                     orElse: (){}
//                     );
//                   },),
//
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
