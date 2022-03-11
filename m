Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3A4D5859
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Mar 2022 03:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiCKCro (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Mar 2022 21:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345764AbiCKCrm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Mar 2022 21:47:42 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590FE1A6366
        for <linux-fpga@vger.kernel.org>; Thu, 10 Mar 2022 18:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646966800; x=1678502800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XLVtmgAlptluEggneJ+2V5LyrIbPJa8qD5dwnjJYGec=;
  b=E5po8/DVHN89HjTNMHfuYIafI5DTDk6+jctROL5Fdqx6RllyNTu8kEGj
   pIU8ttXEDdKpvQp44lADWE2fSDbMIgko1hc3OwAcKLCj7x4DD0nTZAox0
   oAX76zS4ejTYB48aLyzRPezVhHY6wEXnBHQeKpFxddQiSb6WUn62zdI3u
   L2lS32RnyTyNFbDk46FuhiiLFNrcBmmCWTsZeQjjqITymyGSeOJ4WwVxh
   ifTKKSqVpZQD/nl/btHSg6sw1mbt4WlOnxM8/hEbf+H2MqfCvkIQXDrFr
   8NnANvDtg47sBysK7kyybQve37o/Cme8Bt/n+OFtzfbgBnR3FR9B3s39b
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255672879"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255672879"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 18:46:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="781726192"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 10 Mar 2022 18:46:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 18:46:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 10 Mar 2022 18:46:39 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 10 Mar 2022 18:46:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT31KU1zZYu7o1N9q/LoeA1RE1o+uhdVSlEJCJx7doYcSOOyd7KELLrowxQ6QNNb6PArcT50VDYw4THYtvPP216spgJXPzG5O84IyvfJP2UQ5XhSHVktOGFrWMGRqDsug6HkdKZTuKrnwHYkWb5SWgaZXBSydY2wER0GcCa/Ysu0hOnU7UC/hqDg8ystxYu14cYQBQutl5Ap/n6FYRHxTn+SQ8BSLxTa+dTni3RsbPByVEjVO5adUpz3HOv+tm+Xuaamu3XFP/8zxhIR2ciqkK7mXvKPSn4BrCAdLFuqf9VMD9zMGqGlTZLcYFk1phOOtvXBJ4+8Qlq9p5pZCLkT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLVtmgAlptluEggneJ+2V5LyrIbPJa8qD5dwnjJYGec=;
 b=m5A5HaxIVwGWTHFFPhZcfZ5L0pnZOI7mznRn+fRl2KisDf8Abm0u5k4gxkKFC0qjb4md+NnJZhWbUiCPPpHw89pkqdKVXGGJOJJibV4KJPjRgI7zdRNbpREp+F5l8Ni1s4H0WC+p3WSHdlnfoKY1gTMQCEvkBqPLNExJnjVxRIIBQqzL28BzgaJRpLnqgK5+iuCpHbuC891rXaBWTnNC+Zha+0koPB/7Kc9uZbCUIBa3RKA/JwbMiKezR/d671XqlhEjbd58nn60q5no9POARbS5uB4vvAJ6C7SL/fpLCzCyI+kMcQyi/atDJmpViYTsRAONEHAiOZjpyLBbWdkWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by MWHPR11MB1246.namprd11.prod.outlook.com (2603:10b6:300:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Fri, 11 Mar
 2022 02:46:36 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 02:46:36 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Xu, Yilun" <yilun.xu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Topic: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Index: AQHYNLWszaqWHWDC/E+0/e+KE1p1U6y5ZyLg
Date:   Fri, 11 Mar 2022 02:46:36 +0000
Message-ID: <DM6PR11MB3819A43505B9986593143C21850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220308064315.1452217-1-tianfei.zhang@intel.com>
 <03814133-4bb5-f8df-ed2a-fa94720c3075@intel.com>
In-Reply-To: <03814133-4bb5-f8df-ed2a-fa94720c3075@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9db141a-d075-4cae-2d3a-08da03095c58
x-ms-traffictypediagnostic: MWHPR11MB1246:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB12466968D2CDCDCCFF9A59DB850C9@MWHPR11MB1246.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPkAqLVpLuA27rOMAcoAVI2dO0chcb9tetrBT4fVtkn/IidSD2fN0xqIzNJUtU+VYwU4JaCG6wuuzsw5y7U+O4yuhcCp+yvhkn5mmxrWbHsgWnUd2llA3HM1d17FlC/+a7sqF19FhZmtEirOT+u2Axy7NB2/B8wGSgXLjqGJz3g04yVRy37Quz1e9Gf5vOgb693og8TL9G7c5LRloETQW+MFAuLAz4k/eDmEOp0jShl2rn4I/OloVqbBEHkwQjxLVfMNPjKk6g7fh7P6s2xyBcBGa1+uVhH3by8Vs941TDaqkavItE2ndwY2wT3SjHmTbyluyay7BRMhF0QkjaB8JnHvR+DeOL0+r0fY7OTuAC9hhOzsOvMTO97H8kx/32DB5XNM8KbePcjqvI/SnTLwTW6fALBAenUu46UOBAO91iavRdL/ZzoOhwdigNJCZzsbd67/Hm0fFf2JOKnkGC50YxwfPsseCp+wvlQo0pH9nC3T9MepAN7463ZTeuB+Sph1l1sb6PzRN7bmrIPciNDGZJhKXa9Ws0RnXB5b2Gha3KT6J2AdTGhd0Cg65Rb3aZtxe4tCzIIqimWxFkWxepnQmUnPBmKWvFmCOXb6hS8831GKQrrTSDOLl2dgB0wTACI0x1Pb/g6qABHi1N9vArRLpIbmvaOwp5f6Zb6VIwKVociTGOAo9X1//MsLsxe4c6lL0lXY43nE6HO+9j7dabx0VQP3A5AIR9u5VrcD+88GQ180yGqb02m4mZ8f+Dr5GL7H5aoJxloO6m+9/Of0/3tFglwv1a30ZQhqolm/L+5oFSk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(8676002)(4326008)(86362001)(33656002)(508600001)(9686003)(64756008)(38070700005)(7696005)(76116006)(66446008)(6506007)(53546011)(966005)(66946007)(316002)(52536014)(54906003)(122000001)(110136005)(8936002)(38100700002)(66476007)(5660300002)(71200400001)(55016003)(2906002)(82960400001)(26005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUVOdS9HUjhuSm1tK01kQjhXR2tqN010bkhHdWswbmlBWDY3QjdSYXQrN3BB?=
 =?utf-8?B?TC9SY28ydjFEd0ZReTF5RTlhZVN5RnVVa3REbW1EblFwNWFHZFJjbnNHNHZj?=
 =?utf-8?B?cXlXT1NWQXRDZDh1K2Z4eDNRR1Z6Q2NNZTFnMFhKT0FHS0cwZ3pTMzVMemVz?=
 =?utf-8?B?dVI2dm1CaW56bU5teDNlQmFZckEvQ2RNZUdnUjFkemFXM2lrT3JrVGFPSVlU?=
 =?utf-8?B?UUJoUTVMRS92ZndpQUtNbFZqVDQvMVRiK213Q2hkYjF0K2xjUXZLNlh1Tkdt?=
 =?utf-8?B?TnB1OXNIS0w1dXFwN092ZGE0SjlQUnp0blFNZjZTNGt5SWUydGw1d0g0R25C?=
 =?utf-8?B?ZDBPbERzVENsWFNyOEh4MHpVNlNCeXlYVGR6amNqaE9hQkJwQ1oxSTR4MzR4?=
 =?utf-8?B?QjcxNnJGdnN1N1I4MVltZ0tXMjZGMXlCSXJ6WktWcWxwVE1IdjUvdTB3WEcw?=
 =?utf-8?B?UjRDVmtHMHlraU9hK0hnQmozWTlZN1BaZmFjRWtxZ1hSSTByVzEvZkJNZTkw?=
 =?utf-8?B?clRaOWFCdWRVRTM2emw2cmlKUnpNd2tYdTV3R0FybWpoZG83K0RQUzY5bENB?=
 =?utf-8?B?NnVuYUFsRHFiYnFUTGFuNnlPbGQxOU1OTXptTGVLbllPR1NsTDVaeVNkWTRp?=
 =?utf-8?B?Zi9mVnF1ZkxqSEhreFBuTmVRcFo1MkNzWmNJSW11QVNFRDlBQUVMTnM0cEhx?=
 =?utf-8?B?cDhZa1VleU92QlZkZFBZN2NGanBDaTdEblZUR25LZlpiL0o0M3ZHRmtQNS9I?=
 =?utf-8?B?d0E3Vk96MmtWdFZubUZIdXluazNiMUNzdGhZTTlwRG5QcTZXTjJ6RFNSeTc2?=
 =?utf-8?B?RzAxOGJmbkxHdkVJZXlWN1UzSE1UUGFUMGRyVDY4ZWNLTmRsa3BMV2IrcUlY?=
 =?utf-8?B?UWRCZzZQblhPeE1zbUltTUdRTVNhQWl1SjVvWE1KUk5yWjlQZ3FsbUxJRlgz?=
 =?utf-8?B?cjVMZnB5SXlDNU90NC9lTWlIOFViNzRvZFgvMU5aV0krcERlZVhGSFU2Nk1s?=
 =?utf-8?B?dnVjV3pPK0o1WUZRK0Fydmg4Q2MrVno2TWpxY0E4MGZDK3o4aHRqZ2lXQjJn?=
 =?utf-8?B?UitWaVNDd0hPL3VsY3RlNGZDMnI4T2p1cHF3U0duL0FVN3VyQld6S1AyUGZz?=
 =?utf-8?B?S3Fid0hENk9Ya2RXTS9nZjdBKzRyeDFtMW1oVUVJYUVuRzdESTl0N2VuMTVS?=
 =?utf-8?B?MHc2dUs0OWZrZGJRWHVYREZqb1JJMUtBY2F2MmQ5c2hOSUpwRnpzY1l2NFlR?=
 =?utf-8?B?emlBYk11Vnh0TERnTnMxTW5ObDhhQ1ZLajFIbk1iZnBnWG5WZld3cTVOaGMy?=
 =?utf-8?B?WStVY3ZtZUZKbUFYUXZLSXNNR0VmekdnSWtZWElldWJRSDR1TEs4c05oYm41?=
 =?utf-8?B?T0tVZzZWZjJHQy9nNndIWTI2aDRQY3JoNWtGd0I0azZJNXpjMHZudUVaVzF4?=
 =?utf-8?B?YWdtejBkS0M3MzM3V1I3Q1JLUlh3SnpibkNSU0FuMzdzZ2tlTWhRWWdyL2tD?=
 =?utf-8?B?U1QrREJKejdoSUlDUzlvUzNUN3BSd0dTd2NXYzBwcGM0eURFcUVtYlo2c0FU?=
 =?utf-8?B?OGRycllVOTJybjh4V0tadHRyeHIrZVljS2YrYzZKemZXT1BrdElBcm1xUVZo?=
 =?utf-8?B?dmdEaXAxVWNteWtBYWhDM2pRMXNLemd6bS9OT1ZOV2xoY2E4aGd5YmRtM1Nw?=
 =?utf-8?B?NjMxNy9uYnRxVitEd2VNRkRrY2l6akYyTDlidE5JYVdjRTZhRjIyaXg3MFN4?=
 =?utf-8?B?V2pUNWlscnUyQVZUTk93TGFkUlYxMXk2M244U0x2eXovZW4zdHlxSFhpbnlR?=
 =?utf-8?B?K1RUOWdhQUs4ekhFQzNOZjlNKzdTOGJ0eXhjSXpxOXBlYnV0b2NpcVlyTnU4?=
 =?utf-8?B?TTNmbGxzSjBPbitOeGl5VkdIUEVHUVdDb0JQQ0lieUlPRUZIYjEydjNwTWxo?=
 =?utf-8?B?SE5JNHFDU3lGMzJHcDVlVTlkajJrY2xKbGl2YjhpZ0NUcG1VLzNZRlhjbkta?=
 =?utf-8?B?Tmd5UmdOQVVNb1NObjAvTkdLajg1cUI4cnZGVGVSZE5zalI0K0pzejVxZGxq?=
 =?utf-8?B?RDdGQVEzenJWWkRwN1p2dm5LdmdOa1pYNjN5OExhbW9PcnhYbkJ4WHJJS2ty?=
 =?utf-8?B?bzlWdGY2U0tPbEpGMExQVUxsZElvTjg3RTBUWjRpY0cvdVB2anNZazFvd2Vm?=
 =?utf-8?Q?gne5z2lwZPuKKTI5FhFofD0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9db141a-d075-4cae-2d3a-08da03095c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 02:46:36.4280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wo8QLlvGS+Qeu2dLjoe4vQImqd/cFL4quwTA9phyXC8wJ3Iuz0RdrAqtuypukQW20JcsK2wNq4ENqm8LiIz5uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1246
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiAzLzcvMjIgMjI6NDMsIFRpYW5mZWkgWmhhbmcgd3JvdGU6DQo+ID4gRnJvbTogTWF0dGhl
dyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29tPg0KPiA+DQo+ID4gQWRk
IHRoZSBmZWF0dXJlIGlkIG9mIHRoZSBPRlMgSGlnaCBTcGVlZCBTZXJpYWwgSW50ZXJmYWNlDQo+
ID4gc3Vic3lzdGVtIHRvIHRhYmxlIG9mIGlkcyBzdXBwb3J0ZWQgYnkgdGhlIHVpb19kZmwgZHJp
dmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3Lmdl
cmxhY2hAbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpYW5mZWkgWmhhbmcg
PHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFJ1c3MgV2VpZ2h0
IDxydXNzZWxsLmgud2VpZ2h0QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91aW8v
dWlvX2RmbC5jIHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91aW8vdWlvX2RmbC5jIGIvZHJpdmVycy91aW8v
dWlvX2RmbC5jDQo+ID4gaW5kZXggODljMGZjN2IwY2JjLi42NjBlMWQwYmY2YjkgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy91aW8vdWlvX2RmbC5jDQo+ID4gKysrIGIvZHJpdmVycy91aW8vdWlv
X2RmbC5jDQo+ID4gQEAgLTQ1LDkgKzQ1LDExIEBAIHN0YXRpYyBpbnQgdWlvX2RmbF9wcm9iZShz
dHJ1Y3QgZGZsX2RldmljZSAqZGRldikNCj4gPiAgfQ0KPiA+DQo+ID4gICNkZWZpbmUgRk1FX0ZF
QVRVUkVfSURfRVRIX0dST1VQCTB4MTANCj4gPiArI2RlZmluZSBGTUVfRkVBVFVSRV9JRF9PRlNf
SFNTSQkJMHgxNQ0KDQpXaGVyZSBpcyB0aGUgIk9GUyIgY29taW5nIGZyb20/IGlzIGl0IGZvciBh
bGwgT0ZTIGRldmljZSBvciBhIHNwZWNpZmljIGNhcmQ/DQpBbnl3YXksIGNvdWxkIHdlIGhhdmUg
YSBtYXRjaGVkIG5hbWUgcGVyIHB1YmxpYyB0YWJsZT8NCmh0dHBzOi8vZ2l0aHViLmNvbS9PUEFF
L2xpbnV4LWRmbC1mZWF0dXJlLWlkL2Jsb2IvbWFzdGVyL2RmbC1mZWF0dXJlLWlkcy5yc3QNCg0K
SGFvDQoNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRmbF9kZXZpY2VfaWQgdWlvX2Rm
bF9pZHNbXSA9IHsNCj4gPiAgCXsgRk1FX0lELCBGTUVfRkVBVFVSRV9JRF9FVEhfR1JPVVAgfSwN
Cj4gPiArCXsgRk1FX0lELCBGTUVfRkVBVFVSRV9JRF9PRlNfSFNTSSB9LA0KPiA+ICAJeyB9DQo+
ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUoZGZsLCB1aW9fZGZsX2lkcyk7DQoNCg==
