Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F043AC60
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Oct 2021 08:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhJZGsW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Oct 2021 02:48:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:25684 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhJZGsV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Oct 2021 02:48:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="210617336"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="210617336"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 23:45:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="722178659"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2021 23:45:57 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 25 Oct 2021 23:45:57 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 25 Oct 2021 23:45:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 25 Oct 2021 23:45:56 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 25 Oct 2021 23:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMJfjg/OfAAtGuDfIG1GRcv6lUSBHoroSE3MzGBBvhRTeqv9zvGFmB+trhWYiNU706dqK1xGHEPTvOAWde3ddPiD+CH88V8jI/wwSnIDEWEj/bNN4YR3Cew8WKKM5a1zJEMWsfldQP+UGH1FtdSU/DS6FEn5ktmkR3ZbBxjwU1nTT+KWfpOIZF1ABDUh9SvWqGctOyqbd5Dr2BPTgaZIQyNRbYL62F6TAsfDJdTDNzpx0t6Q30PWvjjfJ7EaIrVMsZwGl089eeWAeN40QoM19GX+FQZcO0Ew8Z5fhjjEP8JpTlk4FW5EMUX+v6LBMatKB/Bj6lDpYARNSYfQA2X8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV16K3rM5HjSqgA1AOQ1L+0oS7j/LDpd9Si0aTRnMxc=;
 b=AcJWpSMUM+sgGNECx9B9ohpn4hOIR0w49MAiM7BjSinvir5JnE7odxjzeatL846HhxPt/+X6AeOIqS+et43DkhBGCbJkstumSkzNxmR4jvJHvM2sxyg9iLiALSytcncdcM6uA5SuG1l7xMIatAAinkzrmgV2QvNLB9BE6B7+GLDhhDQ8Ca/ptuPiRa03qarsI0VYOov9DHZ0CWK8hn8ZJYdmUkGMlvzDmv05+cWRZWxieSyJUFJR8WD7tdec3WBm5TfnyssIofcMflW5b3bev8SpH1aaSm9sFEZPqbdNRwNIrG2tzLnxalS9bgAcDICDQuSxyUmOijM4qiTFqi77Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV16K3rM5HjSqgA1AOQ1L+0oS7j/LDpd9Si0aTRnMxc=;
 b=lMzt679yUQARt4EVvmt8jF0RbzZiiRvwybyqXvEBf6f3vwDFZmOwdmdcIWcmRlZmKVr8LxGVfgQt85ymtUu7uvB16V0AFYHU4yzFac4SYR38BvJl2m7NzIlv98WMV9AMOtfQhu6OdsqiEleIbkguyZ+1HkfaGMBRRJuGFVEc7RQ=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1468.namprd11.prod.outlook.com (2603:10b6:4:4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Tue, 26 Oct 2021 06:45:54 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104%5]) with mapi id 15.20.4628.022; Tue, 26 Oct 2021
 06:45:54 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
Thread-Topic: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
Thread-Index: AQHXxc9Yl9XQBIG84UC2/NvO43tzv6vk1TqA
Date:   Tue, 26 Oct 2021 06:45:54 +0000
Message-ID: <DM6PR11MB38198F9B969569FDDD71A1CC85849@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20211013010617.GE95330@yilunxu-OptiPlex-7050>
 <58036b2d-ca8f-2deb-f1b4-0301d633714b@intel.com>
 <20211014014947.GF95330@yilunxu-OptiPlex-7050>
 <7d1971d0-b50b-077f-2a82-83d822cd2ad7@intel.com>
 <20211015025140.GH95330@yilunxu-OptiPlex-7050>
 <2b26bea5-60d3-6763-00e8-9a94fa0bf45b@intel.com>
 <20211018081356.GB40070@yilunxu-OptiPlex-7050>
 <301850cf-9f34-530b-bd9c-fbe9bf9feee5@intel.com>
 <20211019025356.GC40070@yilunxu-OptiPlex-7050>
 <85d56e4b-5bed-693d-4f76-027173a6e7a0@intel.com>
 <20211020011608.GA145760@yilunxu-OptiPlex-7050>
 <38cfb530-8826-7890-da59-c1dd33b9cc7d@intel.com>
