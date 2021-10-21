Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568074357E7
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Oct 2021 02:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUApv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Oct 2021 20:45:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:20259 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJUApu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 20 Oct 2021 20:45:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="226374841"
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="226374841"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 17:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="463420836"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 20 Oct 2021 17:43:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 17:43:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 17:43:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 17:43:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 17:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUhFMUeTncIBO2qzoDxN84QBYF8BzmyHKlrcG5m2Pcy8pwIzV0zkLLCn3OJzUykPcQGRqIxNBkrhT+oBYLDRiY7x8NNgXgyp1z7ybwh3cSATY5xtG4unEVNQRi+29sp1ZY+SnCmM1KMw0MMl7VWmPYjvpQWd3S83p38qu+8ZFIzYdwDUJ6F5PXexTfW15Mhko0Y6RI1A9ezhWq8domAb2QavS38fwyauRL7c5nX5oPRD3NaO0ls3hLFpeaEzHFCHiAPvXqHlE6GMqn3Wfi9kSRcWDIC/gwJ7evSIkWjDHg+keBKL2YLgodVu9H9Hdvy2QRGPAJimLcmemwyuM6v4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7/eYodVYxzZrK2+S+zw7CZROpjGuBzHGVcxgmARqtE=;
 b=YCqw70LyBCTM5vBxAcUySdWrJzEkw2QnWsTqPgbX73PTnwXwU+sAahN469lRd7+yE8+JBz3JUyNZllKWcPazE8cIqM9LfOfV3+iYO9MGY/KZYq1HWVaD/7uH4XtP5zGrYoOJLvY/xwbGSQ4grVz0C1GNASw9guFjfUEDy3gO+lMfkvTTeq7FgB+NJd7rDeWSVhzCn9/otLMBr5KkHfWOupzr6HwAt73fQEmJ9ANCtk10Xp3UqMDy68zn/uoMNtwj2Y3guu1RoAq+6Zr7rY7prLTJ6/gn1HOKjn31Ru0Y4q8q9VuZPvD4UzHspfS6HbRee8LOsYo22qLYI5Liy5vkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7/eYodVYxzZrK2+S+zw7CZROpjGuBzHGVcxgmARqtE=;
 b=EeaxDjCMSnoCKhSJSs8iqsoByHrB3YLpFy9Xl/DJYFSwGFBUJ09Fr6ukVw59NLntpM5oSiIwd0RUMeuAl3DyKkpBaHhNa98FCB2E+2m92cx3vpD8hk35Adfjrmzpk0ambJbzvtS+aPtc4ovCuVt2Ji1yj8+Bvduwdz3dH6YlsnA=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3497.namprd11.prod.outlook.com (2603:10b6:5:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 00:43:30 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104%5]) with mapi id 15.20.4628.016; Thu, 21 Oct 2021
 00:43:30 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH v1 0/2] fpga: dfl: Log and clear errors on driver init
Thread-Topic: [PATCH v1 0/2] fpga: dfl: Log and clear errors on driver init
Thread-Index: AQHXxT9HeMr2I/hZYUmG/Mg0WNK+PKvbSqRwgAFJrwCAAAeDIA==
Date:   Thu, 21 Oct 2021 00:43:30 +0000
Message-ID: <DM6PR11MB381929A6CEF5B5DE974E4B5485BF9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20211019231545.47118-1-russell.h.weight@intel.com>
 <DM6PR11MB3819F29DF7B20FDED6DC814685BE9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <f64249d2-1d48-c191-bce8-5e9e4a5e4643@intel.com>
