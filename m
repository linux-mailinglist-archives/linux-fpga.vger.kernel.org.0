Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DA04BB3FE
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Feb 2022 09:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiBRIOl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Feb 2022 03:14:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiBRIOk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Feb 2022 03:14:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2656930F79;
        Fri, 18 Feb 2022 00:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645172063; x=1676708063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X5EimT4n81K0u7xfYUfScgRKEbt3kk3OgUINyZmLdTs=;
  b=QKEC3eVrvHCeWdE+ZSKaw38+3wLf92+4BrKjcvxmTYqzlkzpeUK9XILY
   GoWkPTbnpwl1Toz2rLzMXjmrdL617tko9tArtSTWloVBOo2yOTC+b6beQ
   foA9AFV6/ancJfZaZlw8xcb4YwodGtjE31hOIPCGMO2f2WflqW8G+0IpI
   7yfdmLULTMGMl+p1fok+fdJo4M+3FyIlbIjMu1WvviH7Mj2uaJvLejiPx
   d1tVjuoSybRtwJMSePD8JTzjRjhC39GUNh3VIshA50VlMKHQI5eyEURKp
   MJNKoDDwFgXgGeCvzHJk1Bfbid9D7uFLJ2L7mKF5QdOLP3DclY8YzyPco
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="248673485"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="248673485"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 00:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="546175668"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2022 00:14:22 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 00:14:22 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 00:14:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 00:14:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 00:14:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb03MStIYwDCIQoUw8KJ9RKJvyv/Ivhq3OhDXeT4Z4OYiqdTyGuccDUd7Qx0jQSMROHROhRf8X83vmSzCCpvBmEEiFODg8r94cjmz0ldb2vZaSCf6KlBzZ0bR3ODT0LJQnajObeClbOMrlei7dcUuWUjKi6fy3KRT6hWv4LnRsfRBijHEKeImlmY/bN/UinuFGcoD3XCB8OhYKJr7xLHTOzr+8CcxgJihmXjsUWwHM3JuTTpHBJ1WZ6/9l/Yp4yrEWioMB3xdIBMoRYSmtXnu5HzdPpg8JaBkpXZOIiVlsXWSbtzQhZWW0TGqnlv7Q5a7Pnjw5C6DDKvTNnWTTCL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5EimT4n81K0u7xfYUfScgRKEbt3kk3OgUINyZmLdTs=;
 b=Y3G3xbYzDlH8CzlRW3TFc+CbhVCnR95+Y1qceTIxHWt2I2Av/H/oRmXgRvL9XEF2y8y3xCNLV83/xm4KINAc4wYC5DhmzBCQPwmiXjgQCQcxhEt/NKptbIfAwVAQr0SZC1wdfKvXqIB1qgb9CATZMfx73oTTbawNVSOy4U3mOm24Wa6wcEvLUMZshD07jorFswajVoyYK0Ae8cSZk0phP08Oj5Z27MQATtfCw76p5lXPR4/mMD/s+kHz14riNICRj16WmmMpLha+4JxVb0ffMjGVEqNOv+xKqZvMh0tVaHok6jmL3j1Uvspd4Ww5BxXcCTJbxT9UR1bRaMR+pyKByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BN9PR11MB5449.namprd11.prod.outlook.com (2603:10b6:408:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 08:14:04 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.017; Fri, 18 Feb 2022
 08:14:04 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Tom Rix <trix@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1 4/7] fpga: dfl: fix VF creation when ports have no
 local BAR space
Thread-Topic: [PATCH v1 4/7] fpga: dfl: fix VF creation when ports have no
 local BAR space
Thread-Index: AQHYIZYxfZBUuJXX0Eut1corqhxoSqyUxGMAgAQsYbA=
Date:   Fri, 18 Feb 2022 08:14:04 +0000
Message-ID: <BN9PR11MB54830E0D185101B6B1517113E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-5-tianfei.zhang@intel.com>
 <c527e9c7-4588-463b-8a6b-3db68d003d7a@redhat.com>
