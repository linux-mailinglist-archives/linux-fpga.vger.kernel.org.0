Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4A83AE6A0
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFUKAF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 06:00:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:38694 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFUKAF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 06:00:05 -0400
IronPort-SDR: 5aqZ9GtHGWt3BsiBVcPJayGyRy7xgNP6uSnCodVKOv3kPoKhvvw5wCY3vxv3Of4FUp1UW4tmkt
 6TVYAt5CMihA==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="228356585"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="228356585"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 02:57:50 -0700
IronPort-SDR: NEN7XqVeAqUwSz3zKPBSzeBs/BX4BRu1j7DTPae/Ll9ApcgD9SfynNomwLfgii4kI/i/jN8NUN
 L8j5xVhkg9aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="623028735"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2021 02:57:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 02:57:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 02:57:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 21 Jun 2021 02:57:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 21 Jun 2021 02:57:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPudks5gZogq/l0H9ncBobRiPOySqsg2fAEI4yQvYJr2jg1vmxQU7ARCV/S/YuSn0wqi1T2zXm9Oms0Clndwle0H4+A+l1JNcN2H2OFirxf7dzHEJo4+h/b4pJYJgEEaaWIumb315uYv9TUhaSdR7fzRFEGQh2D4qGiqRZf/vL9BWFey9VkX9+/h+5k+dOOd6vIN8GuWWU8AKjxHgycIHpVjocjR0IHrmghhOqOoAvEKgO9M7N/okRoVNbN5+jAncI3seVF+Uz5l3jjkpU77AtmShPTHuJx8xu2e45avvaDulR5Xvaq9kL1zrxmDb/bxJunqxa2Va0yg0xCLt66ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GztQXtIhVgrmtCMEC8urtNeVIDa8pA4kSg52LyE147Y=;
 b=elU/D1aDpA5AlfFpbYGAOZ53J0rKDawXFCQ7xuNRoz5zC9b79ymX0UfLC5QcgXknsIdVdxWlzMGiN1uCcQixL/2fvRpQgmgtAaOPndMkRVjla6W/tegRzyr19iL4TqMzCyqZsoS5OrS4JekYEUWSQS9PfLpDb0r6Ze9ulbG0pKeUfPwuLI5+7Gb9mk0h62pWUFfGJwfn0hllaVZOySehhLDXtjsoi0pN9yOflAJoXHdqaaHGdAzC9H1XPvUEzq6jRHDtl6G8q/m3h1xDHk2DIrTit0Px8nBmIz0/eJxJESJQQOiY2q+HrJuhichbMfiTJJIHwNmV7q0gYAy3A84d3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GztQXtIhVgrmtCMEC8urtNeVIDa8pA4kSg52LyE147Y=;
 b=Csb3VD/aN68GbbpBhku4nQruE8lA5QWWGCibwoebpyWb3Rtt16BE/44rCXQg6se58+vMWCKKj64JYmq6DuQQyqKl1ctFwD/FxBiMymqv1T90IGqf3T29nfgsnrkq7Wn3yUCbgRnfPZ2+44j+4+pmCX3lc33mOXIr8wj3PjgpQvU=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2569.namprd11.prod.outlook.com (2603:10b6:5:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 09:57:45 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 09:57:44 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <mhu@silicom.dk>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <mhu@geanix.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <mhu@silicom.dk>
Subject: RE: [PATCH 1/4] fpga: dfl: pci: add device IDs for Silicom N501x PAC
 cards
Thread-Topic: [PATCH 1/4] fpga: dfl: pci: add device IDs for Silicom N501x PAC
 cards
Thread-Index: AQHXZmwEYCmNoicXlkSqB7lbFUgoN6seOJqQ
Date:   Mon, 21 Jun 2021 09:57:44 +0000
Message-ID: <DM6PR11MB3819CFC547288F98B18E3E13850A9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-2-mhu@silicom.dk>
In-Reply-To: <20210621070621.431482-2-mhu@silicom.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: silicom.dk; dkim=none (message not signed)
 header.d=none;silicom.dk; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3d01ca5-17f7-4b2b-c7b5-08d9349b0482
x-ms-traffictypediagnostic: DM6PR11MB2569:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2569BF473F450FEF7054D40E850A9@DM6PR11MB2569.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gvGsCrWacXoBPtMkewPmG0QJLlT1crrT7K4czlm7oBhT2PwE5KgKBhWbRS4EC9CkWANmtNRxxhSKRcmQYy27LKKnMVm4X6N0aklWIYe75y4ccQUxDqBxnjycCP+kpZUvhxQkAfzZFv4GudgZ4SxL8nyyjW2e4ZoabrXbYgOtq0//O0vs5i6oOb3AsYuQ7aCKxDrXAEs3dmw2/KsXJqhOeN7ds6vO34V7b3WmU+b4RukMwWu9oIQIDy4riRgITvZHL7nhvQWonV4lz2QrxTO4XnhPsAwggfOO+eMEvd6BYr2AOEWlBB1VQ9ili+XwJ+//W9EpjmmL6yj+mVgYf9wv35IhSNWPe4DQCHIbAE+1aZP/N/4tTonX3Kde5EHHBi071HHdZ/XXnbGrX3xdrGXcWZyIHnkV8snKD5t5oZY3vj810gHyr65MIzzKz+45+UWt+eKVYR+WEYRr5fbrqj6QwzYRPunn88eE55hX8kd4HfFaXz5cENYLGVge6xsOUkF+wpDQIwSKTweeFtQXrKZKCW8zxzW5ZZXyOPXlLF3mIIS7VcDJKPksJ1j+02j8yjuwJldC/ntu12t89tEdvTtwTqIezejxiSBdL3ee2OCb404=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(376002)(366004)(396003)(66446008)(76116006)(64756008)(66556008)(55016002)(66476007)(9686003)(66946007)(5660300002)(86362001)(33656002)(2906002)(38100700002)(71200400001)(8936002)(7696005)(54906003)(110136005)(6506007)(26005)(7416002)(4326008)(52536014)(478600001)(316002)(186003)(8676002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTZaSFdpMmRpNVNJMkpTMS82c3JzMm84U1RnclNSUG1ZZks5RkJGNDBNMDBv?=
 =?utf-8?B?YmtBT2paUjREWVNsclBBak1tZ0tnVjFNRW9CbHM2UDhHWjVsNi9aajcrSWhL?=
 =?utf-8?B?ZmtrNllBL0N3VXpTZDNaRHZXcXl4VGlmNVg2c3JQaVBIOEd3L0hOa0lEdzFB?=
 =?utf-8?B?NlQ3aVBJLzRqV3ZnVXpMNkt4em83b3NMOGtEcEpCMHQ5OWRVNDdTVFc1dXN3?=
 =?utf-8?B?cEFjMVFHYUJkbGtIRnNyWDMyaDNSamhrZzVNNGdTNG1GV3BpVzN3cFQ5UDE3?=
 =?utf-8?B?UEZCMHBRWnRYSFJ6VitaT1E5ck5OTlF0V2k4N3JVTTJZeXJQSDBhZjZhVURm?=
 =?utf-8?B?N1haSjE4TCtPWVRiLzVZcTVNRWZ5VjVlcno0cmdPWlE2cDhPUnl4Z1hzMXVa?=
 =?utf-8?B?akRYWjVnKzhQa1QwOTcxbEk2WHlVK24rVHBFOUVsNE1hanlnMzlVTkJaQVF0?=
 =?utf-8?B?RXZUakhQZTFMaGVzdGQyR1V5WVdZZ3JwRzNUZURsYzFMRzk2eWloSHdKc0hT?=
 =?utf-8?B?czhDSThDdk9IWjlSb0o5bzJ1V2dSWlprTEZONzlsVkFqT0pHaXNsWDZaTjJG?=
 =?utf-8?B?SFZNNzVNcDFORVFDOFVTaVlueFJwWU14Z1d3TEl6UGx0N00zdy9iWTdtVFlu?=
 =?utf-8?B?TEtBdjkrZFkrNzVsTmwyZWJvMHMvelFsMnZoTWRuZm9VM1VTRnlONm1XdFky?=
 =?utf-8?B?ekwrTUoxSm1TUjczYjl1QUNqa0RHS1lSSURManlpbXJ3bURkb05sTktsZU5W?=
 =?utf-8?B?dFdXcUZUNTJaNUJqeXlxbkVLOEtKSCszSy8wKzJMVmoyQTBSbjJXNWF1RThy?=
 =?utf-8?B?MEpmUElnWm9xd0syeWJFdEJkZExaK25jb21xejErYndqbzBKTzJ5OFp0N1Rt?=
 =?utf-8?B?ampFL3U3N3pTcVZvREMybEh2MldkQVJvMFc4TUV2MXN0Q1Jha0hqL1hnSktB?=
 =?utf-8?B?cXdlS2hPTlQ0YWN0Qm9wWHlBaUoyNWlEUjhqM1EraCt6VTVMQ0RhNDlma2du?=
 =?utf-8?B?NSt2WDV2T1g0cGxKTFVmQ3FPcTd0THNpZzRocHVjQWkrR3dsVzRKMFUwVGIy?=
 =?utf-8?B?dVFrWUwwNUlYQWh2OXBqTmJEb3Naa2IvQks0YjE3TjFCVTI2REFvTHIzNHdZ?=
 =?utf-8?B?TmZLbkJ0NlNudGVCRHBuVVRoZHFsSGloVmNYc2l1NmN4M1owZFd3THVNRE9y?=
 =?utf-8?B?V05rMVdjM3VoSnQzbmRiVENFWDhPZ2kzbTY1R1plK25icW5lSmhDK29CQ3hW?=
 =?utf-8?B?SDhtVXpqUU1rMG5nVU12dVVEZVZkVlV0L1AyUTJ1S0UzVjlsWXJINjRieUdu?=
 =?utf-8?B?czVBYkRwT3BWNHdqQndiRVFYd3lTQ3hjSjdKMkZyQnU0azRvZVJkZGh3REpE?=
 =?utf-8?B?OVMySTdEd2dtdjBUZm42cUZ4Rk45RUxFYmlzbm1VZzl4S1owdVFGb0VhOW1q?=
 =?utf-8?B?QkRtRVIzNXFaRHZEamtNWkgxSXA1bWlUWjBUOG5melozM3JYaHRHQjYvMUpD?=
 =?utf-8?B?Nzl1eEVmWm03Q2hoQjRlNjd5S2dFVWFwTU9uSzhMcEIzOXY3M3hWR1JJTkFv?=
 =?utf-8?B?RmN0NG4zUnBMQkNrNnhvUmpVNkkyRnJnR1h4eXYvaDRZbERna0djTGluYktI?=
 =?utf-8?B?K2l2dDZBYU5Pb0xQOW1DTEJqbk5vakhLUlk1ZDNtNkZiSGVDOENxY3ArRlJm?=
 =?utf-8?B?Rk9PdmltUWJQcXZ5VjVObjZkcGlWMFhYN3IrSDlzbVRGaGNDbmN5RjNWT1lU?=
 =?utf-8?Q?JeKk5w+Ak+8VlmNbRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d01ca5-17f7-4b2b-c7b5-08d9349b0482
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 09:57:44.8531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZ7dXSWptWjdiNCQPvbgXnFycthpn5alo9I0XSoE1hes3ReuK4T+L8bfowghTp0mKPtrb14JE0kVUqzC/5jCGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2569
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggMS80XSBmcGdhOiBkZmw6IHBjaTogYWRkIGRldmljZSBJRHMgZm9y
IFNpbGljb20gTjUwMXggUEFDIGNhcmRzDQo+IA0KPiBUaGlzIGFkZHMgdGhlIGFwcHJvdmVkIFBD
SSBFeHByZXNzIERldmljZSBJRHMgZm9yIHRoZQ0KPiBTaWxpY29tIFBBQyBONTAxMCBhbmQgTjUw
MTEgY2FyZHMuDQoNCk1heWJlIHNvbWUgc2hvcnQgZGVzY3JpcHRpb25zIG9uIHRoZXNlIGNhcmRz
PyBBbmQgYWxzbyBmdWxsIG5hbWUgb2YgUEFDDQpoZXJlIG1heSBiZSBoZWxwZnVsIGFzIHdlbGwu
IE90aGVycyBsb29rIGdvb2QgdG8gbWUuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBI
dW5kZWLDuGxsIDxtaHVAc2lsaWNvbS5kaz4NCg0KV2l0aCBhYm92ZSBjaGFuZ2UNCkFja2VkLWJ5
OiBXdSBIYW8gPGhhby53dUBpbnRlbC5jb20+DQoNClRoYW5rcw0KSGFvDQoNCj4gLS0tDQo+ICBk
cml2ZXJzL2ZwZ2EvZGZsLXBjaS5jIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtcGNpLmMgYi9k
cml2ZXJzL2ZwZ2EvZGZsLXBjaS5jDQo+IGluZGV4IGI0NDUyM2VhOGM5MS4uNGQ2ODcxOWU2MDhm
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZGZsLXBjaS5jDQo+ICsrKyBiL2RyaXZlcnMv
ZnBnYS9kZmwtcGNpLmMNCj4gQEAgLTc0LDYgKzc0LDkgQEAgc3RhdGljIHZvaWQgY2NpX3BjaV9m
cmVlX2lycShzdHJ1Y3QgcGNpX2RldiAqcGNpZGV2KQ0KPiAgI2RlZmluZSBQQ0lFX0RFVklDRV9J
RF9QRl9EU0NfMV9YCQkweDA5QzQNCj4gICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfSU5URUxfUEFD
X04zMDAwCQkweDBCMzANCj4gICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfSU5URUxfUEFDX0Q1MDA1
CQkweDBCMkINCj4gKyNkZWZpbmUgUENJRV9ERVZJQ0VfSURfU0lMSUNPTV9QQUNfTjUwMTAJMHgx
MDAwDQo+ICsjZGVmaW5lIFBDSUVfREVWSUNFX0lEX1NJTElDT01fUEFDX041MDExCTB4MTAwMQ0K
PiArDQo+ICAvKiBWRiBEZXZpY2UgKi8NCj4gICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfVkZfSU5U
XzVfWAkJMHhCQ0JGDQo+ICAjZGVmaW5lIFBDSUVfREVWSUNFX0lEX1ZGX0lOVF82X1gJCTB4QkND
MQ0KPiBAQCAtOTAsNiArOTMsOCBAQCBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgY2NpX3Bj
aWVfaWRfdGJsW10gPSB7DQo+ICAJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwNCj4g
UENJRV9ERVZJQ0VfSURfSU5URUxfUEFDX04zMDAwKSx9LA0KPiAgCXtQQ0lfREVWSUNFKFBDSV9W
RU5ET1JfSURfSU5URUwsDQo+IFBDSUVfREVWSUNFX0lEX0lOVEVMX1BBQ19ENTAwNSksfSwNCj4g
IAl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLA0KPiBQQ0lFX0RFVklDRV9JRF9JTlRF
TF9QQUNfRDUwMDVfVkYpLH0sDQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9TSUxJQ09N
X0RFTk1BUkssDQo+IFBDSUVfREVWSUNFX0lEX1NJTElDT01fUEFDX041MDEwKSx9LA0KPiArCXtQ
Q0lfREVWSUNFKFBDSV9WRU5ET1JfSURfU0lMSUNPTV9ERU5NQVJLLA0KPiBQQ0lFX0RFVklDRV9J
RF9TSUxJQ09NX1BBQ19ONTAxMSksfSwNCj4gIAl7MCx9DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklD
RV9UQUJMRShwY2ksIGNjaV9wY2llX2lkX3RibCk7DQo+IC0tDQo+IDIuMzEuMA0KDQo=
