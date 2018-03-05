/*
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
#pragma once

//C++ std
//#include <string>
//#include <vector>

// 画面
static const float VIEW_MAX_SCALE = 2.0f;
static const float VIEW_MIN_SCALE = 0.8f;

static const float VIEW_LOGICAL_LEFT = -1;
static const float VIEW_LOGICAL_RIGHT = 1;

static const float VIEW_LOGICAL_MAX_LEFT = -2;
static const float VIEW_LOGICAL_MAX_RIGHT = 2;
static const float VIEW_LOGICAL_MAX_BOTTOM = -2;
static const float VIEW_LOGICAL_MAX_TOP = 2;


// モデル定義------------------------------------------------------------------------
// モデルの後ろにある背景の画像ファイル
static const char BACK_IMAGE_NAME[] = "back_class_normal.png" ;


// モデル定義-----------------------------------------------------------------------
static const char MODEL_HARU[]		= "live2d/haru/haru.model.json";
//static const char MODEL_HARU_A[]        = "live2d/haru/haru_01.model.json";
//static const char MODEL_HARU_B[]        = "live2d/haru/haru_02.model.json";
//static const char MODEL_SHIZUKU[]        = "live2d/shizuku/shizuku.model.json";
static const char MODEL_WANKO[]       = "live2d/tangli/tangli.model.json";


// 外部定義ファイル(json)と合わせる
static const char MOTION_GROUP_IDLE[]			="idle";// アイドリング
static const char MOTION_GROUP_TAP_BODY[]		="";// 体をタップしたとき
static const char MOTION_GROUP_FLICK_HEAD[]	="flick_head";// 頭を撫でた時
static const char MOTION_GROUP_PINCH_IN[]		="pinch_in";// 拡大した時
static const char MOTION_GROUP_PINCH_OUT[]		="pinch_out";// 縮小した時
static const char MOTION_GROUP_SHAKE[]			="shake";// シェイク

// 外部定義ファイル(json)と合わせる
static const char HIT_AREA_HEAD[]		="head";
static const char HIT_AREA_BODY[]		="body";

// モーションの優先度定数
static const int PRIORITY_NONE  = 0;
static const int PRIORITY_IDLE  = 1;
static const int PRIORITY_NORMAL= 2;
static const int PRIORITY_FORCE = 3;


class LAppDefine {
public:
    static const bool DEBUG_LOG=false;// デバッグ用ログの表示
    static const bool DEBUG_TOUCH_LOG=false;// タッチしたときの冗長なログの表示
	static const bool DEBUG_DRAW_HIT_AREA=false;// あたり判定の可視化
};