In-Reply-To: <c527e9c7-4588-463b-8a6b-3db68d003d7a@redhat.com>
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
x-ms-office365-filtering-correlation-id: 97bb0013-4b62-4c23-533d-08d9f2b6a0a6
x-ms-traffictypediagnostic: BN9PR11MB5449:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB54491673B49246F2652E5D47E3379@BN9PR11MB5449.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYepusbY7mykHm1nNCUwMuOw6H1gFHRLtlv+jzTa3bo/JJCyZehzCg5S/Jh/J5UMltWmNCf/TlZupnYva0O60im1gyYks3JgDXfWPZtQbsAGcU/cehpmUiXBExI4391Kr+pdN+XJaEicVw8UnAKe55CwNhuLq2x5cKryJxscNK78gDB7XPn/sgJA2EXJYvCfTIx0nvLmIzs6kSX6ostdvhoE9+Jav2rh1tVURa2cN5J4FL58X4yAarzmlpGCWp5xHgXtfAtR/ayB5SYw4VldwqQ6DqyfGTc1GC2w8Afov4K5/DM9nUjDS2A3TAviIC44gO7l8sd1uk4o3RPoHw0Y5tdA/1dNRd0JLPOVtyvAiL3wb+c6YTLKdVbnJdFPHzMQeVQTMUgxTCwPS3VN7qRC2AulRcEylR4hOHEwD2OIvK0j6lmucVQqJpr3NWtm0KbaJybz5RWq/wa7divXi4u9SeS4uBh4oyTw/dvKphauGQBPTBV15JY1dZCBGyJjUEryqNd2Yn1rD/RFpLEIiQbJzyhdcDTHMGr869TN4YtDm7n0zvRFXD/oijLhZyXcavNFSEBcWU6rBjACmIxV8RD9sia5yuo19kSjwUpUp86EnKD2tCPnEUjYbyZpycgrZUKqu+Q+YVR4crZIwvjFkMOEcz9/U21ZAH8Y7mZr7ZEn83wlj1DsQ3xUlCOSgdvbN3SNjHrjIHtmBCPZfuJY0SHrlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66556008)(71200400001)(110136005)(8676002)(66946007)(8936002)(66476007)(53546011)(86362001)(9686003)(2906002)(26005)(6506007)(52536014)(7696005)(508600001)(55016003)(4326008)(83380400001)(5660300002)(33656002)(122000001)(82960400001)(186003)(38070700005)(76116006)(54906003)(38100700002)(316002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm1uVVpHbEtKbjZsR3lyTWhoczFMRG1ReVJFMjhnTlh6dGVPYnh0dkRISExz?=
 =?utf-8?B?NU9FYmY1N1RNUm8vNm1GR21zK3Y1WEVVQWYxWkdZNWRFMGNNRE1hT1JEZU01?=
 =?utf-8?B?WHhrb3RhL25hMWg2SmN2YmRrYU1PY2thMENrMkdhL3Z3QjZYOVdOeEsvNjJG?=
 =?utf-8?B?U2NBa1F4RE1nVEpFeE05OG5KeFBuKzlNZUI4QkVQQlBMYzdVMmRUNE1ETnNH?=
 =?utf-8?B?RTltTUtHa3l3eE5PM0JxQ2xONUE2bE5iUlJQdUc5UjhWbndTTW5HZ3R3dy9a?=
 =?utf-8?B?OGZ5Vzc1TkJOWHFLQ0ZHMGJhc04zNWpTNTNQYW1OMjRWT0hrUGhyWkcwZTkw?=
 =?utf-8?B?MWpjdWFXUU94VXR2alVXc2Z1ckdya3FndnVDMzY1dk9DcGpaQ0ZQMmN5WXlO?=
 =?utf-8?B?ZDlPemFpY2ZMRWdWdnplYVFvaGNUTlRYT3RpY1BNeWRYVkgzamNzclphcEVr?=
 =?utf-8?B?QStrRnZlVlZiZkRFUThwLzdxTWcxN3Y4Ry9NRHFVQXZqL2FSM1o3L25rTm8y?=
 =?utf-8?B?MFdHWGMvWlRxWis0dUJyT2Z2SEZIYzlnMjMzQWNaN2x5TFFMQkdiV2ZRcXA2?=
 =?utf-8?B?VVFONGJsWklPZWpyT3dHR0FLZ0xyVlBwQmJiL2JGcVlDcFNrMy92d1l2THdu?=
 =?utf-8?B?MXRidXlCMFg0U3NqNGJNY3RPYlNzTkF6R1JObktDb2s2UGVhU09Vck44WXF2?=
 =?utf-8?B?cWRPVlY3TVdNOS9UNjNrWkU3Zy9Bd0ZtVzEzRWJ2V21TaFRNNkQ4djJGaXdi?=
 =?utf-8?B?MGtqK3pYTExuRXV4dUI3WkJqRjAwWm9TSXdyOVBxcXl5ZWJNQWU0bGdhN0NN?=
 =?utf-8?B?eG44VENIL0tCUEgwVWp3ZXZpdzNpTlZsNzZkM0tCWmR6Tml6RnNmR2JsT0Y5?=
 =?utf-8?B?d2dVR3ViY0gydGNMR0RleWdqMXdkaHhjaVRmQ2lVbE42d1NvMnRBNS9wRmpH?=
 =?utf-8?B?bmRtdm4waHA3d21nVTdtUHE3TWMrQzJVS2ZONHRzYVZDc3E0dmpEcEVvRDFS?=
 =?utf-8?B?azJxdmR0YVlsUk5COHBmdWI0WVhMSW82SkxiemdwRWoxM3hzbjRaVWFtTytl?=
 =?utf-8?B?RXZlVDNML29SOGZsNk95UU1HemZ3UzdwLytRNFRhVzJhZCt6RTUvMlp5T3V1?=
 =?utf-8?B?RUpoR3B4eXNXWnljdjhsOHZzRStzcmZ3dFBvL1RmeHVMamJ1a29EMndLaVVO?=
 =?utf-8?B?Tk0yUWo2UlFUMCtSSnU4dnpkVjM1V1dBTnJzemwrdnlOUXdKVE1FTkNHTGRM?=
 =?utf-8?B?Rnk4bHlJVzZxdk5QT2p4cGF0cVRpa1lUQmV5YlVzb2ZYcThpNUdNWmxQd3lE?=
 =?utf-8?B?NEZNbURoSHUwdkVwTlhiVjRuNzkrTURYd2hBaWJpVWtTNmV6Q1RpeXFDL0RC?=
 =?utf-8?B?SGozSW1IZ0ZUZzZmeExnSEJNaVFsU1dQNnRYRE0rTlh2azlvVjNOZkVmbUZk?=
 =?utf-8?B?SVd5K3htdGNrc2ZHNmx1R2drbHI2Q1NEQWdHN29LZXJXdnRBWDFha3BVeTRk?=
 =?utf-8?B?Y0g2ZGtBQzhMZ3ZoZE5lMFRzQXc2YUc1eThXWkE1dXA1SHFpcnBYTjZhWjh5?=
 =?utf-8?B?MDNHVHpZM2lVem1KelY1dzFyMHhhcUs3SnNpYU9MVGNMZ3RaaVBySVBheS9Q?=
 =?utf-8?B?cDlSNEpHL1JOUzRydXU1a2VodFNzT0Vxa2k2Q245NGZCa3FVeHBMY0RMeVpF?=
 =?utf-8?B?bUpSTjN2clg4WEoyczZqOXJxblY1UE56THhYYlJrOTR3VE8zSU1oOXdMZFgy?=
 =?utf-8?B?T1JEL3pZekZUbkF1MWw3SDNIb3VGRmJVekhOUE5WbFlvL3hiUGVzb0xadGJr?=
 =?utf-8?B?TUROaFErRGF1UUxNbUd3bUxhdy9oYmFoN1h5L0MrTlJVakoxOCtJVHJUNHVS?=
 =?utf-8?B?azBhT0tjSG5hWk85bHBMdmFha0JuKzFsUjBlQzRnbkJ5czc3SU4zcERqeHha?=
 =?utf-8?B?S3krQUg3ck1zMjlnc0kybXN5U2F4TXZ1SVZHQktGcURYRXYyclJOKzBKSGJ5?=
 =?utf-8?B?SW5wYnVrNTJ1dUpMekxyakFvRytYb20ra3VoMSsyL0l1K082NVNiN3A5Mlh4?=
 =?utf-8?B?K3l3YmszZTVEOTBPR0hEcXR4T1dwZHcxTWpodklhdkVDRkNFUGRhR2dkZHJM?=
 =?utf-8?B?ZEJ1OE5ac0t2MFIyZG9DTkFvNkRWU0luWVZQR2RnZ1BUcVlKYUwvWkhMTUVW?=
 =?utf-8?Q?urVdC+/NEXfg0uAsyKr3ybE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bb0013-4b62-4c23-533d-08d9f2b6a0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 08:14:04.1610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UaepMPDCtFQuY6HjmwgADpybFa1IOBhfN6OFChp2rwJaZQBAlZGlRMvFyQF4Vd5oNCSp5ctRgC53QiETvHiZfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5449
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFJpeCA8dHJpeEBy
ZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNSwgMjAyMiAxMTo1MSBQTQ0K
PiBUbzogWmhhbmcsIFRpYW5mZWkgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPjsgV3UsIEhhbyA8
aGFvLnd1QGludGVsLmNvbT47DQo+IG1kZkBrZXJuZWwub3JnOyBYdSwgWWlsdW4gPHlpbHVuLnh1
QGludGVsLmNvbT47IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1kb2NAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBjb3JiZXRA
bHduLm5ldDsgTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDQvN10gZnBnYTogZGZsOiBmaXggVkYgY3JlYXRp
b24gd2hlbiBwb3J0cyBoYXZlIG5vIGxvY2FsDQo+IEJBUiBzcGFjZQ0KPiANCj4gDQo+IE9uIDIv
MTQvMjIgMzoyNiBBTSwgVGlhbmZlaSB6aGFuZyB3cm90ZToNCj4gPiBGcm9tOiBNYXR0aGV3IEdl
cmxhY2ggPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+ID4NCj4gPiBXaGVuIGEg
cG9ydCBpcyBub3QgY29ubmVjdGVkIHRvIHRoZSBzYW1lIFBDSWUgZW5kcG9pbnQgYXMgdGhlIEZN
RSwgdGhlDQo+ID4gcG9ydCBkb2VzIG5vdCBuZWVkIHRvIGJlIHJlbGVhc2VkIGJlZm9yZSBiZWlu
ZyB2aXJ0dWFsaXplZC4gIEZpeCBWRg0KPiA+IGNyZWF0aW9uIGNvZGUgdG8gaGFuZGxlIHRoaXMg
bmV3IHVzZQ0KPiBTaW1pbGFyLCBob3cgZG9lcyB0aGlzIGZpdCBpbiB3aXRoIGlvZnMsIHRoaXMg
bG9va3MgbGlrZSBpdCB3b3VsZCBub3QgYmUgdmFsaWQgZm9yIHRoZQ0KPiBleGlzdGluZyBjYXJk
cw0KDQpJT0ZTIGludHJvZHVjaW5nIG11bHRpcGxlIG1ldGhvZHMgZm9yIFBSIGFuZCBBRlUgYWNj
ZXNzLg0KMS4gTGVnYWN5IE1vZGVsLg0KMi4gTWljcm8tUGVyc29uYXMgaW4gQUZVLg0KMy4gTXVs
dGlwbGUgVkZzIHBlciBQUiBzbG90Lg0KDQpGb3IgMSBhbmQgMiBtb2RlbCwgdGhlcmUgYXJlIDE6
MSBtYXBwaW5nIGJldHdlZW4gUG9ydCBkZXZpY2UgYW5kIFBSIHNsb3QgKG9yIGVudGlyZSBBRlUp
LiBJbiB2aXJ0dWFsaXphdGlvbiwNCml0IHNob3VsZCByZWxlYXNlIHRoZSBQb3J0IGRldmljZSBm
aXJzdGx5IGFuZCB0aGVuIGFzc2lnbiB0byBWTS4gSW4gdGhpcyBtb2RlbHMsIHRoZSBERkwgZHJp
dmVyIHdpbGwgdHJhY2sgIHRoYXQNCnRoZSBudW1iZXIgb2YgcG9ydCBkZXZpY2VzIGhhcyByZWxl
YXNlZCAoY2Rldi0+cmVsZWFzZWRfcG9ydF9udW0gaW4gZGZsX2ZwZ2FfY2Rldl9jb25maWdfcG9y
dHNfdmYoKSBmdW5jdGlvbikNCmFyZSBlcXVhbCB3aXRoIHRoZSBudW1iZXJzIG9mIFNSSU9WIG9y
IG5vdC4gQnV0IGluIG1vZGVsIDMsIGl0IGhhcyBtdWx0aXBsZSBWRnMgcGVyIFBSIHNsb3QsIGFu
ZCBhc3NpZ24gdGhlIFZGIHRvIFZNIA0Kd2l0aG91dCByZWxlYXNlIHRoZSBwb3J0IGRldmljZSwg
c28gdGhlIHRyYWNraW5nIG1lY2hhbmlzbSBvZiBjZGV2LT5yZWxlYXNlZF9wb3J0X251bSBpcyBu
b3Qgd29ya2FibGUgb24gbmV3DQptb2RlbC4gVGhpcyBwYXRjaCB3YW50IHRvIGhhbmRsZSB0aGlz
IG5ldyBtb2RlbCBkdXJpbmcgVkYgY3JlYXRpb24uDQoNCj4gPiBjYXNlLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpYW5mZWkgWmhhbmcgPHRpYW5mZWkuemhhbmdAaW50
ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9mcGdhL2RmbC5jIHwgMTEgKysrKysrKysr
LS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC5jIGIvZHJpdmVycy9mcGdh
L2RmbC5jIGluZGV4DQo+ID4gMjZmOGNmODkwNzAwLi5jZmM1MzlhNjU2ZjAgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9mcGdhL2RmbC5jDQo+ID4gKysrIGIvZHJpdmVycy9mcGdhL2RmbC5jDQo+
ID4gQEAgLTE3MDUsMTUgKzE3MDUsMjIgQEANCj4gRVhQT1JUX1NZTUJPTF9HUEwoZGZsX2ZwZ2Ff
Y2Rldl9jb25maWdfcG9ydHNfcGYpOw0KPiA+ICAgaW50IGRmbF9mcGdhX2NkZXZfY29uZmlnX3Bv
cnRzX3ZmKHN0cnVjdCBkZmxfZnBnYV9jZGV2ICpjZGV2LCBpbnQgbnVtX3ZmcykNCj4gPiAgIHsN
Cj4gPiAgIAlzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGE7DQo+ID4gLQlp
bnQgcmV0ID0gMDsNCj4gPiArCWludCByZXQgPSAwLCBwb3J0X2NvdW50ID0gMDsNCj4gPg0KPiA+
ICAgCW11dGV4X2xvY2soJmNkZXYtPmxvY2spOw0KPiA+ICsNCj4gPiArCWxpc3RfZm9yX2VhY2hf
ZW50cnkocGRhdGEsICZjZGV2LT5wb3J0X2Rldl9saXN0LCBub2RlKSB7DQo+ID4gKwkJaWYgKHBk
YXRhLT5kZXYpDQo+IA0KPiBUaGlzIGxvb2tzIHdyb25nLA0KPiANCj4gcGRhdGEtPmRldiBpcyBk
ZXJlZmVyZW5jZWQgYmVsb3csIGlmIHRoZXJlIGlzIGEgY2FzZSB3ZXJlICghcGRhdGEtPmRldikN
Cj4gaGVyZSB0aGVyZSB3b3VsZCBiZSBjcmFzaCBsYXRlci4NCj4gDQo+ID4gKwkJCWNvbnRpbnVl
Ow0KPiA+ICsJCXBvcnRfY291bnQrKzsNCj4gDQo+IGhvdyBkb2VzIHRoaXMgd29yayB3aGVuIG9u
bHkgc29tZSBvZiB0aGUgcG9ydHMgYXJlIGhhbmRsZWQgaW4gdGhlIG5ldyB3YXkgPw0KDQpUaGlz
IGNvZGUgd2FudCB0byBoYW5kbGUgdGhlICIgTXVsdGlwbGUgVkZzIHBlciBQUiBzbG90IiBtb2Rl
bCBhcyBJIG1lbnRpb25lZCBhYm92ZS4NCkluIG5ldyBtb2RlbCwgdGhlIHBvcnRfY291bnQgd2Fu
dCB0byBjb3VudCB0aGF0IGhvdyBtYW55IHBvcnQgZGV2aWNlcyBoYXZlIHJlbGVhc2VkLg0KVGhp
cyBjb2RlIGxvb2tzIG5vdCBnb29kIHJlYWRhYmlsaXR5LCBJIHRyeSB0byByZS13cml0ZSBpdC4N
Cg0KPiANCj4gVG9tDQo+IA0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgIAkvKg0KPiA+ICAgCSAqIGNh
bid0IHR1cm4gbXVsdGlwbGUgcG9ydHMgaW50byAxIFZGIGRldmljZSwgb25seSAxIHBvcnQgZm9y
IDEgVkYNCj4gPiAgIAkgKiBkZXZpY2UsIHNvIGlmIHJlbGVhc2VkIHBvcnQgbnVtYmVyIGRvZXNu
J3QgbWF0Y2ggVkYgZGV2aWNlIG51bWJlciwNCj4gPiAgIAkgKiB0aGVuIHJlamVjdCB0aGUgcmVx
dWVzdCB3aXRoIC1FSU5WQUwgZXJyb3IgY29kZS4NCj4gPiAgIAkgKi8NCj4gPiAtCWlmIChjZGV2
LT5yZWxlYXNlZF9wb3J0X251bSAhPSBudW1fdmZzKSB7DQo+ID4gKwlpZiAocG9ydF9jb3VudCAm
JiBjZGV2LT5yZWxlYXNlZF9wb3J0X251bSAhPSBudW1fdmZzKSB7DQo+ID4gICAJCXJldCA9IC1F
SU5WQUw7DQo+ID4gICAJCWdvdG8gZG9uZTsNCj4gPiAgIAl9DQoNCg==