In-Reply-To: <38cfb530-8826-7890-da59-c1dd33b9cc7d@intel.com>
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
x-ms-office365-filtering-correlation-id: 76ef3874-1663-4a97-055b-08d9984c424e
x-ms-traffictypediagnostic: DM5PR11MB1468:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB1468ACE34A1DC63C6DDFE7D185849@DM5PR11MB1468.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73FUP2MtE9w57Fit3PnGUxWLJ2SAKHEu4Uz2gj0fAWlmqlPor8tN2/ZJ7sqEpAF3HwHsIHL85My6n/BGFlHibAktdWDYVuTJKd83GUp5fr4yUFRcAdVFGgqLF7MuEc06sNpVqovpnn5ADen9NuORMryZdTT+6lgwzQ2OKHgU4BpohPZ8VNij366V+iDLbMG3yQHIh+KkD65P8NsjVMx95TeOgomBt4zOKB6xOP3QjVGYNtfZHb4NEb7ZyVBt1yYcrcUoRBfe7NQnjduGP490oBQuRsDBlDPcwqnFkeQNS1hrum/Hgvj+Eq5tSL2KX0buoQbRVRJzAeohqheubeaJgGL6eHnUO8yHwUSKoJdstqwVhez1twrQTpx270Z35eFQsb/hz9D+Okyj8uXBIala18+/GkQ8jJHCvrrEH0B5ARkP2sd8Me2maTXTydnDF2tYSJJIGB2fOyrrYAk3Ndg/A/+YUCfeyOnWF3Frbvt2J5ndB1wytgitZePL+VJjh5ETJw5oUlcMImjCcrqfQT50otex71EeoiUp0O/imj1vl+DD3/h/STDuNGpa841JGLn+IewhCuLgpRWjF/SJdHyZmO8an43/VN0kGZi9KDq5I8bGwHAJniRRlLW0a3gusq1tUjBF+SOyyCLlfE8QfL6PJVkYWIhDHYwB43/Fn+LiauFlT3bV1POyFzBjVzDnu7/dvOCsHqo+W6aRbnWXewmdKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(2906002)(110136005)(66446008)(82960400001)(9686003)(76116006)(107886003)(26005)(33656002)(54906003)(6506007)(66946007)(186003)(66556008)(66476007)(55016002)(38100700002)(316002)(508600001)(122000001)(71200400001)(52536014)(15650500001)(83380400001)(6636002)(5660300002)(8936002)(8676002)(7696005)(4326008)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXZ6Sm5MN0ozQ0pDZGMwQkZSZ204VkQydTFVUHdaeXY1czB4RngvOHdVNEpX?=
 =?utf-8?B?WVBGK3dBUTJtcEVwR1lieEI3T0c2eERLQTArZkZPTG1jR2hFZTQyKzZON1pJ?=
 =?utf-8?B?ZnhOUHpVQ0tIOFFWRmdzM2NQUnBLeHQwbE5lQWlKSUh6MnJraklsUHNHT2la?=
 =?utf-8?B?aXRFbWtuSE9Uc01VdVMrdVNXUEZRdzAraHpSelU4a1lCUjN1U1dGVG5iR0I3?=
 =?utf-8?B?UnV0blJzQXBZQjB6MTF0Y3paVjAzbTlXNkN4TnJNQ1F1UGVmY1ZRVkUzS2cy?=
 =?utf-8?B?RVNybUZRS05qMElhUUZoUVUrYzVURFV3NlBhejJqaWFVTzNHbHRzbGhTcyt2?=
 =?utf-8?B?N09YdTZTU0lXQkh6dHlUSHBpeTdXdnM1NHFNSWdoUm1PRzEwejl0NlV2c2l0?=
 =?utf-8?B?b3Z3VmE4akRGTHo1TjVibkdPdzhPeWtJZkpFNTRxOGFvZEtvR2xhVU4xQ3I4?=
 =?utf-8?B?Ylp2dWVrTCs0OUFZbklCejZqRXU3MGRIaTgyYWUzSGFobThJYWNMK0VYd0ph?=
 =?utf-8?B?aXpVZ3djTU9KQWpyUkl1MUZ0dHZqVkhRS2FpbWZuWUUxeVJWM0FXV2NEMWF0?=
 =?utf-8?B?TGd4R3Rzb29JbzAyakF5Y3VwZ0p0K0VSTFZ3Sll0UTNOM3lVUEJXWE5mZlFN?=
 =?utf-8?B?eTBSNE5jOTYvTEhvRTErd1l6NU9YZWo5cHhsSWxCZFYycXNuOFR3bVE0Z0U5?=
 =?utf-8?B?SXovM1lmc2pxMG5sVEZ6NEhWWGxwcVJoV1JJTHBiL2JNcHpaN09NZHdtTlNF?=
 =?utf-8?B?cGFoOW44WlFCRkhQOHRwRXZnQkxkMUU5S1NCUzdZYkd5MUN3c2VXdE5PMnJB?=
 =?utf-8?B?cEx2QVg0Uk81bXdYZzMza3JJekFiZmVzeFFYWXlRSWJBT1kvS2l4eGE2LytX?=
 =?utf-8?B?M05PTU9jRmlidmwwVURGVittSWlkZ0FVT3d0bGlTMi9ZaFhMS3ZUK1JicGZN?=
 =?utf-8?B?MTI2QVU5Zy9nMWZWZWVoUHNTYWFyMFBmWU9zQjNZcGJ5aHZHUU1zVEZrak5r?=
 =?utf-8?B?OE9xTDdOQnlJWmtLYU9nU3dVWkFjK0YwM1IzYmh2MUVkZXlOLzVRdy9Lc2dG?=
 =?utf-8?B?NmtjYm5mUWo2M3FGVWsvU2QwU0N6azgwVytqaTRJOVdwWjgzOW1KZEswWWdD?=
 =?utf-8?B?eVJHU3Zwb2xLMXpZbEJ1THZjaVMzSU1YdWh4bHh5WWEvWUw5a3loTVN3aThm?=
 =?utf-8?B?NlN3dExmbFY2bHdpVTBOcDN3c3NuL3ZDQWpWMDNFT3ZVWE8rL0o2RFBZdmU0?=
 =?utf-8?B?Z3JzNWprV2hQU0Z2T0g1NmtJYTdXRjdwQ3YyQ0VPeEgxTkd1aE5yOWJmR0R1?=
 =?utf-8?B?bHNFbTNSWVdrUnF2WDVqWjdxQVpteWR0S2xSbXRYN2E0UnBNYjBYeW53RFYv?=
 =?utf-8?B?MkRnRUtMdVNyVmdyMjU5TEFIS2s4Q1JIZEN3WVpOK0FESkZ3TU45TlR2NWVz?=
 =?utf-8?B?M0dia3ZPNUN3R1NBUXh3YVpoVEtvdHI5cFNwZ0EyTTRmanBTaUlkbnpZVi9E?=
 =?utf-8?B?N0x3VVhDV3Y2YjJrR24zMmNJSU14Nmt4WmU0RzZvcmI2N0hnVURjU0pwWDBn?=
 =?utf-8?B?V3BZc0dhWHN5NUQyL2g2NVVFbFBpNmhpaUVWZTV5ZXF5RUh5Tm1LTmpWZith?=
 =?utf-8?B?TUN0TUkvdlh1c2ZDZjdlalh3VFFaR2Q1L1RLZmg3MkRsMjc1Ny94WU8xOVJ2?=
 =?utf-8?B?TkIza213WndJc2JpL01kS3NkRnpDVXYvMTlkbExmL1lRak4zWXhWUDJ5OFd4?=
 =?utf-8?B?ak9zWjVwVFZuNnJaK2REVTZHTnFYMUMrNlNUbkNPaHBoVEpsc1BUL2E5ek9t?=
 =?utf-8?B?NGVTVUpuMC9YN081Z21yWUhwZnZRajMyU3V0elRaa0VxRFBZSGNUZW5uaFha?=
 =?utf-8?B?MUN1WHNVcFhHOWc1VHVTcnYzdnVOT2F6K1R3UGJnQXFpbFR4Sm5LTGg3QllK?=
 =?utf-8?B?dDJVV2hZbzVWQnVhbkxET2t5V00wTGg2RUpBZWhEMlNvNGltTElMMnNUTUV3?=
 =?utf-8?B?Q1ZRZjZBaitTaW43dlR6dmlFaHVmNEJSaE96dnhlUnpsY0V2dDRaZ1FZSjJX?=
 =?utf-8?B?YXk1dmlSSmNtenN5VXZuODZzN1VVNk9uajduUVArcitzMkgvdEpFWEZLaUhw?=
 =?utf-8?B?RzV1U2JVb3pjNU5DVzJQSnJoclZNSlBGcFNhYWhKOVdaRFJhMHlDS3Z2Y2Q0?=
 =?utf-8?Q?Yzx+/ot0OYCgtwJX9TtI0HM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ef3874-1663-4a97-055b-08d9984c424e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 06:45:54.6232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9X/qfgoEuBfYHfAVXztXuZwSdmz99AaLuDJuHPtX64tnOE7TPqqrxfOeCh9GXcbPHftF2QzzPF4/KtrWYuNOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1468
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiA+Pj4+Pj4gVGhlIEZQR0EgSW1hZ2UgTG9hZCBGcmFtZXdvcmsgd2FzIGRlc2lnbmVkIHdpdGgg
dGhlIGNvbmNlcHQgb2YNCj4gPj4+Pj4+IHRyYW5zZmVycmluZyBkYXRhIHRvIGEgZGV2aWNlIHdp
dGhvdXQgaW1wb3NpbmcgYSBwdXJwb3NlIG9uIHRoZSBkYXRhLg0KPiA+Pj4+Pj4gVGhlIGV4cGVj
dGF0aW9uIGlzIHRoYXQgdGhlIGxvd2VyLWxldmVsIGRyaXZlciBvciB0aGUgZGV2aWNlIHdpbGwN
Cj4gPj4+Pj4+IHZhbGlkYXRlIHRoZSBkYXRhLiBJcyB0aGVyZSBzb21ldGhpbmcgZnVuZGFtZW50
YWxseSB3cm9uZyB3aXRoIHRoYXQNCj4gPj4+Pj4gSSB0aGluayB0aGVyZSBpcyBzb21ldGhpbmcg
d3JvbmcgaGVyZS4gQXMgSSBzYWlkIGJlZm9yZSwgcGVyc2lzdGVudA0KPiA+Pj4+PiBzdG9yYWdl
IHVwZGF0aW5nIGhhcyBkaWZmZXJlbnQgc29mdHdhcmUgcHJvY2VzcyBmcm9tIHNvbWUgcnVudGlt
ZQ0KPiA+Pj4+PiB1cGRhdGluZywgc28gdGhlIGNsYXNzIGRyaXZlciBzaG91bGQgYmUgYXdhcmUg
b2Ygd2hhdCB0aGUgSFcgZW5naW5lDQo+ID4+Pj4+IGlzIGRvaW5nLg0KPiA+Pj4+IFNvIGZhciwg
dGhlcmUgYXJlIG5vIHNlbGYtZGVzY3JpYmluZyBpbWFnZXMgdGhhdCBjYXVzZSBhDQo+ID4+Pj4g
Y2hhbmdlIGluIHJ1bi10aW1lIGJlaGF2aW9yLCBhbmQgSSBkb24ndCB0aGluayB0aGF0IHdpbGwN
Cj4gPj4+PiBoYXBwZW4gZm9yIHRoZSB2ZXJ5IHJlYXNvbiB0aGF0IHRoZSBjbGFzcy1kcml2ZXIg
d291bGQNCj4gPj4+PiBuZWVkIHRvIGtub3cgYWJvdXQgaXQuDQo+ID4+PiBBZ2FpbiwgdGhlIGNs
YXNzIGRyaXZlciBuZWVkcyB0byBrbm93IHdoYXQgaXMgaGFwcGVuaW5nLCBhdCBzb21lDQo+ID4+
PiBhYnN0cmFjdGlvbiBsZXZlbCwgdG8gZW5zdXJlIHRoZSBzeXN0ZW0gaXMgYWxpZ25lZCB3aXRo
IHRoZSBIVyBzdGF0ZS4NCj4gPj4+DQo+ID4+PiBJZiB0aGUgY2xhc3MgZHJpdmVyIGNhbm5vdCB0
ZWxsIHRoZSBkZXRhaWwsIGl0IGhhcyB0byBhc3N1bWUgdGhlDQo+ID4+PiB3aG9sZSBGUEdBIHJl
Z2lvbiB3aWxsIGJlIGNoYW5nZWQsIGFuZCByZW1vdmFsICYgcmUtZW51bWVyYXRpb24gaXMNCj4g
Pj4+IG5lZWRlZC4NCj4gPj4gU28gd2UgbWFrZSBpdCBhIHJlcXVpcmVtZW50IHRoYXQgdGhlIHNl
bGYtZGVzY3JpYmluZyBmaWxlcw0KPiA+PiBjYW5ub3QgbWFrZSBjaGFuZ2VzIHRoYXQgcmVxdWly
ZSB0aGUgY2xhc3MgZHJpdmVyIHRvIG1hbmFnZQ0KPiA+PiBzdGF0ZS4NCj4gPiBUaGUgQVBJIHNo
b3VsZCBub3Qgb25seSBkZWZpbmUgd2hhdCBpdCB3b24ndCBkbywgYnV0IGFsc28gZGVmaW5lIHdo
YXQNCj4gPiBpdCB3aWxsIGRvLiBCdXQgdGhlICJpbWFnZSBsb2FkIiBqdXN0IHNwZWNpZmllcyB0
aGUgdG9wIGhhbGYgb2YgdGhlDQo+ID4gcHJvY2Vzcy4gU28gSSBkb24ndCB0aGluayB0aGlzIEFQ
SSB3b3VsZCBiZSBhY2NlcHRlZC4NCj4gU28gd2hhdCBpcyB0aGUgcGF0aCBmb3J3YXJkLiBJdCBz
ZWVtcyBsaWtlIHlvdSBhcmUgc2F5aW5nDQo+IHRoYXQgdGhlIHNlbGYtZGVzY3JpYmluZyBmaWxl
cyBkbyBub3QgZml0IGluIHRoZSBmcGdhLW1nci4NCj4gQ2FuIHdlIHJlY29uc2lkZXIgdGhlIEZQ
R0EgSW1hZ2UgTG9hZCBGcmFtZXdvcmssIHdoaWNoIGRvZXMNCj4gbm90IG1ha2UgYW55IGFzc3Vt
cHRpb25zIGFib3V0IHRoZSBjb250ZW50cyBvZiB0aGUgaW1hZ2UNCj4gZmlsZXM/DQoNCldoeSB3
ZSBuZWVkIHN1Y2ggImdlbmVyaWMgZGF0YSB0cmFuc2ZlciIgaW50ZXJmYWNlIGluIEZQR0ENCmZy
YW1ld29yaz8gd2UgbmVlZCB0byBoYW5kbGUgdGhlIGNvbW1vbiBuZWVkIGZvciBGUEdBDQpkZXZp
Y2VzIG9ubHksIG5vdCBhbGwgZGV2aWNlcywgbGlrZSBwcm9ncmFtbWluZyBGUEdBIGltYWdlcy4N
ClNvIGZhciB3ZSBldmVuIGRvbid0IGtub3csIHdoYXQncyB0aGUgaGFyZHdhcmUgcmVzcG9uc2Ug
b24NCnRoZXNlIHNlbGYtZGVzY3JpYmluZyBmaWxlcywgaG93IHdlIGRlZmluZSBpdCBhcyBhIGNv
bW1vbiBuZWVkDQppbnRlcmZhY2UgaW4gdGhlIGZyYW1ld29yaz8gSWYgeW91IGp1c3Qgd2FudCB0
byByZXVzZSB0aGUNCmZwZ2EtbWdyL2ZyYW1ld29yayBjb2RlIGZvciB5b3VyIG93biBwdXJwb3Nl
LCBZZXMsIGl0IHNlZW1zDQpzYXZpbmcgc29tZSBjb2RlIGZvciB5b3UsIGJ1dCBmaW5hbGx5IGl0
IGxvc2VzIGZsZXhpYmlsaXR5LCBhcyBpdCdzDQpub3QgcG9zc2libGUgdG8gZXh0ZW5kIGNvbW1v
biBmcmFtZXdvcmsgZm9yIHlvdXIgb3duDQpwdXJwb3NlIGluIHRoZSBmdXR1cmUuDQogDQpUaGFu
a3MNCkhhbw0K
