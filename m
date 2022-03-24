Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD04E5D6A
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Mar 2022 04:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiCXDES (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Mar 2022 23:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiCXDER (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Mar 2022 23:04:17 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8799549F;
        Wed, 23 Mar 2022 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648090966; x=1679626966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xjZ/+LvfG+JwWEjSnPiSpx33HcqNT6LdC86Um9lt8rU=;
  b=n3H5tcbRL2WfnoXNQhTjs7+NJS9XVSijW4QeAbZ3moZDcL6FEU3h1wv4
   DbCRB9cGBcWKXubR6NaxmDSgUBNmVF/UF0P72dj85ka4w3bW613ImeF+L
   YRQzZlK+7t2u8zaOsKX1KqoM10KU0LfOKbhBye4JOvywJZohaVqUuhfvM
   etcL43VXc6plY0DQW0OgKMIenzjPdw4Sxh8i8mtKD7jTSHY8xB5qveP08
   P7q1m8T1ME0KQyjQ81MBxw2pO9BVMZYJwd9+xTA73Uw+OvXx7T3T4j1mU
   ndY9uptZ57LGFKakfNuiY0KgUBg3rx2UPM8FbO8jUuxgIeJ3/PrMhUXp4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="318985868"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="318985868"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 20:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="519613207"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2022 20:02:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 23 Mar 2022 20:02:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 20:02:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Mar 2022 20:02:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 23 Mar 2022 20:02:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0xYawMOFFJqM+bQJ4xY085d30NXueFizoRNtDTTm5uIafe9ln34okIcywcEXTXk7qv7b59LVmZURT84YRPaL7TeyixgIpB2bwV+vEHb4A1do4bHAxLYkFSD+po5l7KXkYiMm4z7k87XjoLxgyEj4KR5jLoC08nrMP2Oz0lTX8A18VaiDI6Wpv5qKYDOo4XpZasXhvr2E1/U0C8GdmJUvc1QEDfUFWJ8/zeZ3rjb34Le+qUGCAWxC3CuMBz1PhWx2ewYerb0jLKEQBuXpfa/PSFtjPkAYDRSkA3/CCsoBXzdJWCXgYiPXJtfoQmAocvSXLwdgnXd6fZgSzhrh0Wt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjZ/+LvfG+JwWEjSnPiSpx33HcqNT6LdC86Um9lt8rU=;
 b=iTLJ8cml81+iHhW+1S84MAR1zMPRfKBDwuB4u6pvlRM5Y1k9+fjJ+kdl56eKXDG7jPu7Nby4H0CexavFgjqN5m63gNYZbZ7qAFH3pF2qpFZK9IiFsJpoBEAnbOTo9yBkURLAJ/t2diPKAJmIa6efqfI9y53EKjrFGEqAzfzI/RcGTjjt/SCXPWpEAFpBAtMy6O/8GlrCa/FLlNFz/kabRt6wHioIQsPSXtNmOaFp4ZIcDNi9UwHLLuJ/MsC4OT/dnp5cNNkkS4WbFUDVg3ZcHwZEIsPiIdY8DvWC1ylgyaDDoEYZ9AXU0BiZ/ddTbShJJNg/tWQu1Gciw94kX9mgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by DM6PR11MB3483.namprd11.prod.outlook.com (2603:10b6:5:e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Thu, 24 Mar 2022 03:02:40 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.5102.017; Thu, 24 Mar 2022
 03:02:39 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, "Wu, Hao" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: RE: [PATCH v5 2/2] Documentation: fpga: dfl: add description of
 Feature ID
Thread-Topic: [PATCH v5 2/2] Documentation: fpga: dfl: add description of
 Feature ID
Thread-Index: AQHYPpOihs+y3wofX0y8n1FHoTqE0qzM4U2AgADu5fA=
Date:   Thu, 24 Mar 2022 03:02:39 +0000
Message-ID: <BN9PR11MB5483E629582CC62526120773E3199@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220323085102.2297964-1-tianfei.zhang@intel.com>
 <20220323085102.2297964-3-tianfei.zhang@intel.com>
 <08baab49-e6da-31ac-612f-df3f462df7a3@gmail.com>
In-Reply-To: <08baab49-e6da-31ac-612f-df3f462df7a3@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17c532bc-723d-4cf2-8bde-08da0d42c1d8
x-ms-traffictypediagnostic: DM6PR11MB3483:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB348333F29BC04A11AFDFDD08E3199@DM6PR11MB3483.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IfV6S6ZPSAGLU8aZQIGl2y8a9E6GLslsup0VOxbnZp5uYi8L1LYJoddE39kDJmIGHDVdTgQcFd1tRBYWmLLeCxoxm4dXx3R4iVfyMXU1HcldHwRZEqlwPxS7AYeDGsgIguZfQFyrAnLMIET77564+fwoPELLruktcTdRCEymHDtgMVcxJuqa/qoE80W8yZIEdA9f+X8evhc7xKYE2GUEl+4VVfF6ACXEo5qmgtuveaPJ7Fo14tP0vn27XKRZmoQPhbOA0lrD+zbgASxZGvhWwiRvDAdZIQ8PJx68sdgei9BTRV9BFLmlikm7NgdjxQZYvEhivUwxqboQAFUWKnFFyjvceMMgQaQTM/zjRPy4PhYD4hTeuphsRIcQIW6v992YmNXtffzZ4TCAumCDPg5DDChIQRElHuCqHsVoFQzUPtXSBsn0roFZuWXDvVE7Eni+5JmFFHFOct2OHjY2NSHUKWkQ2sIXX/AMPzX6v0BukNRiX0ry2dL88vo1JCkSoHvtGRQ2347TFat7hMUK3wO7KibK64TOYPQRr19RlZ1qPhWGiIc2ze80Ba8ckBTHrngntz5UmmenCfZ7fh5BAmz/xYB78/47Lurzsy5AhHq36RRO/gJYSmf0GhQd53EyvZftFg6Pk8yxIRhZDqNqZiO2Wd0jBUizpfhjQlVZdP4EukIouGem/Hba+K4Ql0t20JKmTIvRcv0wlXer/UDi3uDTVqcLR2OSAhQlad1onUSVShy6DCa/x+Mo/jiCASuPVo8Vc2AUWUtS5KwoEpV+HU1hfPRtPkCV5iL+RCao3EmzNEB6ChoHpkfpASOsYNj2VM3e9vjS1/+zotZ0YPzvwNr5jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(55016003)(82960400001)(2906002)(5660300002)(8676002)(508600001)(83380400001)(54906003)(8936002)(4326008)(66556008)(76116006)(86362001)(66946007)(64756008)(66476007)(66446008)(9686003)(6506007)(52536014)(7696005)(110136005)(53546011)(71200400001)(33656002)(38070700005)(316002)(38100700002)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHV3UlZhQzREN2NPN00rU1Y4dUN6ZHR4VG5KNzFKTjJiMWtUYi80dW5nOFEv?=
 =?utf-8?B?czBSTUcrMzZmMk5Lbk5OenczVDJpVzlzZUZZUTEzQ2pyWDZCTXV0SEpVVWdy?=
 =?utf-8?B?amJlcGZnQTR4YlE2MnFweVkwR3hTczN4aWlYSHJiYjcrZkVYNTlSVHVHeklY?=
 =?utf-8?B?U1phdWQ2alhqU1ovY2JhNzZQN3dkd1A1dG90R3VEckg2NDNZdWFZcGJ5YzBv?=
 =?utf-8?B?bWh4Mmdra2dYbWlwOE5HNTRKVXVBNDY2NE1QSjVWYmN0R1QzTkpiTVhUTGZR?=
 =?utf-8?B?QnY4Z2JPanRvSEJXU1N1YXU3dlN3VTYwYkJGdUVEeDFmb1FRNEFMdkwrcU91?=
 =?utf-8?B?QUlOdk5iYTFJUWlVY3hrc1BnYXlGbGg4VGNjV0pCT0Q0d0U2eFZ1aFh1TkVm?=
 =?utf-8?B?SFRHZkVsRkJpOXllUk0wOHlkaFZicHlLRHlMd1kyNmg0bGhmYzU2YWFuZVNm?=
 =?utf-8?B?T0l2eHdGSm9SdnJSZnBZelNjOHRsWGhkd3NJb1pyWTdPaS9UL293cmhucTdM?=
 =?utf-8?B?TWsyK0NGcVhmTzhEQjhiQ29LNzlpRms4ZHV1ZXd6cm00WHFNMkx1NFV3aXZz?=
 =?utf-8?B?Tks2bGFUbWhMNFluNFYzRGRXQ2VvKzNGVUpSdUJOVWhvR2lub3AwRkpEK3Ay?=
 =?utf-8?B?MldxNlFaVVVqSmZ5NllwNjUvcDZrSGNsNmllV1k5K3NCMzlDRTB0MVF3bGhN?=
 =?utf-8?B?bGVzcXJPU3ZSdXNHZWlsWWZHVFhraU1NNWtrMkZMd3ZHa25tQVR1bm5vS1hG?=
 =?utf-8?B?ZEsrc2diQklIWWYrZERFTzdzVHBxT2pFYzVxbTduZ0tWK0tSMjhVVklGMXVS?=
 =?utf-8?B?ektodFlORTlPSU5WQ1Y0Y0VKOC9WaUVDQy9IL2I1eE15elBidlpPOFV2UDYx?=
 =?utf-8?B?eWFOdVFpczFEVWF3WCs4aE1OL2x0anVIOERsRGpKaTZ5ejAzWTZvMXpRUDdV?=
 =?utf-8?B?WGRuU290RlhXRjUvbjc3NDRzZytJTGdCMkhmUWMyaXdCWkJoS0lWQlFjTWsx?=
 =?utf-8?B?QnVoTjRxYW4rRHVKTFlPbE1qeXQxbS9DcE1JR2NLOE9ld054U2xYTXhqZnla?=
 =?utf-8?B?dFo5VWJUSVJwNnVsUWJrSCtQNksyOGMwOGZucm5xZFVMRW9rSWM4Q09pM1Zo?=
 =?utf-8?B?NjdoSjZqSFhWTnJtdXQ5K2NOckJJOWJGUnRPSGRBT2VBai9UM1ZCcEVGclZz?=
 =?utf-8?B?RWVKbjJwcVpoeHZQRjhhblYvcWRkTmNBcEVZYjhuNXRHbGtYZytQS3RXMWdL?=
 =?utf-8?B?UjVySHMyK3l0ZWZaS20wUjN6MTI1WjJLR3JGdEU2dWE2UFhjTDNBZTNGRzR4?=
 =?utf-8?B?OHgxREd5ZjRJUGk0RkxWUUtFdWo5M0NFeXFzTWx0M2pVMVJzaUxxa2FJMVNK?=
 =?utf-8?B?ZXkwR0c0cFV0ek92S3IxSHhKaHBibW1oNUhuTFlVRUphbk9KK1Q3WHM1WnUw?=
 =?utf-8?B?Skg3Smk0T2FDM0lXSnBWeDhPb2tpTU1Nbksxalh0R1VsNmhNQ2FDeHYrc25x?=
 =?utf-8?B?aVBERmpERGg2Rks1eVNyZWtSS2gzeHEvTHczM0puLzBoelp2TXJ6cmJEYUN4?=
 =?utf-8?B?K0VaYlhEY1hQbDBSOEFaMGk0OFBYanBkWTVlb1NjWHl4Vjh3VlIrVUw4T2t2?=
 =?utf-8?B?cmhETGJkbEt6OStHeVhVMnhBUlJQallXbmQyN214eXpFNG5TNWs1YS9Mbm56?=
 =?utf-8?B?UVd2Y05OUVp0M2xFU055b2lxNVU3QXhtSkpHV1JQRmpuendjb3NEdGtUVTRW?=
 =?utf-8?B?K3A0SnFaNDRjM2duZzJPcXBaM2h0UjMya0MwSXFBaERqTDcwbmtTK2Q3WTRV?=
 =?utf-8?B?TWE4SDlHZzNLc0dRUmNLTUk4Qm1iWFpobjVYY1RjRjFPcGVyL1E5Qkt3akNY?=
 =?utf-8?B?Q3RkZFY2N1RkcjJUMWdoSzVSaDhEWEJTYjdwSFJ0cGJlNk9KbVVURXFqeDhY?=
 =?utf-8?Q?5mg87+H5FeW89Nv3k0aboyMqc/levaHo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c532bc-723d-4cf2-8bde-08da0d42c1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 03:02:39.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: winofIgfDQ54T0jre627kUOwKGoDVYEGyeCDiLHnKMjG5vhMzWZIgxl7jwbS6rxV4GJmqJtd4ViYbOqtZrcX1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3483
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFnYXMgU2FuamF5YSA8
YmFnYXNkb3RtZUBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjMsIDIwMjIg
ODoxMiBQTQ0KPiBUbzogWmhhbmcsIFRpYW5mZWkgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPjsg
V3UsIEhhbyA8aGFvLnd1QGludGVsLmNvbT47DQo+IHRyaXhAcmVkaGF0LmNvbTsgbWRmQGtlcm5l
bC5vcmc7IFh1LCBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPjsgbGludXgtDQo+IGZwZ2FAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBjb3JiZXRAbHdu
Lm5ldDsgcmR1bmxhcEBpbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi8y
XSBEb2N1bWVudGF0aW9uOiBmcGdhOiBkZmw6IGFkZCBkZXNjcmlwdGlvbiBvZg0KPiBGZWF0dXJl
IElEDQo+IA0KPiBPbiAyMy8wMy8yMiAxNS41MSwgVGlhbmZlaSBaaGFuZyB3cm90ZToNCj4gPiAr
SW5kaXZpZHVhbCBERkwgZHJpdmVycyBhcmUgYm91bmQgREZMIGRldmljZXMgYmFzZWQgb24gRmVh
dHVyZSBUeXBlIGFuZA0KPiBGZWF0dXJlIElELg0KPiA+ICtUaGUgZGVmaW5pdGlvbiBvZiBGZWF0
dXJlIFR5cGUgYW5kIEZlYXR1cmUgSUQgY2FuIGJlIGZvdW5kOg0KPiA+ICsNCj4gPiAraHR0cHM6
Ly9naXRodWIuY29tL09QQUUvbGludXgtZGZsLWZlYXR1cmUtaWQvYmxvYi9tYXN0ZXIvZGZsLWZl
YXR1cmUtDQo+ID4gK2lkcy5yc3QNCj4gPiArDQo+IA0KPiBUaGlzIGRvZXNuJ3QgYW5zd2VyICJX
aGF0IGlzIEZlYXR1cmUgVHlwZSBhbmQgRmVhdHVyZSBJRD8iIHF1ZXN0aW9uLg0KPiBJIHdvdWxk
IGxpa2UgdG8gc2VlIHRoZSBhbnN3ZXIgYW5kIHRoZSBmZWF0dXJlIGxpc3QgYWJvdmUgaW4gdGhl
IGtlcm5lbA0KPiBkb2N1bWVudGF0aW9uLg0KDQpGZWF0dXJlIFR5cGUgaXMgdGhlIGRldmljZSB0
eXBlIG9mIGZlYXR1cmUgZGV2aWNlLCBjdXJyZW50bHksIHdlIG9ubHkgc3VwcG9ydCBGTUUgZGV2
aWNlIGFuZCBQb3J0IGRldmljZSBub3cuDQpGZWF0dXJlIElEIG1lYW5zIHRoZSBJRCBvZiBmZWF0
dXJlIGRldmljZS4gSW5kaXZpZHVhbCBERkwgZHJpdmVycyBhcmUgYm91bmQgREZMIGRldmljZXMg
YmFzZWQgb24gRmVhdHVyZSBUeXBlIGFuZCBGZWF0dXJlIElEDQphZnRlciBERkwgZW51bWVyYXRp
b24uIEkgdGhpbmsgdGhvc2UgZGV0YWlsIGluZm9ybWF0aW9uIGFyZSBpbiBERkwgc3BlY2lmaWNh
dGlvbiwgYW5kIGl0IGRvbid0IG5lZWQgcHV0IGV2ZXJ5dGhpbmcgaW4ga2VybmVsIGRvY3VtZW50
YXRpb24uDQpBbmQgSSB0aGluayB0aGUgZmVhdHVyZSBsaXN0IG1haW50YWlucyBieSBhbiBleHRy
YSBnaXQgcmVwb3NpdG9yeSB3aWxsIGJlIGJldHRlciwgYW5kIHRoZSB1c2VycyB3YW50IHRvIGFk
ZCBhIG5ldyBmZWF0dXJlIElEIG11c3QNCnN1Ym1pdCBhIHB1bGwgcmVxdWVzdCBmb3IgdGhpcyBy
ZXBvIHRvIHJlZ2lzdGVyIHRoZSBuZXcgSUQuDQoNCj4gDQo+ID4gK0lmIHlvdSB3YW50IHRvIGFk
ZCBhIG5ldyBmZWF0dXJlIElEIGZvciBGUEdBIERGTCBmZWF0dXJlIGRldmljZSwgeW91DQo+ID4g
K211c3Qgc3VibWl0IGEgcHVsbCByZXF1ZXN0IHRvIHJlZ2lzdGVyIGEgZmVhdHVyZSBJRCBmb3Ig
REZMLiBIZXJlIGlzIHRoZSBERkwNCj4gRmVhdHVyZSBJRCBSZWdpc3RyeToNCj4gPiArDQo+ID4g
K2h0dHBzOi8vZ2l0aHViLmNvbS9PUEFFL2xpbnV4LWRmbC1mZWF0dXJlLWlkDQo+ID4gKw0KPiAN
Cj4gUGxlYXNlIGV4cGxhaW4sIGluIHRoaXMgZG9jdW1lbnQsIHRoZSBQUiBwcm9jZWR1cmUgcmVn
YXJkaW5nIGZlYXR1cmUgSUQNCj4gcmVnaXN0cmF0aW9uLg0KDQpJbiB0aGlzIGRvY3VtZW50YXRp
b24sIGl0IGhhcyBhIGNoYXB0ZXIgdGFsayBhYm91dCB0aGUgUFIsIHBscyBzZWUgdGhlICIgUGFy
dGlhbCBSZWNvbmZpZ3VyYXRpb24iIGNoYXB0ZXIuDQpPbiBERkwgcGVyc3BlY3RpdmUsIFBSIGlz
IGEgRk1FIHByaXZhdGUgZmVhdHVyZSBkZXZpY2UsIHRoZSBGZWF0dXJlIFR5cGUgaXMgIjAiICgw
IG1lYW5zIEZNRSksIHRoZSBmZWF0dXJlIElEIGlzIDB4NS4NCkZNRSBQYXJ0aWFsIFJlY29uZmln
dXJhdGlvbiBTdWIgRmVhdHVyZSBkcml2ZXIgKHNlZSBkcml2ZXJzL2ZwZ2EvZGZsLWZtZS1wci5j
KSB3aWxsIGJlIGJvdW5kIGlmIGl0IGZvdW5kIGEgDQpQUiBwcml2YXRlIGZlYXR1cmUgZGV2aWNl
IGFmdGVyIERGTCBlbnVtZXJhdGlvbi4NCg0KPiANCj4gLS0NCj4gQW4gb2xkIG1hbiBkb2xsLi4u
IGp1c3Qgd2hhdCBJIGFsd2F5cyB3YW50ZWQhIC0gQ2xhcmENCg==
