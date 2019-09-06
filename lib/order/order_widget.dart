import 'package:flutter/material.dart';
import 'package:operation/base/base_bloc.dart';
import 'package:operation/data/dep_user.dart';
import 'package:operation/order/order_refresh_bloc.dart';

class OrderWidget extends StatefulWidget {
  final VoidCallback callback;

  const OrderWidget({Key key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OrderWidgetState();
  }
}

class _OrderWidgetState extends State<OrderWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List _tabs;
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    print('order widget init');
    _tabs ??= ['个人工单', '未接工单', '已接工单'];
    _tabController = TabController(length: _tabs.length, vsync: this);

    _pages ??= [
      BlocProvider<OrderRefreshBloc>(
        bloc: OrderRefreshBloc(),
        child: RefreshWidget(),
      ),
      BlocProvider<OrderRefreshBloc>(
        bloc: OrderRefreshBloc(),
        child: RefreshWidget(),
      ),
      BlocProvider<OrderRefreshBloc>(
        bloc: OrderRefreshBloc(),
        child: RefreshWidget(),
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        bottom: TabBar(
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: _tabs.map((item) {
            return Tab(
              text: item,
            );
          }).toList(),
          controller: _tabController,
        ),
        backgroundColor: Color(0XFF2D3231),
        title: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                  onTap: widget.callback,
                  child: Icon(
                    Icons.menu,
                    color: Color(0xff46cbaa),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  '工单',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
    );
  }
}

class RefreshWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RefreshWidgetState();
  }
}

class _RefreshWidgetState extends State<RefreshWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OrderRefreshBloc bloc = BlocProvider.of<OrderRefreshBloc>(context);
    //首次加载一下就ok
    bloc.requestData();
    return StreamBuilder(
      initialData: null,
      stream: bloc.outStream,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<dynamic> datas = snapshot.data;
        return RefreshIndicator(
          onRefresh: bloc.requestData,
          child: (datas != null && datas.length > 0)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    DepUser content = datas[index] as DepUser;
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
//                top: Divider.createBorderSide(context),
                          bottom: Divider.createBorderSide(context),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            '${content.USER_NAME}-----${content.USER_CODE}',
                            textScaleFactor: 2,
                            style: TextStyle(color: Colors.pink),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : datas == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomScrollView(
                      slivers: <Widget>[
                        SliverFillViewport(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Center(
                                child: Text(
                                  '暂无相关信息',
                                  textScaleFactor: 1.5,
                                ),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
