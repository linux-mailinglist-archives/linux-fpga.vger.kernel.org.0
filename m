Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47683D8576
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Jul 2021 03:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhG1BhB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 21:37:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:59324 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234095AbhG1BhA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 21:37:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="276345695"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="276345695"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 18:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="566714769"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 27 Jul 2021 18:36:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 27 Jul 2021 18:36:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 27 Jul 2021 18:36:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 18:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPDdBnEo4XqVACGTY2BmjbyeuY4S9cDEpY6DiSAsvePm30WGy+AhwbTnHnxa5eGy1gM2zLSS/1VaMyR1yum54Th9G+HR1WR/U+7LSclPHeEAgC2UJom9iko9WplCNPWWOIBljTxwrVkrc1zKAdwzpL3+7DiBX/Czi1MxOtWtLVQPTNBoiow0X6dxSPxsE/R87ed7Z0+YB7OdzgSAf+g0nXNJxMvP/caCiFq83I4GeXOsHqtn/3kTuds2RGGAPAFkibVBEiTU0oNNl8Y0SIwnYun9pLtOucQOEeLFz0qW7sDcu63dOSNwnLIS+mD45sYV4fHh0dC2Hy2BN2Ll9gaf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gW5tCi5OXgHpc9FTF3U1MtY/+NHt4nNbqZ+CcVjU7U=;
 b=FI55Y4WbY64+vsfj/WGF/8c+QBXZWde3tsRlSMDyqZ/ZR36vuN+CCNkuKlZ0NerBawmyc/ojl2XQYRvp+HcQRvsn6bBIeY9R0FPgWBMoZgesgsRPf1jx6DAuxr8gYbMuPdQs/jKv70kagWnQw5sjDh9Jba5BOZUPO5rvsqlUZ4vrNCYJntgAfNdPLImqrcZouQARvpf8Qq4z6iVKSzNQtyHmYBvMSemvIg6dvzpo//x8eOEJ0hD1tRBKV14anGeQb6pXYKSVCMxihHfIDDTG0tznh7ECVibbI0ZuVNVGHwX63Y/SHKpiZiMc+m9fZKc8qWL0TyVtlwg4KXqlQK4JTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gW5tCi5OXgHpc9FTF3U1MtY/+NHt4nNbqZ+CcVjU7U=;
 b=osn65OhkHTvgUkPofAQ3UvQJV7UTLnZe/j7zT3L9VtmwPmStcE6GZeQdaQwH5TeK/siBobxabzObQ1TSGnifaZ8Q/LXym8lmZabWoajm6W5XMyU3uZGFtuu6UA99WH4zoWuxxdA4VzqYtEADsyj7d87dntDdOxRCnfsQZoa5kEM=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.29; Wed, 28 Jul 2021 01:36:56 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4308.031; Wed, 28 Jul 2021
 01:36:56 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Tom Rix <trix@redhat.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH] fpga: region: handle compat_id as an uuid
Thread-Topic: [PATCH] fpga: region: handle compat_id as an uuid
Thread-Index: AQHXgny44yJ7Zie1xkeUVpcMLc1q9atXmuaA
Date:   Wed, 28 Jul 2021 01:36:56 +0000
Message-ID: <DM6PR11MB38199F872DC94971D9C8A53885EA9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210726202650.4074614-1-trix@redhat.com>
 <6f30a4c6-61a0-bb57-9f13-bcad3f3589b8@intel.com>
 <ba28bac6-9c6d-de73-523f-b8ba4bef84de@redhat.com>