In-Reply-To: <f64249d2-1d48-c191-bce8-5e9e4a5e4643@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca6f53c6-6deb-46d3-863a-08d9942bcdc1
x-ms-traffictypediagnostic: DM6PR11MB3497:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB34971836294DAAE90AC877A385BF9@DM6PR11MB3497.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fbvd0Ko1bFTeT9FX7MntZuGJqmxszftuxtbezyDiUOsHsNGrWeQ5q6QQw6ivb2NxZwzilnRizV8Sg2KXBnI1DsIqGwmTrdCux+UnGDAidqWMFQur95tp5UXP1xxVlAvXcngxC9VvXWmJcu+93BPiNY1SalqgUBAPeU3qdllsjnNv2HmxYBGXoYWefKBZydf+zvECEL9qIqHGAsV5BzZtl5Txex126x5PGXxqtaR/O/uBd2vOtfL0H9eK+wDMyTC3T65Ah5YuTyRkedYEBNU+CbOjT7JHnbAizCnlNQ2jz+O7u/LbB5a79XEhGQbFOOZZ5K916pk+WuDTcjY154/XwJD/X9LMmoyfIMJSds+uouiOawzHlG4U7/7pc2piuglSCT5CveF5I1vjO2esULtcv6TakleZJT3BvMGEkVZqaPQSZWO0p507ocghpYzQGRKE6CHMHa5DAjvN/qvP2lNTjJ1iGnDBx1heytu3IDGXFLApeCH1EM4KDkc5OjdoeEqeGmI0COeCG1BVwX277SR/fuNDhKWyn0kVtgcisn/TM1DuB8tb40rgN/a/uBesoNESo/o5iEnYrv1ad68C9cjpIqN9Rk9Et60Y0jNyO2rVxfWqXksuwiC6o8cdcbcdmjMIfPliY4mXf3KDaBOG0cSlBNvs02QOKQrIOCfqRAeCnXLJyMNmXy6DROUKyEn6END90M5MQkTAyge57Uv3LAhg6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(54906003)(82960400001)(107886003)(122000001)(38100700002)(53546011)(6506007)(71200400001)(7696005)(86362001)(186003)(2906002)(66446008)(110136005)(316002)(38070700005)(66556008)(76116006)(66946007)(9686003)(64756008)(33656002)(5660300002)(508600001)(55016002)(83380400001)(66476007)(8936002)(4326008)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGFtRGtNUlppaDZOL0lhZ3g2REI5Z21PVnFYRjdlNXc1MElsa0tkbERJNzNX?=
 =?utf-8?B?SEs2SzhHSW9YQVlNZGhwNjRITG9tNXRwZkVJb0cveHNiYUhkdEVNLzYvL1VI?=
 =?utf-8?B?MHUxQ09PNDhVZm9FWHJROGJqNVhQWHNVK3gveFk1TmE5ZHk1T2d0cTg3eGV0?=
 =?utf-8?B?T1pMUEtHcHhCc3B1T3RKaHdOL1pVR2ZOYys0WDBWT1E4VnRuNnBzbjFjK2F0?=
 =?utf-8?B?cG5IOExFdzcvMTc2TjhCWHlkbE5qamJTVXJwSWQ5aTZhNnlVMTdsL1VTT0p6?=
 =?utf-8?B?djJhdVE3NWxZcmZRUXVwSWF3WUUvQ3R0KzcyYS9ONld4UitGRURMbDBubU1t?=
 =?utf-8?B?UWdYZDBaZjlNcjNhUnhoLzBjdFBtaEI1WDNKRE5xNWRXSSt2dWZMVVZIY1VN?=
 =?utf-8?B?TDVNYnRaR2FVRk9EZ1lYM0ZpSERyUmh3T1NRTXBiQnVpeFE1dzhsUDArbWZi?=
 =?utf-8?B?eGUrMmRqS1M2SWw0QTFKR1I1QTRVZzZ3Q293dTJTSmY4ZitVRlZ0TXduVDc0?=
 =?utf-8?B?dGZIcUMvV1ZuVFNkNHR6SU50TXNUOVA5QzZBdkdwWFlzZzF5SER5YkI3Qm5i?=
 =?utf-8?B?MUl1NjF2QitTWWVlSzlOT2svb1JUWU54cjRNcHo1TlpKR21VY0E0ZzdIZUpY?=
 =?utf-8?B?dy9MaktZL1k5SFV0bUpJZjkwVlpiSG9KYUpCYnNWMnp1ckk3RDZrRTNVVXdm?=
 =?utf-8?B?ZVJaWXM5OU9UVEp5V3JhNlJzYU85Ni9EWmgvck9sMG90VWZBSFJCQVR1UXJ2?=
 =?utf-8?B?ZlZNdXpYMHlYU3lpVUtOZUVpSnJOYnVyejdHSHFoMXp3WTZzZURPN0JqRGpz?=
 =?utf-8?B?UEw2S2Fsck1qUHhDbVZ1eEt5SFRacEV2UGQ5c3VzZ2F4dCtBVlVsRWVFQlBx?=
 =?utf-8?B?YlpzUGJNelphM2hJajNsSjE1TXFoUXpVNzA1REN4bEVUTXV5T21mU0lyajBQ?=
 =?utf-8?B?WVRJOWFPVzlsaE01aVZDNFU3STgzZUFtYzlsaTc5ZmJoZnBGc1JScm8vRWJp?=
 =?utf-8?B?ZGsrZmY2NWNrVndJR3lwMm0yaExtNnZGNk5KZitYclJ4akQ4MWE5bXZxTmND?=
 =?utf-8?B?N2VmcWpEWXE1bVE1S0J1SHcwMEFaQzFxQzBqV2hUa1BXQ0ZDdlFBS3pZMkhm?=
 =?utf-8?B?ajU4UnBqOThqdkhka2xrT3V3eGlXK1lSQm1COWlZbm8yOU16a0liRFpxNy9K?=
 =?utf-8?B?MDRpRHFmSFNDd1YyZWhFUHpveVg3bVczVzhNeER0b1NWbEU5UWlRVzVPMG91?=
 =?utf-8?B?VDBmbDF4VGlZVmVjT0o4elZPN3FzTUN6dk82UWZXYzhCQXpSTzgyTTEvejFC?=
 =?utf-8?B?aHhrR2p2cUlmK3g5dHB5WlR4NG53emtSUmZZRTNrS1JSbm81WHFCTkJycnV6?=
 =?utf-8?B?dWpCY244STdvVGF2eHY5ZWlncmFTM1VsOFR4VE9GaWE5dW44VmNwd0lZUFBj?=
 =?utf-8?B?dXN1aFd4RVNLQmY0clUrUmEwaVo3ODhHR1Nsd0l5d0dhbGdjVCt0U2FLa0Uv?=
 =?utf-8?B?dHMyc0V6Z0FZQ2RPZVI5Z0dUazlsNG4vbmIxT3Y3UUF0WXZaWE45VHYxNHhw?=
 =?utf-8?B?SkdNRmpHaUNhWk9NUXZjdW9rR3h2Y2tibVNBTFFNVm02OW1OSForb3I0cDlU?=
 =?utf-8?B?WGV2MXBuUFJDMmFhd2NPSEVpVkx1TnNKWWxHU1g1c09WTnIzYTR0SCtmNjM3?=
 =?utf-8?B?QXRqN0VBN1dVdUtkaTRrYXJyRHIwajM2bUNwNXpTVWR6K2lubnA5SG5lc1NN?=
 =?utf-8?Q?JcOoE0o1yqjvR7FFROIpVsuO8ln0QCb06/W8zol?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6f53c6-6deb-46d3-863a-08d9942bcdc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 00:43:30.5283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQkT6ZwIVsgxExaK06FMlFhZh/a1Cufk9M2wL5m1kNtWSS2uk6GVOwUvlvcd7t7Ja6vHSIECXouABGqY5jp+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3497
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiAxMC8xOS8yMSA5OjQ0IFBNLCBXdSwgSGFvIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBbUEFU
Q0ggdjEgMC8yXSBmcGdhOiBkZmw6IExvZyBhbmQgY2xlYXIgZXJyb3JzIG9uIGRyaXZlciBpbml0
DQo+ID4+DQo+ID4+IFRoZXNlIHBhdGNoZXMgYWRkcmVzcyBhIHJlcXVlc3QgdG8gbG9nIGFuZCBj
bGVhciBhbnkgcHJleGlzdGluZyBlcnJvcnMgb24NCj4gPj4gRlBHQSBjYXJkcyB3aGVuIHRoZSBk
cml2ZXJzIGxvYWQuIEFueSBleGlzdGluZyBlcnJvcnMgd2lsbCByZXN1bHQgaW4gcHJpbnQNCj4g
Pj4gc3RhdGVtZW50cyB0byB0aGUga2VybmVsIGVycm9yIGxvZyBiZWZvcmUgdGhlIGVycm9ycyBh
cmUgY2xlYXJlZC4gVGhlc2UNCj4gPj4gY2hhbmdlcyBzcGVjaWZpY2FsbHkgYWZmZWN0IHRoZSBm
bWUgYW5kIHBvcnQgZXJyb3IgcmVnaXN0ZXJzLg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgZXhwbGFp
biBtb3JlIGFib3V0IHdoeSB3ZSBuZWVkIHRoaXMgY2hhbmdlPw0KPiA+IEFzIHdlIGhhdmUgdXNl
ciBpbnRlcmZhY2UgdG8gbG9nIGFuZCBjbGVhciBlcnJvcnMgYWxyZWFkeSwgaXMgaXQgYSBiZXR0
ZXIgY2hvaWNlDQo+ID4gdG8gbGV0IHVzZXJzcGFjZSBsb2cgYW5kIGNsZWFyIHRoZW0gZHVyaW5n
IEFGVSBpbml0aWFsaXphdGlvbj8NCj4gSW4gdGhlIG5ldyBhcmNoaXRlY3R1cmUgd2UgYXJlIG9m
ZmVyaW5nIG1vcmUgZmxleGliaWxpdHkgdG8gY3VzdG9tZXJzDQo+IGZvciBhZGRpbmcgZnVuY3Rp
b25zLiBXaXRoIHRoZXNlIGRlc2lnbnMgaXQgYmVjb21lcyBuZWFybHkgaW1wb3NzaWJsZQ0KPiB0
byBkZXNpZ24gdGhlIEFGVSBpbnRlcmZhY2UgaGFuZGxlciB0byByZWNvdmVyIGZyb20gZXJyb3Jz
IGFuZCByZXN1bWUNCj4gb3BlcmF0aW9uIGFmdGVyd2FyZHMuIFRoZSBwcm9wb3NlZCBzb2x1dGlv
biBpcyB0byBmbGFnIHRoZSBzb3VyY2Ugb2YNCj4gdGhlIGVycm9yIGFuZCB0aGVuIGNhcHR1cmUg
aXQgaW4gc3RpY2t5IHJlZ2lzdGVycyBzbyB0aGF0IHRoZXkgY2FuIGJlDQo+IHJlYWQgb3V0IGZy
b20gU1cgaW4gdGhlIGV2ZW50IG9mIGEgY3Jhc2gvd2FybSBib290LiBUbyBlbnN1cmUgdGhhdCB3
ZQ0KPiBjYXB0dXJlIHRoZXNlIGVycm9ycywgdGhlIHByb3Bvc2FsIGlzIHRvIGxvZyB0aGVtIGlu
IHRoZSBrZXJuZWwgbG9nIGFuZA0KPiBjbGVhciB0aGVtIGF0IGRyaXZlciBpbml0aWFsaXphdGlv
bi4NCg0KVGhlIGVycm9yIGNhbiBiZSBsb2dnZWQgYW5kIGNsZWFyZWQgYXQgdXNlciBzcGFjZSBk
cml2ZXIgaW5pdGlhbGl6YXRpb24sDQphcyBjdXJyZW50IHVzYWdlIG1vZGVsIGlzIGxldCB1c2Vy
c3BhY2UgaGFuZGxlIGV2ZXJ5dGhpbmcgaW5jbHVkaW5nIGVycm9yLg0KDQpIYW8NCg0KPiANCj4g
LSBSdXNzDQo+IA0KPiA+IEhhbw0KPiA+DQo+ID4+IFJ1c3MgV2VpZ2h0ICgyKToNCj4gPj4gICBm
cGdhOiBkZmw6IGFmdTogQ2xlYXIgcG9ydCBlcnJvcnMgaW4gYWZ1IGluaXQNCj4gPj4gICBmcGdh
OiBkZmw6IGZtZTogQ2xlYXIgZm1lIGdsb2JhbCBlcnJvcnMgYXQgZHJpdmVyIGluaXQNCj4gPj4N
Cj4gPj4gIGRyaXZlcnMvZnBnYS9kZmwtYWZ1LWVycm9yLmMgfCAgMjYgKysrKy0tLQ0KPiA+PiAg
ZHJpdmVycy9mcGdhL2RmbC1mbWUtZXJyb3IuYyB8IDEyOCArKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLQ0KPiA+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKSwg
NTQgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IC0tDQo+ID4+IDIuMjUuMQ0KDQo=
