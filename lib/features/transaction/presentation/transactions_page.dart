import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:salon_reservation/features/transaction/data/transaction_model.dart';
import 'package:salon_reservation/features/transaction/domain/transaction_repo.dart';
import 'package:salon_reservation/features/transaction/presentation/tranaction_card.dart';

import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constants/helpers.dart';
import '../../../core/utils/service_locator.dart';
import '../../../core/widget/base_page.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        isCentered: false,
        title: 'transactions'.tr(),
        isScrollable: false,
        hasMenu: true,
        hasPadding: false,
        content:  Column(
          children: [
            Height.v2,
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: PaginationList<Transaction>(
                    repositoryCallBack: (data) =>
                        TransactionRepository.getTransactions(
                            data,
                        ),
                    onCubitCreated: (cubit) {
                      ServiceLocator.setTransactions(cubit!);
                    },
                    listBuilder: (list) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return TransactionCard(
                              transaction: list[index],
                            );
                          },
                          separatorBuilder: (context, _) {
                            return Height.v4;
                          },
                          itemCount: list.length
                      );
                    }
                ),
              ),
            ),
          ],
        ));
  }
}