In-Reply-To: <ba28bac6-9c6d-de73-523f-b8ba4bef84de@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 845bb7d5-c06e-4e50-d4c9-08d951682f9b
x-ms-traffictypediagnostic: DM6PR11MB3180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB31807F8230C5272BC24D021F85EA9@DM6PR11MB3180.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5u0aCsvTw85qpEZQnUFWsK6E68VQ7Ci94L/kHucsHE4a8jvVXJiRTm+7VPhqgl+dX3gFWKj6Uu6gBtMi1vpTKYl2y+TX8sIRN5lXRBblN8zBZPMx7s7mARzO6w9Yy+1oueSXLzJdtVD+AkevJV22NnFyf6xoEUuiwx7RVsp3rjlvkweMRLCbJ8D6f+BewPpi+JoHLXxb7kQ4Jg9yOJ4OajYD+7gHbHK/YUwobww+w95mK0SErLlvZS/dlk9ajR8zjztaLUNmzv2/zkG4J0pgQPT+slHu0DENa9vT3zEaSvTLiSbMp7RhmPPKzV1gJnASEzQDwUtsFlTLDPmdonf4pPlH5H3MWlraSXMcUnLbAt5xp2V/MO8xp4ahXEzAuUnbXJW8EFkqCscNQycR+cpLrl7kDnI1Vs3wMSVK1Wwzwc+Xe8CHHTJh1+6nPiYpr+l3o+DusXHiaLVNL1KbuUqDXdWORIHWF1UKXLCukpQ2UsQaZHy837jzwowNaq+MwexoBF4Oi11+3CZGTQswJ9ALvbIPj3jOgwZIeiwg8ggs45L9dHld3WYziNhzU/wANZ5kvkaf867WV/aTSWgYM7u4hpnAU4AgHXvAU5F906dA3RZ9/FMW3b344dw3o4/t/H62kU9LsdBbAlETl9RtjJk4Kv0qLEa7lsmKbXPgFA2sYtXaDBzk1PjoGoFFxyMfRMnviCSTnjvOI0kitMSVDMhnnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(54906003)(5660300002)(110136005)(53546011)(71200400001)(33656002)(52536014)(86362001)(8936002)(7696005)(38100700002)(6506007)(64756008)(66946007)(66556008)(66446008)(316002)(76116006)(66476007)(122000001)(186003)(2906002)(478600001)(83380400001)(55016002)(26005)(9686003)(8676002)(4326008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWtxb0o1aDFzUFM1NlV4cEZUeTRNcjZXZGpyaTVMMEJHSlRHOFFMeDNUU0k3?=
 =?utf-8?B?UU42TlUrM0hZMjNCS29xSjZha3p1V3VEVWNYa01Zb1Z2NWVNUkdaZERWYmxy?=
 =?utf-8?B?NUM3dmVyaTJVd2tNSHB5aDlRcTZyRUhtY0U2bjV1N0diVDBQdmpVb3FVUXVq?=
 =?utf-8?B?S3ViWVEvOHBldlU5bzR0OHlJa1UxbzZDL2x4R2JkQm5lRE1idDIvaTB2ZHNt?=
 =?utf-8?B?TU1BYXVjdTJCUXlKMjRGYjRmd3VKUGNROUhmcWp6WGRDV0hHem0ra3dmMUVK?=
 =?utf-8?B?djNoblA5S3BVQ29pMk82WXh0K21ZTkx3NzZES1dBM2RuMlZ3akhnZG9YQTQx?=
 =?utf-8?B?ZW91UWp2cjc3ZmVLdFdhTFViN2g0TVppb0ExckZ3RXZHcVlybFdDems2TjRx?=
 =?utf-8?B?WWE0bURQMzh2YzArWFRYcDRGUUNCWHRHbUNtUGxodUlPOCtBelprb2UxOERv?=
 =?utf-8?B?WXN3YWdpdTlRYktYNmZKY0dXWDZuMG0rQVdkdE9aTG94L29WTVFQbTUzRi9h?=
 =?utf-8?B?VVhaMXRwSzhGZjZzS3B1dmhoKy9wbkI2UHJoK0xUNWpjemNYRm5vU3VsdGMr?=
 =?utf-8?B?bDJxc3FiczJLUXhnTFlLako2bFowbzJkczRzOXc2d25DWnc3S3JkVmJvZEhS?=
 =?utf-8?B?YTBlNTRFVm9rRjlZZGlBMXJtbk1NWFRXaHBjWm5TVER6RFVFTUtIaFdEVXlu?=
 =?utf-8?B?YWZvSjJHRFJONEZiZVFDZGVsMTZ6eVM3dXdEMGNZUXNKZFFVTEd3MjhmT0tk?=
 =?utf-8?B?ZUMydnYyV04yelE0OE1KYUFESk5vTTZsa2VKeFVOK2JNZUkxTU1xemVLZWRX?=
 =?utf-8?B?VDBRQkZJNnZkZ3B1VWVpcnlscFgvR0pOVHVsMnVBYldIT21ZWVV1VnhmNzI1?=
 =?utf-8?B?d0RSU0Z3SnhJdGJmQVlLdzdJMS91bFJIREp6MkEzM29iUVV6YjBSdFdVdFZO?=
 =?utf-8?B?bXRhbnZiQlJXWC9KSlBuT1k1M0hsZHZ1UkNKVlpIdjFpYnRJWWkyT0JNanRB?=
 =?utf-8?B?WmV0UjRRNkdqOU9XL1FYb0ZsYkNsNWdwK3pCWWlzKzZsSy9oOHQzb01XTFZH?=
 =?utf-8?B?WU5MRjk5NHNCSlIrd1djR3ZwSGJkVzEvWHk0VEhaZXppd050V2JBSVRHbDdy?=
 =?utf-8?B?QWZPcmhORWswU1UxYmZzZjFEc3FYa3laUU9qT3dpVk9xYThKVE1hWGlQUEwv?=
 =?utf-8?B?QnlaelV6aFNHWFQrS1lTWkZmYUkwVU1xRzYrMGJucGx5cGhydkxYTWhpRUVD?=
 =?utf-8?B?VXhXRnFUTUcyRGVnRmw2TVBIWFpwMDVMd0VOQkt6V0tDRy9YZDFkWEFYTUx5?=
 =?utf-8?B?MkFzN3A0bjBCSEFpK3Y1M25DRlZwaUt6dWFGU0hZUERsTFhab0pUS1RIbEtY?=
 =?utf-8?B?ZEJCSGlPQmtwM2RucHdqMExxSmdta3Z4ZmJPR2J2WkpLOGZYRHFDODhsZkQz?=
 =?utf-8?B?dVNrdUwyRGF6Q2pnYjFENUZ1T2p4L3RLeExUeEJZTkIyUzA3eHJ4NHZCZS8r?=
 =?utf-8?B?YU5BV2JuaVl2Q3pYdnJ5VUFGcVJLVlZUY3gyRlY0dXJEMVoyUjRNNHRZdldC?=
 =?utf-8?B?R2NpTE5ReVMzdDFyZk9JNHZBTUN1RVNxTkxCR1JneGIyZmFGeU5VR05NSHN4?=
 =?utf-8?B?YmxlVThWNmM4NUJFRlhoMHNSSGhVSnVVeFlRT2FLOEZYY0pWaUxYbTJVR1Fw?=
 =?utf-8?B?ZnFPbDEyOHcrSzRhVXBOUlhhNjJ6ZCtnM1M2WUp4a0pQYklwYXBPZ0RKK0NQ?=
 =?utf-8?Q?SfqnDGiKfN91CczUYR1foxzxxqdCEJIWVHMDpcc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845bb7d5-c06e-4e50-d4c9-08d951682f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 01:36:56.5367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlKbuv7GKWBlgaloagsmo5G3WzIHoGRPvxB2+S9M9QwRscAIqKPZwekVxPqdil4Y4xw3dMyqbqUef56iiXIyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3180
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiA3LzI2LzIxIDM6MTIgUE0sIFJ1c3MgV2VpZ2h0IHdyb3RlOg0KPiA+IE9uIDcvMjYvMjEg
MToyNiBQTSwgdHJpeEByZWRoYXQuY29tIHdyb3RlOg0KPiA+PiBGcm9tOiBUb20gUml4IDx0cml4
QHJlZGhhdC5jb20+DQo+ID4+DQo+ID4+IEFuIGZwZ2EgcmVnaW9uJ3MgY29tcGF0X2lkIGlzIGV4
cG9ydGVkIGJ5IHRoZSBzeXNmcw0KPiA+PiBhcyBhIDEyOCBiaXQgaGV4IHN0cmluZyBmb3JtZWQg
YnkgY29uY2F0ZW5hdGluZyB0d28NCj4gPj4gNjQgYml0IHZhbHVlcyB0b2dldGhlci4NCj4gPj4N
Cj4gPj4gVGhlIG9ubHkgdXNlciBvZiBjb21wYXRfaWQgaXMgZGZsLiAgSXRzIHVzZXIgbGlicmFy
eQ0KPiA+PiBvcGFlIGNvbnZlcnRzIHRoaXMgdmFsdWUgaW50byBhIHV1aWQuDQo+ID4+DQo+ID4+
IGV4Lw0KPiA+PiAkIGNhdCAvc3lzL2NsYXNzL2ZwZ2FfcmVnaW9uL3JlZ2lvbjEvY29tcGF0X2lk
DQo+ID4+IGYzYzk5NDEzNTA4MTRhYWRiY2VkMDdlYjg0YTZkMGJiDQo+ID4+DQo+ID4+IElzIHJl
cG9ydGVkIGFzDQo+ID4+ICQgZnBnYWluZm8gYm1jDQo+ID4+IC4uLg0KPiA+PiBQciBJbnRlcmZh
Y2UgSWQgICAgICAgICAgICAgICAgICA6IGYzYzk5NDEzLTUwODEtNGFhZC1iY2VkLTA3ZWI4NGE2
ZDBiYg0KPiA+Pg0KPiA+PiBTdG9yaW5nIGEgdXVpZCBhcyAyIDY0IGJpdCB2YWx1ZXMgaXMgdmVu
ZG9yIHNwZWNpZmljLg0KPiA+PiBBbmQgY29uY2F0ZW5hdGluZyB0aGVtIHRvZ2V0aGVyIGlzIHZl
bmRvciBzcGVjaWZpYy4NCj4gPj4NCj4gPj4gSXQgaXMgYmV0dGVyIHRvIHN0b3JlIGFuZCBwcmlu
dCBvdXQgYXMgYSB2ZW5kb3IgbmV1dHJhbCB1dWlkLg0KPiA+Pg0KPiA+PiBDaGFuZ2UgZnBnYV9j
b21wYXRfaWQgZnJvbSBhIHN0cnVjdCB0byBhIHVuaW9uLg0KPiA+PiBLZWVwIHRoZSBvbGQgNjQg
Yml0IHZhbHVlcyBmb3IgZGZsLg0KPiA+PiBTeXNmcyBvdXRwdXQgaXMgbm93DQo+ID4+IGYzYzk5
NDEzLTUwODEtNGFhZC1iY2VkLTA3ZWI4NGE2ZDBiYg0KPiA+IEknbSBmb3dhcmRpbmcgZmVlZGJh
Y2sgZnJvbSBUaW0gV2hpc29uYW50LCBvbmUgb2YgdGhlIE9QQUUgdXNlcnNwYWNlDQo+ID4gZGV2
ZWxvcGVyczoNCj4gPg0KPiA+IEkgdGhpbmsgdGhhdCB0aGlzIGNoYW5nZSB0byB0aGUgc3lzZnMg
Zm9yIHRoZSBjb21wYXRfaWQgbm9kZSB3aWxsDQo+ID4gZW5kIHVwIGJyZWFraW5nIHRoZSBTREss
IHdoaWNoIGRvZXMgbm90IGV4cGVjdCB0aGUgJy0nIGNoYXJhY3RlcnMgdG8NCj4gPiBiZSBpbmNs
dWRlZCB3aGVuIHBhcnNpbmcgdGhlIHN5c2ZzIHZhbHVlLiBDdXJyZW50bHksIGl0IGlzIHBhcnNl
ZCBhcw0KPiA+IGEgcmF3IGhleCBzdHJpbmcgd2l0aG91dCByZWdhcmQgdG8gYW55ICctJyBjaGFy
YWN0ZXJzLiBUaGlzIGdvZXMgZm9yDQo+ID4gYW55ICJndWlkIiBjdXJyZW50bHkgZXhwb3J0ZWQg
Ynkgc3lzZnMgYW5kIGZvciB3aGF0IHdlIHJlYWQgaW4gdGhlDQo+ID4gZGV2aWNlIE1NSU8gc3Bh
Y2UuDQo+IA0KPiBZZXMsIGl0IHdpbGwuDQo+IA0KPiBBbmQgdGhlcmUgYXJlIG90aGVyIHBsYWNl
cywgbGlrZSBkZmwtYWZ1LW1haW4uYzphZnVfaWRfc2hvdygpDQo+IA0KPiBvdXRwdXRzIHJhdyBo
ZXggdGhhdCBzZGsgdHVybnMgaW50byBhIHV1aWQuDQo+IA0KPiANCj4gU29tZSBvcHRpb25zLg0K
PiANCj4gSWYgbm8gb25lIGJ1dCBkZmwgd2lsbCBldmVyIHVzZSBpdCwgdGhlbiB2MSBvZiBwYXRj
aHNldC4NCj4gDQo+IElmIG90aGVycyBjYW4gdXNlIGl0IGJ1dCBkb24ndCB3YW50IHRvIGNoYW5n
ZSBkZmwsIHRoZW4gdjIgb2YgcGF0Y2hzZXQsDQo+IG15IGZhdm9yaXRlLg0KPiANCj4gT3IgdGhp
cyBvbmUgZm9yIHV1aWQgZm9yIGV2ZXJ5b25lLCB3aGF0IGhhdmUgYmVlbiB2MyBidXQgY2hhbmdl
ZCB0b28gbXVjaC4NCj4gDQo+IA0KPiBjb3VsZCBkZmwgY2hhbmdlIGdlbmVyYWxseSB0byBvdXRw
dXQgdXVpZCdzIHRvIHRoZSBzeXNmcyA/DQo+IA0KPiB0aGlzIHdvdWxkIGJlIGdlbmVyYWxseSBo
ZWxwZnVsIGFuZCBhIG9uZSB0aW1lIGRpc3J1cHRpb24gdG8gdGhlIHNkay4NCg0KVGhpcyBjaGFu
Z2UgbGltaXRlZCB0aGUgb3V0cHV0IGZvcm1hdCB0byB1dWlkX3QsIGJ1dCBpZiBhbnkgaGFyZHdh
cmUgZG9lc24ndA0KdXNlIHV1aWRfdCBvbiBoYXJkd2FyZSBtYXkgaGF2ZSB0byBjb252ZXJ0IGl0
IGJhY2sgZnJvbSB0aGUgc3lzZnMgb3V0cHV0IGluDQp1c2Vyc3BhY2UuIExlYXZlIGl0IHRvIHBy
aW50IGhhcmR3YXJlIHZhbHVlcyAoZS5nLiBmcm9tIHJlZ2lzdGVyKSwgYW5kIGNvbnZlcnQNCml0
IGluIHVzZXJzcGFjZSBzaG91bGQgYmUgZmluZSB0b28gSSB0aGluay4NCg0KVGhhbmtzDQpIYW8N
Cg0KPiANCj4gVG9tDQo+IA0KPiA+DQo+ID4gLSBSdXNzDQo+ID4NCj4gPj4gU2lnbmVkLW9mZi1i
eTogVG9tIFJpeCA8dHJpeEByZWRoYXQuY29tPg0KPiA+PiAtLS0NCj4gPj4gICAuLi4vQUJJL3Rl
c3Rpbmcvc3lzZnMtY2xhc3MtZnBnYS1yZWdpb24gICAgICAgIHwgIDQgKystLQ0KPiA+PiAgIGRy
aXZlcnMvZnBnYS9kZmwtZm1lLW1nci5jICAgICAgICAgICAgICAgICAgICAgfCAgOCArKysrLS0t
LQ0KPiA+PiAgIGRyaXZlcnMvZnBnYS9mcGdhLXJlZ2lvbi5jICAgICAgICAgICAgICAgICAgICAg
fCAgNCArLS0tDQo+ID4+ICAgaW5jbHVkZS9saW51eC9mcGdhL2ZwZ2EtbWdyLmggICAgICAgICAg
ICAgICAgICB8IDE4ICsrKysrKysrKysrKy0tLS0tLQ0KPiA+PiAgIGluY2x1ZGUvbGludXgvZnBn
YS9mcGdhLXJlZ2lvbi5oICAgICAgICAgICAgICAgfCAgMiArLQ0KPiA+PiAgIDUgZmlsZXMgY2hh
bmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWNsYXNzLWZwZ2EtcmVnaW9u
DQo+IGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1jbGFzcy1mcGdhLXJlZ2lvbg0K
PiA+PiBpbmRleCBiYzdlYzY0NGFjYzlhLi4yNDEzNTlmYjc0YTU1IDEwMDY0NA0KPiA+PiAtLS0g
YS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWNsYXNzLWZwZ2EtcmVnaW9uDQo+ID4+
ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtY2xhc3MtZnBnYS1yZWdpb24N
Cj4gPj4gQEAgLTUsNSArNSw1IEBAIENvbnRhY3Q6CVd1IEhhbyA8aGFvLnd1QGludGVsLmNvbT4N
Cj4gPj4gICBEZXNjcmlwdGlvbjoJRlBHQSByZWdpb24gaWQgZm9yIGNvbXBhdGliaWxpdHkgY2hl
Y2ssIGUuZy4gY29tcGF0aWJpbGl0eQ0KPiA+PiAgIAkJb2YgdGhlIEZQR0EgcmVjb25maWd1cmF0
aW9uIGhhcmR3YXJlIGFuZCBpbWFnZS4gVGhpcyB2YWx1ZQ0KPiA+PiAgIAkJaXMgZGVmaW5lZCBv
ciBjYWxjdWxhdGVkIGJ5IHRoZSBsYXllciB0aGF0IGlzIGNyZWF0aW5nIHRoZQ0KPiA+PiAtCQlG
UEdBIHJlZ2lvbi4gVGhpcyBpbnRlcmZhY2UgcmV0dXJucyB0aGUgY29tcGF0X2lkIHZhbHVlIG9y
DQo+ID4+IC0JCWp1c3QgZXJyb3IgY29kZSAtRU5PRU5UIGluIGNhc2UgY29tcGF0X2lkIGlzIG5v
dCB1c2VkLg0KPiA+PiArCQlGUEdBIHJlZ2lvbi4gVGhpcyBpbnRlcmZhY2UgcmV0dXJucyBhIHV1
aWQgdmFsdWUgb3IganVzdA0KPiA+PiArCQllcnJvciBjb2RlIC1FTk9FTlQgaW4gY2FzZSBjb21w
YXRfaWQgaXMgbm90IHVzZWQuDQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLWZt
ZS1tZ3IuYyBiL2RyaXZlcnMvZnBnYS9kZmwtZm1lLW1nci5jDQo+ID4+IGluZGV4IGQ1ODYxZDEz
YjMwNjkuLjAxMmI3MjcxMjY4NGMgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwt
Zm1lLW1nci5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvZnBnYS9kZmwtZm1lLW1nci5jDQo+ID4+IEBA
IC0yNzMsMTYgKzI3MywxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZwZ2FfbWFuYWdlcl9vcHMN
Cj4gZm1lX21ncl9vcHMgPSB7DQo+ID4+ICAgfTsNCj4gPj4NCj4gPj4gICBzdGF0aWMgdm9pZCBm
bWVfbWdyX2dldF9jb21wYXRfaWQodm9pZCBfX2lvbWVtICpmbWVfcHIsDQo+ID4+IC0JCQkJICBz
dHJ1Y3QgZnBnYV9jb21wYXRfaWQgKmlkKQ0KPiA+PiArCQkJCSAgdW5pb24gZnBnYV9jb21wYXRf
aWQgKmlkKQ0KPiA+PiAgIHsNCj4gPj4gLQlpZC0+aWRfbCA9IHJlYWRxKGZtZV9wciArIEZNRV9Q
Ul9JTlRGQ19JRF9MKTsNCj4gPj4gLQlpZC0+aWRfaCA9IHJlYWRxKGZtZV9wciArIEZNRV9QUl9J
TlRGQ19JRF9IKTsNCj4gPj4gKwlpZC0+aWRfbCA9IGNwdV90b19iZTY0KHJlYWRxKGZtZV9wciAr
IEZNRV9QUl9JTlRGQ19JRF9MKSk7DQo+ID4+ICsJaWQtPmlkX2ggPSBjcHVfdG9fYmU2NChyZWFk
cShmbWVfcHIgKyBGTUVfUFJfSU5URkNfSURfSCkpOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gICBz
dGF0aWMgaW50IGZtZV9tZ3JfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
Pj4gICB7DQo+ID4+ICAgCXN0cnVjdCBkZmxfZm1lX21ncl9wZGF0YSAqcGRhdGEgPSBkZXZfZ2V0
X3BsYXRkYXRhKCZwZGV2LT5kZXYpOw0KPiA+PiAtCXN0cnVjdCBmcGdhX2NvbXBhdF9pZCAqY29t
cGF0X2lkOw0KPiA+PiArCXVuaW9uIGZwZ2FfY29tcGF0X2lkICpjb21wYXRfaWQ7DQo+ID4+ICAg
CXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4+ICAgCXN0cnVjdCBmbWVfbWdy
X3ByaXYgKnByaXY7DQo+ID4+ICAgCXN0cnVjdCBmcGdhX21hbmFnZXIgKm1ncjsNCj4gPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9mcGdhLXJlZ2lvbi5jIGIvZHJpdmVycy9mcGdhL2ZwZ2Et
cmVnaW9uLmMNCj4gPj4gaW5kZXggYTQ4Mzg3MTUyMjFmZi4uZjEwODNiNTg5NDYzNSAxMDA2NDQN
Cj4gPj4gLS0tIGEvZHJpdmVycy9mcGdhL2ZwZ2EtcmVnaW9uLmMNCj4gPj4gKysrIGIvZHJpdmVy
cy9mcGdhL2ZwZ2EtcmVnaW9uLmMNCj4gPj4gQEAgLTE2Niw5ICsxNjYsNyBAQCBzdGF0aWMgc3Np
emVfdCBjb21wYXRfaWRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4+ICAgCWlmICghcmVn
aW9uLT5jb21wYXRfaWQpDQo+ID4+ICAgCQlyZXR1cm4gLUVOT0VOVDsNCj4gPj4NCj4gPj4gLQly
ZXR1cm4gc3ByaW50ZihidWYsICIlMDE2bGx4JTAxNmxseFxuIiwNCj4gPj4gLQkJICAgICAgICh1
bnNpZ25lZCBsb25nIGxvbmcpcmVnaW9uLT5jb21wYXRfaWQtPmlkX2gsDQo+ID4+IC0JCSAgICAg
ICAodW5zaWduZWQgbG9uZyBsb25nKXJlZ2lvbi0+Y29tcGF0X2lkLT5pZF9sKTsNCj4gPj4gKwly
ZXR1cm4gc3ByaW50ZihidWYsICIlcFVcbiIsICZyZWdpb24tPmNvbXBhdF9pZC0+dXVpZCk7DQo+
ID4+ICAgfQ0KPiA+Pg0KPiA+PiAgIHN0YXRpYyBERVZJQ0VfQVRUUl9STyhjb21wYXRfaWQpOw0K
PiA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mcGdhL2ZwZ2EtbWdyLmggYi9pbmNsdWRl
L2xpbnV4L2ZwZ2EvZnBnYS1tZ3IuaA0KPiA+PiBpbmRleCBlYzJjZDhiZmNlYjAwLi5iMTJmOTk5
NDkzMmUxIDEwMDY0NA0KPiA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZwZ2EvZnBnYS1tZ3IuaA0K
PiA+PiArKysgYi9pbmNsdWRlL2xpbnV4L2ZwZ2EvZnBnYS1tZ3IuaA0KPiA+PiBAQCAtMTAsNiAr
MTAsNyBAQA0KPiA+Pg0KPiA+PiAgICNpbmNsdWRlIDxsaW51eC9tdXRleC5oPg0KPiA+PiAgICNp
bmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC91
dWlkLmg+DQo+ID4+DQo+ID4+ICAgc3RydWN0IGZwZ2FfbWFuYWdlcjsNCj4gPj4gICBzdHJ1Y3Qg
c2dfdGFibGU7DQo+ID4+IEBAIC0xNDQsMTQgKzE0NSwxOSBAQCBzdHJ1Y3QgZnBnYV9tYW5hZ2Vy
X29wcyB7DQo+ID4+ICAgI2RlZmluZSBGUEdBX01HUl9TVEFUVVNfRklGT19PVkVSRkxPV19FUlIJ
QklUKDQpDQo+ID4+DQo+ID4+ICAgLyoqDQo+ID4+IC0gKiBzdHJ1Y3QgZnBnYV9jb21wYXRfaWQg
LSBpZCBmb3IgY29tcGF0aWJpbGl0eSBjaGVjaw0KPiA+PiAtICoNCj4gPj4gKyAqIHVuaW9uIGZw
Z2FfY29tcGF0X2lkIC0gaWQgZm9yIGNvbXBhdGliaWxpdHkgY2hlY2sNCj4gPj4gKyAqIENhbiBi
ZSBhY2Nlc3NlZCBhcyBlaXRoZXI6DQo+ID4+ICsgKiBAdXVpZDogdGhlIGJhc2UgdXVpZF90IHR5
cGUNCj4gPj4gKyAqIG9yDQo+ID4+ICAgICogQGlkX2g6IGhpZ2ggNjRiaXQgb2YgdGhlIGNvbXBh
dF9pZA0KPiA+PiAgICAqIEBpZF9sOiBsb3cgNjRiaXQgb2YgdGhlIGNvbXBhdF9pZA0KPiA+PiAg
ICAqLw0KPiA+PiAtc3RydWN0IGZwZ2FfY29tcGF0X2lkIHsNCj4gPj4gLQl1NjQgaWRfaDsNCj4g
Pj4gLQl1NjQgaWRfbDsNCj4gPj4gK3VuaW9uIGZwZ2FfY29tcGF0X2lkIHsNCj4gPj4gKwl1dWlk
X3QgdXVpZDsNCj4gPj4gKwlzdHJ1Y3Qgew0KPiA+PiArCQl1NjQgaWRfaDsNCj4gPj4gKwkJdTY0
IGlkX2w7DQo+ID4+ICsJfTsNCj4gPj4gICB9Ow0KPiA+Pg0KPiA+PiAgIC8qKg0KPiA+PiBAQCAt
MTY5LDcgKzE3NSw3IEBAIHN0cnVjdCBmcGdhX21hbmFnZXIgew0KPiA+PiAgIAlzdHJ1Y3QgZGV2
aWNlIGRldjsNCj4gPj4gICAJc3RydWN0IG11dGV4IHJlZl9tdXRleDsNCj4gPj4gICAJZW51bSBm
cGdhX21ncl9zdGF0ZXMgc3RhdGU7DQo+ID4+IC0Jc3RydWN0IGZwZ2FfY29tcGF0X2lkICpjb21w
YXRfaWQ7DQo+ID4+ICsJdW5pb24gZnBnYV9jb21wYXRfaWQgKmNvbXBhdF9pZDsNCj4gPj4gICAJ
Y29uc3Qgc3RydWN0IGZwZ2FfbWFuYWdlcl9vcHMgKm1vcHM7DQo+ID4+ICAgCXZvaWQgKnByaXY7
DQo+ID4+ICAgfTsNCj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnBnYS9mcGdhLXJl
Z2lvbi5oIGIvaW5jbHVkZS9saW51eC9mcGdhL2ZwZ2EtDQo+IHJlZ2lvbi5oDQo+ID4+IGluZGV4
IDI3Y2I3MDYyNzVkYmEuLjdjYzJlZTU0M2VmYjQgMTAwNjQ0DQo+ID4+IC0tLSBhL2luY2x1ZGUv
bGludXgvZnBnYS9mcGdhLXJlZ2lvbi5oDQo+ID4+ICsrKyBiL2luY2x1ZGUvbGludXgvZnBnYS9m
cGdhLXJlZ2lvbi5oDQo+ID4+IEBAIC0yNCw3ICsyNCw3IEBAIHN0cnVjdCBmcGdhX3JlZ2lvbiB7
DQo+ID4+ICAgCXN0cnVjdCBsaXN0X2hlYWQgYnJpZGdlX2xpc3Q7DQo+ID4+ICAgCXN0cnVjdCBm
cGdhX21hbmFnZXIgKm1ncjsNCj4gPj4gICAJc3RydWN0IGZwZ2FfaW1hZ2VfaW5mbyAqaW5mbzsN
Cj4gPj4gLQlzdHJ1Y3QgZnBnYV9jb21wYXRfaWQgKmNvbXBhdF9pZDsNCj4gPj4gKwl1bmlvbiBm
cGdhX2NvbXBhdF9pZCAqY29tcGF0X2lkOw0KPiA+PiAgIAl2b2lkICpwcml2Ow0KPiA+PiAgIAlp
bnQgKCpnZXRfYnJpZGdlcykoc3RydWN0IGZwZ2FfcmVnaW9uICpyZWdpb24pOw0KPiA+PiAgIH07
DQoNCg==
