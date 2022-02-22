Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B31A4BF469
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Feb 2022 10:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiBVJIc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Feb 2022 04:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiBVJIb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Feb 2022 04:08:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4470914866B;
        Tue, 22 Feb 2022 01:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645520886; x=1677056886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zSsyYa6LKQSrRxv84/mkjVqy4RlfHwqEVNqkVPc1Rto=;
  b=dCnAtUtb0iEEWN3y+kW327ci+CpyIKNrLZz18LcP2+MKo4vG5tVnscCA
   ZTb90v6MXeZUoxRGOpXF/tCco7fM53vaFmSxNEitdbR6Yzt7qZuJ5vlBR
   5/jBdk+MlaofbnqvrmkYYe+aoEy8Acni3gr0Z255e31QdsZvg0CDmZ4w3
   yXlMlwYa5fRg7Htw7dPh35e3xAcJGSynQDitN5NkjOREYfB7m3N7dAHA8
   XUfNt9+97NcM0VsjNwjDKm0ob/LD73qSfBaUmXNogI6KEJSEoxugnCcCk
   J5g89VUdz1WRsUog2pCM1iGj6VHKBxBDuViQkBNXAIg5UFBNZpMt6L7dp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="249225559"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="249225559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 01:08:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="706538684"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga005.jf.intel.com with ESMTP; 22 Feb 2022 01:08:05 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 22 Feb 2022 01:07:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 22 Feb 2022 01:07:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 22 Feb 2022 01:07:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6iG4IwcXWAORF1qz6xlR72+SVZGPIEc/3rTorM6wZcmeT2UerJxIdaOFN1ackt1aEHfPo9QGxzq4AcwZ6RovxjOusXRtNREqbefZCBCN8YjB0zBNNa2y0XbrFnpDwkrjGfnrrC9i3IfUwCene5ytky0LI1K+hJHPXKX/XXg2Db+XjCs4/yncfcRgvYvz0lCaqizMUgCjKxh+4jGmvIpllio56t66FHHWvmrm1MlMBJNpSX3IdQmxQbu0/wkXHLUSrKE0jhDssSakRaizE6g6sTfrVzSC5fd0srAEf8K5YywgCdLKIbdZR+Wv/VxnS8qelckeS+lCDSiwxqAmEitWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSsyYa6LKQSrRxv84/mkjVqy4RlfHwqEVNqkVPc1Rto=;
 b=Oe7RsTNypyqz0Iokzswg+nh/W2hsn1C/8TivpB/qUjL1555ZxYoYoBvUOXWaiAleE3Z9y0Vp+Dgf8nVals2XU0G74TYR7HDHhqDSD4ra/wLCgGTT9zUwJVG6rWKMw1qzBA1ngQq3qqzoL447vr/OQbU97pW9tvr/K7NhUG+DZRA0hnVJ+qLbCXxI2aiyk0Oj2VNYNTdppRvJ12Zt0KowD8VOH/ibhpDS4qjbhzZcJiHWtRZlJvYkgMbtGxgRoJD04uOl+EzUrtRl9ooXkmbT935VtLVrluOyFCmryh680iRZ4IaIPuHMR8e1B3I7400RWK14dnAg/QzAfEHk/Ry6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MWHPR11MB1952.namprd11.prod.outlook.com (2603:10b6:300:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 09:07:36 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 09:07:36 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Tom Rix <trix@redhat.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
Thread-Topic: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
Thread-Index: AQHYIZYvt4gS1fF4bUKEbM/1CaiLCqyUt+KAgAQuCxCAAIRPAIAE4cuAgAAIOoCAAP3hoA==
Date:   Tue, 22 Feb 2022 09:07:36 +0000
Message-ID: <BN9PR11MB548397E1986248FB3B4510B8E33B9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-4-tianfei.zhang@intel.com>
 <0fdd3d0d-d280-8104-eccc-8fa8d8a992c2@redhat.com>
 <BN9PR11MB548314968CBC0CA5E446B366E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
 <efee5ac0-4c3a-085d-9b9d-0c8ade022f30@redhat.com>
 <alpine.DEB.2.22.394.2202210912260.117064@rhweight-WRK1>
 <8137a208-43e3-3843-eca9-f6ec627e8d0e@redhat.com>
In-Reply-To: <8137a208-43e3-3843-eca9-f6ec627e8d0e@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4224a6e2-c722-4ab4-bed4-08d9f5e2c50e
x-ms-traffictypediagnostic: MWHPR11MB1952:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB19527808BD0387E884565CFBE33B9@MWHPR11MB1952.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5MrFSmjUR1a5MPIUUJWje95aUF71+iGOKwS3HZgRnFGRhsq9VfHZCD/LlIKzeZEa7laC7GOpeDWzLdT67tuAIF2PBxRHdt7VnM3GOtp8IcWVD8YI/OAdo/WLEg64FN6FdlNXzKOhqmYwpoHlsR8eIjkUA/B/Ta4R5HQj08j1lGE5D5X8FHxzuthmqo8vdQ2M3Wc9SNHZ/QGOCxV0kAYj0h0O5qLNMi2ftR5azH7qDivz11jX/XhRXJsByLhHKzz9l7WPLNEGmn92LWpjiANS3OPQDiWteLMhgyqngB9vjEgdvLMaYbbVT6DiphW7EBtR3SBWtozXcKw9Aqoi8tqpTA12RgoFvrIyeI3nsitEXXUzd28nhTjbC6HTkM9tUqlSN677RxxqMMqFo+eETlTvRFQINwhPOBtYMbnGI9laciO+uLFJBNEcqJEGNO6+xgttSzvzazLKpIDYKaUNhsbuJJzxwiL+3H9yCenA9eKQwPjqVQ/HUHw0F01ws6WF8fL1KK1SaAX/FaZNouC3E4b1dHRkbUOFN3l/OfND7K2o+P+h2OqWeqKaK/KLDqYHtdjnA2qce1iRd5+FhKqRK7xYpivlvFDVOvJzMNCAOpe8tNTbrV924RqSQS6PZlggnX0jB0hkv9Gwjx/A006DeMWZz/NYT8mTxsLr+jYVHpnUbLKuVKl0y+nVCNE46rJuzd9YYyXJMfUTth/9CILcEvAnKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(86362001)(6506007)(186003)(26005)(71200400001)(2906002)(38100700002)(122000001)(38070700005)(82960400001)(53546011)(66556008)(8676002)(66476007)(110136005)(76116006)(316002)(508600001)(54906003)(83380400001)(66446008)(4326008)(66946007)(64756008)(8936002)(9686003)(5660300002)(33656002)(55016003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2N3Rk9xN1kyb010THFRRVJYRFFIVjhGMmpWUjA3TTRvdUtSMHd0STVoamIv?=
 =?utf-8?B?eUlkT2tNVmJUR2VYM0tMMkhtSGppdlRlWGJ2VnRHZ3VDY00zbnQ0OUEyandq?=
 =?utf-8?B?aEgycXhoRStWU2tYYjF2cy9XZFNubnhiZ0Zrd3ZWT1ZDYjZOK2VTYk5EVDYv?=
 =?utf-8?B?UXdJc0dsRHBxNDg4UnBobDk0ekVWWTNiTmdJMWl1ZEE1cUJzMGVQY2hKMit3?=
 =?utf-8?B?M1VwTy9kUThZMkgxSU00QWgrRXZHN0dXYzRDZ1dudXlNVElyM0U3RkZtVER5?=
 =?utf-8?B?bko1eVgzTzAvMVBoN0NJOExZNHNYYzNPSXltakVNdkcwdll5c1RQQUVIODhu?=
 =?utf-8?B?cHd5anlpS1FxT3NnUng4aG9XMFBQUEU5c1FlUlNYUXNrL0NPUnVKMnZBS3g0?=
 =?utf-8?B?MmJXVktKN0NWNjBWWURFUFdGWC82bms3Z1QyZng0dXBuWCtWemoxOXVsS2Zn?=
 =?utf-8?B?WGVGZkpQVWVxeTM0QWtjdldSdithTjhXV29TcG0rbW9vUmFXOTE5a2NMZk1R?=
 =?utf-8?B?VUtvcWxUNXpXSHhoaStSM1Q2Lzlad09aVTFFd2Z4TFR2VCs5R0RxUzFZdDhB?=
 =?utf-8?B?UWJhNHlqYTJ0cXJDVGxPTG5wQnNNdzcrVVFCZi9LK2w2NWJMV2tQcFNjTjl3?=
 =?utf-8?B?NlovTzFleFdreERMbkUzMmRSRDZoS3M1ajhKYXJRYWhGeDRERUZXY1pGaGNz?=
 =?utf-8?B?L05GbiszdzZZVG1KWlBXdERVK21jV2xzVlo2c0Zoc1pWNCtyN3pXeWprOXFo?=
 =?utf-8?B?NUpjdnlpWVhJSHFnYWlWcmpMN21sTEx6SHdWbUVlT201aXlIZ3Q2L0hYMGo0?=
 =?utf-8?B?bkR1d1h0dE51RWRuUDFjQ2ZXSUgxaGJPUjZwVHpFRENRVlpXY2p2Tk43T1lF?=
 =?utf-8?B?bmpoeUo4YzFxWGJIc1QralpLRUNxZFVKKzVCeURlZ1VuQ0wxNWJTNTh4MCtH?=
 =?utf-8?B?SU1uOC9jLzhiL2JuYmtyWk1paWdkR2x1YjBtd09DYUFPUUNCZFBpSWZpN3BG?=
 =?utf-8?B?bmN6bGNrTGhFMEtEdXNNTWFDaHBzQTNxYzlkU0tnQVRKMUJWQjNSVzQ1V2dV?=
 =?utf-8?B?NXhoRWo0UnVQT3Y2ck9Xb1Q1ZjRwYUVpdlVETDlpbUh6QnlxSTE0azZGOGI2?=
 =?utf-8?B?bFdrNVFFK2QyZlRkNmNzWEZMN2xaNDREbE80dFFUeGcwNSthNGUrVk1tUUtp?=
 =?utf-8?B?L3BraW9DZHpjTzg3S2ZUbUtIN0t4ODlEdmlGTlJVNjZ1UFI3Q1liQ0ptVkhF?=
 =?utf-8?B?dWNqaUJITmFBYzlzS0F1NUUyaXBoNDdHM3E2c2tSLytJS0U0TTVVQS8rRmdN?=
 =?utf-8?B?RlZraWFBTWowdmczcXV1RGZha25ncUlSR1YwVlNvL0paUytFYUM0S3Z6RFd4?=
 =?utf-8?B?VkIyYlhrb1NWYjA0WlNQY1ovNjRyRU0wK1pSQzU2TmZsV1QzbTVEdjlSQWNX?=
 =?utf-8?B?ajZNNXcxOThST052dG05NTdNWUxjNFBpOUFzeHlJNzVpdUNJZDBsbU0yRDdV?=
 =?utf-8?B?MzhIM3IvaVlvcENzUmMvMTNVQmtrTERpa3RJVVUrK0RpSnE2ZUE5RWlmenQ4?=
 =?utf-8?B?Qk5Sazk1TXl2RWZ0WEVlVHlnYUQxYitvZExscE9EK2QzbHdsVVdESSswUkFz?=
 =?utf-8?B?ZVVqbXluQ0ZMRVQ5aTBxaEE0akFlbHNuK3RnMEliZUpmcGJvdjM5ZTZGMXlp?=
 =?utf-8?B?MkpvanBDcXZ0dmVDYzdBcmdpd01ra2xib2RGeTBYTUM5bDhFdDF6Z1NKbnpu?=
 =?utf-8?B?aGhqWjJWMXRhYmZpMXFhVys2TE1uUXQ0eTdIUGpvbGd5WWhUS1J1enFlWU5l?=
 =?utf-8?B?Vm9KY25tUU9LSWNpU3B0WmovSmg2cHFwK3MvSTlkbFdWZ0FBck5wdHJCMkpP?=
 =?utf-8?B?UmVxWmU4QmZVcU02dHgvRkN4dnRsK3NJQXlHZHMrek5rSVdyajY0WUdTYzFj?=
 =?utf-8?B?aXJ5LzlaM2NodUU0d3JyRlhZRTIwakdGd2VoZ2Zka3orWjg3M0RWaGk0SGpm?=
 =?utf-8?B?a3pKM3dGZUw3WWljbnNzVk9abS81OExwRXNFeHpjcTJXSW80WDdhNXVkR2xu?=
 =?utf-8?B?YWRpSXU1TWxQa1pVNDRJcDVoUm9oK1lFWjJKekdwd3VEQUs5ZzZtbUxOTC9z?=
 =?utf-8?B?cjRqb2JsNWlWVDd2bFNhMkJ2bDkvcnVIMXRHOFRjNEdxKy85V2NFZ0JKdVBu?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4224a6e2-c722-4ab4-bed4-08d9f5e2c50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 09:07:36.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0uGJJuDZyQ6sK53BGHZ7pde4RBG7blXAHOA3Cgf2yrHdWGa8+mpYA2ltwevDc0kn1Kl6Yqn/3JMVoHaIPSLQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1952
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFJpeCA8dHJpeEBy
ZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyMiwgMjAyMiAxOjUyIEFNDQo+
IFRvOiBtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29tDQo+IENjOiBaaGFuZywgVGlhbmZl
aSA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+OyBXdSwgSGFvIDxoYW8ud3VAaW50ZWwuY29tPjsN
Cj4gbWRmQGtlcm5lbC5vcmc7IFh1LCBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPjsgbGludXgt
ZnBnYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjEgMy83XSBmcGdhOiBkZmw6IEFsbG93IGZvciBwb3J0cyB3aXRoIG5vIGxvY2FsIGJh
ciBzcGFjZS4NCj4gDQo+IA0KPiBPbiAyLzIxLzIyIDk6MjIgQU0sIG1hdHRoZXcuZ2VybGFjaEBs
aW51eC5pbnRlbC5jb20gd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIEZyaSwgMTggRmViIDIwMjIs
IFRvbSBSaXggd3JvdGU6DQo+ID4NCj4gPj4NCj4gPj4gT24gMi8xNy8yMiAxMTozMSBQTSwgWmhh
bmcsIFRpYW5mZWkgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+Pj4gRnJvbTogVG9tIFJpeCA8dHJpeEByZWRoYXQuY29tPg0KPiA+Pj4+IFNlbnQ6
IFR1ZXNkYXksIEZlYnJ1YXJ5IDE1LCAyMDIyIDExOjA2IFBNDQo+ID4+Pj4gVG86IFpoYW5nLCBU
aWFuZmVpIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT47IFd1LCBIYW8NCj4gPj4+PiA8aGFvLnd1
QGludGVsLmNvbT47IG1kZkBrZXJuZWwub3JnOyBYdSwgWWlsdW4gPHlpbHVuLnh1QGludGVsLmNv
bT47DQo+ID4+Pj4gbGludXgtZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4+Pj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+Pj4+IENj
OiBjb3JiZXRAbHduLm5ldDsgTWF0dGhldyBHZXJsYWNoDQo+ID4+Pj4gPG1hdHRoZXcuZ2VybGFj
aEBsaW51eC5pbnRlbC5jb20+DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAzLzddIGZw
Z2E6IGRmbDogQWxsb3cgZm9yIHBvcnRzIHdpdGggbm8NCj4gPj4+PiBsb2NhbCBiYXIgc3BhY2Uu
DQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IE9uIDIvMTQvMjIgMzoyNiBBTSwgVGlhbmZlaSB6aGFu
ZyB3cm90ZToNCj4gPj4+Pj4gRnJvbTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hA
bGludXguaW50ZWwuY29tPg0KPiA+Pj4+Pg0KPiA+Pj4+PiDCoCBGcm9tIGEgZnBnYSBwYXJ0aWFs
IHJlY29uZmlndXJhdGlvbiBzdGFuZHBvaW50LCBhIHBvcnQgbWF5IG5vdA0KPiA+Pj4+PiBiZSBj
b25uZWN0ZWQgYW55IGxvY2FsIEJBUiBzcGFjZS7CoCBUaGUgcG9ydCBjb3VsZCBiZSBjb25uZWN0
ZWQgdG8NCj4gPj4+Pj4gYSBkaWZmZXJlbnQgUENJZSBQaHlzaWNhbCBGdW5jdGlvbiAoUEYpIG9y
IFZpcnR1YWwgRnVuY3Rpb24gKFZGKSwNCj4gPj4+Pj4gaW4gd2hpY2ggY2FzZSBhbm90aGVyIGRy
aXZlciBpbnN0YW5jZSB3b3VsZCBtYW5hZ2UgdGhlIGVuZHBvaW50Lg0KPiA+Pj4+IEl0IGlzIG5v
dCBjbGVhciBpZiB0aGlzIGlzIHBhcnQgb2YgaW9mcyBvciBhIGJ1ZyBmaXguDQo+ID4+PiBUaGlz
IGlzIHRoZSBuZXcgaW1wbGVtZW50YXRpb24vZmVhdHVyZSBvZiBJT0ZTLg0KPiA+Pj4gT24gSU9G
UyBzdXBwb3J0IG11bHRpcGxlIG1ldGhvZHMgdG8gYWNjZXNzIHRoZSBBRlUuDQo+ID4+PiAxLiBM
ZWdhY3kgTW9kZWwuIFRoaXMgaXMgdXNlZCBmb3IgTjMwMDAgYW5kIE41MDAwIGNhcmQuDQo+ID4+
PiBJbiB0aGlzIG1vZGVsIHRoZSBlbnRpcmUgQUZVIHJlZ2lvbiBpcyBhIHVuaXQgb2YgUFIsIGFu
ZCB0aGVyZSBpcyBhDQo+ID4+PiBQb3J0IGRldmljZSBjb25uZWN0ZWQgdG8gdGhpcyBBRlUuDQo+
ID4+PiBPbiBERkwgcGVyc3BlY3RpdmUsIHRoZXJlIGlzICJOZXh0IEFGVSIgcG9pbnQgdG8gdGhl
IEFGVSwgYW5kIHRoZQ0KPiA+Pj4gIkJhcklEIiBpc8KgIHRoZSBQQ0llIEJhciBJRCBvZiBBRlUu
DQo+ID4+PiBJbiB0aGlzIG1vZGVsLCB3ZSBjYW4gdXNlIHRoZSBBRlUgQVBJcyB0byBhY2Nlc3Mg
dGhlIGVudGlyZSBBRlUNCj4gPj4+IHJlc291cmNlLCBsaWtlIE1NSU8uDQo+ID4+PiAyLiBNaWNy
by1QZXJzb25hcyBpbiBBRlUuDQo+ID4+PiBJT0ZTIGludHJ1ZGluZyBuZXcgbW9kZWwgZm9yIFBS
IGFuZCBBRlUgYWNjZXNzLg0KPiA+Pj4gTWljcm8tUGVyc29uYXMgYWxsb3cgdGhlIFJUTCBkZXZl
bG9wZXIgdG8gZGVzaWduYXRlIHRoZWlyIG93bg0KPiA+Pj4gQUZVLWRlZmluZWQgUFIgcmVnaW9u
cy4NCj4gPj4+IEluIHRoaXMgbW9kZWwgdGhlIHVuaXQgb2YgUFIgaXMgbm90IHRoZSBlbnRpcmUg
QUZVLCBpbnN0ZWFkIHRoZSB1bml0DQo+ID4+PiBvZiBQUiBjYW4gYmUgYW55IHNpemUgYmxvY2sg
b3IgYmxvY2tzIGluc2lkZSB0aGUgQUZVLg0KPiA+Pj4gMy4gTXVsdGlwbGUgVkZzIHBlciBQUiBz
bG90Lg0KPiA+Pj4gSW4gdGhpcyBtZXRob2QsIHdlIGNhbiBpbnN0YW5jZSBtdWx0aXBsZSBWRnMg
b3ZlciBTUklPViBmb3Igb25lIFBSDQo+ID4+PiBzbG90LCBhbmQgYWNjZXNzIHRoZSBBRlUgcmVz
b3VyY2UgYnkgZGlmZmVyZW50IFZGcyBpbiB2aXJ0dWFsaXphdGlvbg0KPiA+Pj4gdXNhZ2UuIElu
IHRoaXMgY2FzZSwgdGhlIFBvcnQgZGV2aWNlIHdvdWxkIG5vdCBjb25uZWN0ZWQgdG8gQUZVICh0
aGUNCj4gPj4+IEJhcklEIG9mIFBvcnQgZGV2aWNlIHNob3VsZCBiZSBzZXQgdG8gaW52YWxpZCks
IHNvIHRoaXMgcGF0Y2ggd2FudA0KPiA+Pj4gdG8gc3VwcG9ydCB0aGlzIHVzZSBtb2RlbC4NCj4g
Pj4NCj4gPj4gV2hhdCBJIGFtIGxvb2tpbmcgZm9yIGlzIGhvdyB0aGUgb2xkZXIgY2FyZHMgdXNp
bmcgKG15IHRlcm0pIGRmbCAxDQo+ID4+IHdpbGwgc3RpbGwgd29yayB3aXRoIGRmbCAyIGFuZCB2
aWNlIHZlcnNhLg0KPiA+Pg0KPiA+PiBObyB3aGVyZSBkbyBJIHNlZSBhIHZlcnNpb24gY2hlY2sg
Zm9yIGRmbCAyIG5vciBhIHBjaSBpZCBjaGVjayBzbw0KPiA+PiBlaXRoZXIgdGhpcyBqdXN0IHdv
cmtzIG9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgaGFzIG5vdCBiZSBjb25zaWRlcmVkLg0KPiA+
Pg0KPiA+PiBQbGVhc2UgYWRkIGEgYmFja3dhcmQgY29tcGF0aWJpbGl0eSBzZWN0aW9uIHRvIHRo
ZSBkb2MgcGF0Y2gNCj4gPj4NCj4gPj4+DQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcg
R2VybGFjaCA8bWF0dGhldy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4gPj4+Pj4gU2lnbmVk
LW9mZi1ieTogVGlhbmZlaSBaaGFuZyA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+DQo+ID4+Pj4+
IC0tLQ0KPiA+Pj4+PiDCoMKgIGRyaXZlcnMvZnBnYS9kZmwtcGNpLmMgfCA4ICsrKysrKysrDQo+
ID4+Pj4+IMKgwqAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+Pg0KPiA+
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC1wY2kuYyBiL2RyaXZlcnMvZnBnYS9k
ZmwtcGNpLmMgaW5kZXgNCj4gPj4+Pj4gNGQ2ODcxOWU2MDhmLi44YWJkOWI0MDg0MDMgMTAwNjQ0
DQo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwtcGNpLmMNCj4gPj4+Pj4gKysrIGIvZHJp
dmVycy9mcGdhL2RmbC1wY2kuYw0KPiA+Pj4+PiBAQCAtMjQzLDYgKzI0Myw3IEBAIHN0YXRpYyBp
bnQgZmluZF9kZmxzX2J5X2RlZmF1bHQoc3RydWN0IHBjaV9kZXYNCj4gPj4+Pj4gKnBjaWRldiwN
Cj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgdiA9IHJlYWRxKGJhc2UgKyBGTUVfSERSX0NB
UCk7DQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBvcnRfbnVtID0gRklFTERfR0VUKEZN
RV9DQVBfTlVNX1BPUlRTLCB2KTsNCj4gPj4+Pj4NCj4gPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGRl
dl9pbmZvKCZwY2lkZXYtPmRldiwgInBvcnRfbnVtID0gJWRcbiIsIHBvcnRfbnVtKTsNCj4gPj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgV0FSTl9PTihwb3J0X251bSA+IE1BWF9ERkxfRlBHQV9Q
T1JUX05VTSk7DQo+ID4+Pj4+DQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9
IDA7IGkgPCBwb3J0X251bTsgaSsrKSB7IEBAIC0yNTgsNiArMjU5LDEzIEBADQo+ID4+Pj4+IHN0
YXRpYyBpbnQgZmluZF9kZmxzX2J5X2RlZmF1bHQoc3RydWN0IHBjaV9kZXYgKnBjaWRldiwNCj4g
Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYmFyID0gRklFTERfR0VUKEZNRV9QT1JUX09GU1RfQkFSX0lE
LCB2KTsNCj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZmZzZXQgPSBGSUVM
RF9HRVQoRk1FX1BPUlRfT0ZTVF9ERkhfT0ZTVCwgdik7DQo+ID4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChiYXIgPj0gUENJX1NURF9OVU1fQkFSUykgew0KPiA+Pj4+IElzIGJhciBz
ZXQgdG8gYSBiZXR0ZXIgbWFnaWMgbnVtYmVyIHRoYXQgcGNpX3N0ZF9udW1fYmFycyA/IG1heWJl
DQo+ID4+Pj4gMHhmZidzDQo+ID4+Pj4NCj4gPj4+PiBIb3cgZG8geW91IHRlbGwgYmV0d2VlbiB0
aGlzIGNhc2UgYW5kIGJyb2tlbiBodyA/DQo+ID4+PiBZZXMsIEkgYWdyZWUgdGhhdCBtYWdpYyBu
dW1iZXIgaXMgYmV0dGVyLCBDdXJyZW50bHkgdGhlIFJUTCB1c2luZw0KPiA+Pj4gUENJX1NURF9O
VU1fQkFSUyBmb3IgYW4gaW52YWxpZCBQQ0llIGJhciBudW1iZXIuDQo+ID4+DQo+ID4+IEhvdyBk
byB5b3UgdGVsbCBiZXR3ZWVuIHRoaXMgY2FzZSBhbmQgYnJva2VuIGh3ID8NCj4gPj4NCj4gPj4g
VG9tDQo+ID4NCj4gPiBUaGUgZmllbGQsIEZNRV9QT1JUX09GU1RfQkFSX0lELCBpcyBhIHRocmVl
IGJpdCBmaWVsZCwgd2hpY2ggaXMgcHJldHR5DQo+ID4gY29tbW9uIGZvciBCQVJzIG9uIFBDSS7C
oCBQQ0lfU1REX05VTV9CQVJTIGlzIGRlZmluZWQgYXMgNi4gQ3VycmVudCBIVw0KPiA+IGltcGxl
bWVudGF0aW9ucyBhcmUgZmlsaW5nIHRoaXMgZmllbGQgd2l0aCB0aGUgdmFsdWUsIDcsIHdoaWNo
IGlzDQo+ID4gY2xvc2UgdG8gdGhlIHN1Z2dlc3Rpb24gb2YgMHhmZidzLsKgIEhvdyBhYm91dCB3
ZSBkZWZpbmUgdGhlIGZvbGxvd2luZw0KPiA+IG1hZ2ljIG51bWJlcj8NCj4gPiAjZGVmaW5lIE5P
X0xPQ0FMX1BPUlRfQkFSwqDCoMKgIDcNCj4gPg0KPiA+IFdlIHNob3VsZCBhbHNvIGNoYW5nZSB0
aGUgZGV2X2luZm8gdG8gYmUgYSBkZXZfZGJnIGFuZCBtb3JlIHByZWNpc2UgdG8NCj4gPiBzb21l
dGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nOg0KPiA+DQo+ID4gwqDCoMKgwqBpZiAoYmFyID09IE5P
X0xPQ0FMX1BPUlRfQkFSKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqAgZGV2X2RiZygmcGNpZGV2LT5k
ZXYsICJObyBsb2NhbCBwb3J0IEJBUiBzcGFjZS5cbiIpOw0KPiA+IMKgwqDCoMKgwqDCoMKgIGNv
bnRpbnVlOw0KPiA+IMKgwqDCoMKgfQ0KPiANCj4gV2hhdCBJIGFtIGxvb2tpbmcgZm9yIGlzIHdh
eSBnZW5lcmFsbHkgaXMgdG8gdGVsbCBpZiB0aGlzIGlzIGFuIG9sZCBmcmFtZXdvcmsgb3IgYQ0K
PiBuZXcgb25lLg0KPiANCj4gTWF5YmUgYSBmbGFnIGFuZC9vciB2ZXJzaW9uIGFkZGVkIHRvIGRm
bF9mcGdhX2NkZXYgb24gcHJvYmluZyA/DQoNCkkgYW0gYWdyZWUgYWRkICIgZmVhdHVyZXMiIGlu
IGRmbF9mcGdhX2NkZXYgb24gcHJvYmluZywgZm9yIGV4YW1wbGU6DQoNCnN0cnVjdCBkZmxfZnBn
YV9jZGV2IHsNCiAgICAgICAgICAuLi4NCiAgICAgICAgICNkZWZpbmUgREZMX0ZFQVRfeHh4eCAo
MTw8MCkNCiAgICAgICAgICB1NjQgZmVhdHVyZXM7IA0KfTsNCg0KPiANCj4gKFRoZSBtZWFuaW5n
IG9mIHJlbGVhc2VkX3BvcnRfbnVtIGxpa2VseSBuZWVkcyB0byBjaGFuZ2UgdGhlcmUgYXMgd2Vs
bCkNCj4gDQo+IFNvIGluIHRoaXMgY2FzZSB5b3UgY291bGQgY2hlY2sgaWYgdGhpcyB3YXMgdGhl
IG5ldyBmcmFtZXdvcmsgYmVmb3JlIGRvaW5nIHRoZQ0KPiBiYXIgY2hlY2suDQo+IA0KPiBTaW1p
bGFyIGNoZWNrcyBvdGhlciBwbGFjZXMgd2hlcmUgb2ZzIHN0dWZmIGlzIGJlaW5nIGZpdCBpdC4N
Cj4gDQo+IE15IGNvbmNlcm4gaXMgdGhlIGZpdHRpbmcgaW4gd2l0aG91dCBjaGVja2luZyB3aWxs
IGJyZWFrIHRoZSBvbGQgc3R1ZmYuDQo+IA0KPiBBbmQgd2h5IEkgd2FudGVkIHRvIHNlZSBhIHBy
b2Jpbmcgd3JpdGV1cCBpbiB0aGUgZGZsLnJzdCBkb2MNCj4gDQo+IFRvbQ0KPiANCj4gPg0KPiA+
Pg0KPiA+Pj4+IE1vdmUgdXAgYSBsaW5lIGFuZCBza2lwIGdldHRpbmcgYW4gb2Zmc2V0IHRoYXQg
d2lsbCBub3QgYmUgdXNlZC4NCj4gPj4+IFllcywgdGhpcyBsaW5lIGlzIG5vdCBuZWNlc3Nhcnks
IEkgd2lsbCByZW1vdmUgaXQgb24gbmV4dCB2ZXJzaW9uDQo+ID4+PiBwYXRjaC4NCj4gPj4+DQo+
ID4+Pj4+ICsgZGV2X2luZm8oJnBjaWRldi0+ZGV2LCAic2tpcHBpbmcgcG9ydCB3aXRob3V0DQo+
ID4+Pj4gbG9jYWwgQkFSIHNwYWNlICVkXG4iLA0KPiA+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiYXIpOw0KPiA+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPiA+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
IGVsc2Ugew0KPiA+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9pbmZv
KCZwY2lkZXYtPmRldiwgIkJBUiAlZCBvZmZzZXQgJXVcbiIsDQo+ID4+Pj4gYmFyLCBvZmZzZXQp
Ow0KPiA+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RhcnQgPSBwY2lfcmVzb3VyY2Vfc3RhcnQocGNpZGV2LCBiYXIp
ICsgb2Zmc2V0Ow0KPiA+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxlbiA9IHBj
aV9yZXNvdXJjZV9sZW4ocGNpZGV2LCBiYXIpIC0gb2Zmc2V0Ow0KPiA+Pj4+Pg0KPiA+Pj4+IElz
IHNpbWlsYXIgbG9naWMgbmVlZGVkIGZvciBlbHNlLWlmIChwb3J0KSBibG9jayBiZWxvdyB0aGlz
ID8NCj4gPj4+IEkgdGhpbmssIHRoZSBlbHNlLWlmIGlzIG5vdCBuZWNlc3NhcnkuIEkgd2lsbCBy
ZW1vdmUgaXQgb24gbmV4dA0KPiA+Pj4gdmVyc2lvbiBwYXRjaC4NCj4gPj4+PiBUb20NCj4gPj4N
Cj4gPj4NCj4gPg0KDQo=
