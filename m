Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443A545C95E
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Nov 2021 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347615AbhKXQDO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Nov 2021 11:03:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:6130 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347727AbhKXQDK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Nov 2021 11:03:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="259191533"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="259191533"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 08:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="497717969"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2021 08:00:00 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 24 Nov 2021 07:59:59 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 24 Nov 2021 07:59:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 24 Nov 2021 07:59:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 24 Nov 2021 07:59:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEtX0vHKZNBiWc+WCAfOWompJwQejmBaWYIUHvWSkJPRfvbz8H8sI+21j77thyACVPZsRCE+fC+xtSBZbH0sGV21adRxVdSshJhgMa3WppQT5ztnA93vxiRwFn71vR7BLxU+T6UxE5eUIURxtR5D9aerJGMuDLmAB4GxqD+vHK9V498fPd7D5JMPA4t1MPLJ95zpZoKH+M8HJBDQYpLlYJ/6JzSR2P+ksWbOZ1B+Wjs0cVe7yutdDsfc0RcU9kTnFE09C93pInOtwzbuD3FZd2B4/dIds4NdZJV3sdHaShgPrhnP9ku9Br1FfVrVAv936Hjgp4Oh/PIIbKaWSFsnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plOZ1EkOZadHceN/79V2yVloE91nAg5hGKr68fUz6w4=;
 b=Bx27H12hnQ5I8elz0N3iUiQFTvIh4xK4qFKgGhUHIPeKgpH3bjFHxSo9BjeiOsrWI8e5DYBOEX8X2WaP0SJmBAVISTRCG+GYILr6Nvm8TzKff1yaQDOtjLKB5mlC5b2lxdcXWhwS+w8kl/HreH4IEqNF75CmyPVxcWD4ks3jx1oTz7EDuLCWn6yMG5My1mbdjFXo+ZH1MyVmFOMkmeMMJDj452FTIV9doIoVwKetxzM3U6pTA007I0BFt39OB6D9eeC1jU/Tmpi6AAyjbTXBB8X3MFqAeca4mFC49xz/j1ZRj1ib+SC7RDGSRPkIfmSqqp564/ImZt9Jk2DiZn7VUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plOZ1EkOZadHceN/79V2yVloE91nAg5hGKr68fUz6w4=;
 b=iH25TFLjnuN+aLaIdw8bs/RJ2+t1phUWghVoJkad7iwhCmdvN44SNx9xJBJOE1Moxpi7MEiQWq19prt4vk2/gz3/qt5/9IKo7/c+wp7sbZiOebw8d/Tg4JU4Iztz8LdREr0lPDX6c9/KCsLFMeHyRoKou2yW64gWvCzhwFk00yI=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1851.namprd11.prod.outlook.com (2603:10b6:3:114::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 24 Nov
 2021 15:59:57 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104%5]) with mapi id 15.20.4690.027; Wed, 24 Nov 2021
 15:59:57 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] fpga: dfl: possible ABBA deadlock in
 dfl_fpga_cdev_assign_port() and fme_pr()
Thread-Topic: [BUG] fpga: dfl: possible ABBA deadlock in
 dfl_fpga_cdev_assign_port() and fme_pr()
Thread-Index: AQHX4D/TTtA7wqupLkSB90dMoQlpnKwS1fcg
Date:   Wed, 24 Nov 2021 15:59:57 +0000
Message-ID: <DM6PR11MB38195CE729A5765E019C226285619@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <9460c1ba-addd-9757-fe55-ceeeae596ac1@gmail.com>
In-Reply-To: <9460c1ba-addd-9757-fe55-ceeeae596ac1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f9a96c0-75aa-48bf-0c7c-08d9af637683
x-ms-traffictypediagnostic: DM5PR11MB1851:
x-microsoft-antispam-prvs: <DM5PR11MB1851C9235D75A8E278218C5185619@DM5PR11MB1851.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t1cbgbxYT1R99mu8V+2TuGeCQlwvno39RjBVd03QPSMcxpozvbykfvne3uQb4u+ZHgbxxGYf21BRrNJrzGS73LblaMIJNrJjxfoi4DePPhJJ7ts63MjpAN/uh6whOQjRcio7xpWXHbRMOy31hhhwh/Ap6sXkxY7FDi7tV1sC6+1wRsg/Hnl1Cqjj1IvAnLAbfzdyc0PQxTI0WjdsHgRyISJK3B2MlyAU2U9dazo0n6r12Q78INpSGZxQw6yKoT11AzskDlUke4PGSbLOoFmTiHZIuit4wL/Ya509NVapA9HIQRAIS699demW/2BhznT3Fj1/ImK8BYKyzXiEbRO7dMa1X3zvWbEoz9ZJnZXswqW+SEgCEdENDZbFODordDcJzegXGD7Od1ROg85HVzkeqHNUtrVAYlJQO+ge6yil9LwNac51dxNm3R/QguohgKbNPzlKvuvmSIEXYf4K3xzR6dcfuHfe7HeIMGA5/K7kKHg9lIAISGXAeIcMy9t7afL9WVervmw0UlaL6VrIEwXRfddsU5tWANq5H41mMuLrQLcAcIWp93YP+inFYFplLZYnk32SaKEnCO6rYlqQSIxS2Jfx9UnBeUl2kOOj3DDkP9kQk0pnkWhne4jq/lqmUC9hgQfdOhMxD94wzIIsWtntO9DTCjmNMCmALta1IlrpQLKv5esLYIqdI/Oyv90teoZ2ZRUVln7wPpUK1C7JAAwfjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(508600001)(82960400001)(66946007)(316002)(38100700002)(66476007)(66446008)(33656002)(9686003)(7696005)(4744005)(5660300002)(52536014)(86362001)(8936002)(83380400001)(64756008)(186003)(2906002)(55016003)(122000001)(71200400001)(54906003)(38070700005)(26005)(8676002)(110136005)(76116006)(6506007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXlTc0RiaE9TTW11U0tTaVcrNzl5b2FJcElzYWFmWmpHalNwTldZbEkwek53?=
 =?utf-8?B?YUE5U3p4RHJvZE1hSkk0NTlUUllZenlhT2hsc1BTMlFWVGgzT3dOU3RGcjJG?=
 =?utf-8?B?K2hmaW1OZi9wYzRLNnRRWXZWcEovdW94TnJOTDlzVE9TazlhdlphZW9Lc21E?=
 =?utf-8?B?Sjd4dUtKcGJweTd3cTFLdkhKUnovc2lmT0pQWW5jMmgrM2JLWkUwWUJkbHBX?=
 =?utf-8?B?Vk81aCtFaWFMRmMrcE1sRnhYcTZrNVZNUGVVUFNBcCtuMGRmRlVFUjhJdk1S?=
 =?utf-8?B?aFQwN1pTYmdHMXV4T0ltL01iSGpvdm1aQXQ1N0pXRW12dXVPa2orcVpScHlp?=
 =?utf-8?B?MXdPNFcyWkMzRGIvT3NJTk1zeHVPKzd6cE9VUUI0QnBtaHdhT3ZrQnYwRmdF?=
 =?utf-8?B?QVRXZWpEd2svLzY2T29EaDhJWko4R1Urd1VibzJoM0NudktpWVQ3MmFxOGxD?=
 =?utf-8?B?RHFCc3BXK2o5bWpYTVNSVFcvUUV5N2xwNXpUaHVWcklrUWszTHVsYjdCanA5?=
 =?utf-8?B?TE54SnUweDlsdzlBM3ZzOWQ0eitEa2NaWk8xNDZoTXNQVHlpQ3B6R3Vydkov?=
 =?utf-8?B?NGkrbG9ZRlliQngrK1RCRE5JYnYvc0R2Zi80WUdlbnMwK2hjMm41L2p2UWJO?=
 =?utf-8?B?cllsbU9wK2ZiK2ovN1F3eDN3NnZFcWh4OE1Rc1lsYnRxSndqc3djT29zZTdQ?=
 =?utf-8?B?ZW1HMEZDQXc1N2JNM3Z2dlNodi9ZK21rdURCZWFhZUpvVDg0QWpBTlR6L2tE?=
 =?utf-8?B?TWdHRVpMT2NIaWlVQ0M2bk5nZ1VvU3c1YWxkUmttSGh1akFjV2IzOG1wRCtp?=
 =?utf-8?B?Rmk5MGdXRlBzNXdmN2Y0U0RkR29ibDJOeEhMOVJ0NlJ3czNLeCtwV2o1WVM3?=
 =?utf-8?B?Rmd3MUpKOTh2cldya1lmcDhabXNyWGNKTDNHS2RnRWxsSWsxMlh0TGM2cm5S?=
 =?utf-8?B?N0Y5czZNQnRkSndlQWFhSm5DcXYxak1obFRTcHUwSm5Za1ZvckFWYWFjaVZz?=
 =?utf-8?B?NExNdjNNN2Y4aEovWTJ0dXpVTUtldTVnUHRpVlFBVDRyRXovWmxFRjFaSjhC?=
 =?utf-8?B?RzE2NTRTdk5FdW9mYW8zdlREakFIenZTKzhQNGlZSS96S2F5bDEwVHJGSjJV?=
 =?utf-8?B?b3RjdWFGbm5IQ0FINzF2d25jUkZaOEhZTExHc0dISU9IK1hmMmI1cGMvSkhY?=
 =?utf-8?B?OWsyK3lLZlFIcUZOSTF6blIyNEVSZm9ySkRzMEhucEN2SFZBdERLTXpXVFR4?=
 =?utf-8?B?SHJrMk9DOUlmbGdQbnBHK25mV245RWsxZFQxemN6OURXcm1mY09MWnFlZS9z?=
 =?utf-8?B?MkFQVjlhUmp5UW15VHQ4c2xKeGkreFFrTHozZGhGNmNYa0tVMHBzc3c4SXA5?=
 =?utf-8?B?SjY4Wkxab1JFMUxmTUV5ZzNKdmcrM0doQnBtdDRNOU44ZGZLenJuczNvZURZ?=
 =?utf-8?B?TEJiMWtTMnBCTU8wV0drQWJ3VngveHVKVWVRclQ5ODZydFVpRlJZM1JMbXRN?=
 =?utf-8?B?QStWbk9JdVF2R1l1dDVrY2tNVWlFUzRBc3VoVUl3bHNhUzJwVXg3Q3p2MEhL?=
 =?utf-8?B?UlIxT1BIMnJwOHE0amZXQ2NJWkd5ZFhraDBJN0hLNDUxM1VVWDd4WHBWQ2Js?=
 =?utf-8?B?dWRjSUFtNXZLOWhNOFNuK2RMd2RzVVgzYytrcWNpL0dvN2tjZ2ZyNWRheEdu?=
 =?utf-8?B?RlNkaHF6SnQwNy9mU0Zka1ZBSC9zREljNTBDb3kwMnZGRzU5aldFbnQzbnAz?=
 =?utf-8?B?ekN4bFoydW13WFBXZG93NU1yZGpBajRScTVtQndHcXQ3NGFheGFoc0N6dUV2?=
 =?utf-8?B?K1BWMWpoWlQ3bUE4QklDdU9zc0UvNk5Ed2wxejVmYVQ5Uy93YzZ4WjlKVGd3?=
 =?utf-8?B?WDhUcHJSZFI5R2FkUnMxV00rR21uMW9DRmdLWG0wdE5QelVsZ0pMQ0RHM1hR?=
 =?utf-8?B?eTk2dVRBZ1dHdERIbTRoYTBwdmU2djR1c21pZFhIMkk4ckxLOXFIV1lEeUNo?=
 =?utf-8?B?YmFVd01ja2VwZmdSMHRXbUg0T2thNENIa1UwQnoyeVZoTmtWYnpHbGRrUXFM?=
 =?utf-8?B?aFRXWDdPUDQ1c3FaTGpBR2J3aWEzaWIwdlh2R3V2SXM4VGIyWm1OTnVQYzZ1?=
 =?utf-8?B?ODVaWUUwZDJVSjB6RmxqZ3ZRUEpSNlVIUmdwbTRKNEpaT2dWNDM2eEc1ak1R?=
 =?utf-8?Q?N26DbB+uK/HBR/YZqKNc21I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9a96c0-75aa-48bf-0c7c-08d9af637683
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 15:59:57.3249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dTYudMftDENCGScOaw22Tm42E+tekFY+USD5XwZeVkC/QbVC/h/BCFF3Sxsk2pe04n9VmK21xVKYIniiSeSXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1851
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiANCj4gZGZsX2ZwZ2FfY2Rldl9hc3NpZ25fcG9ydCgpDQo+ICDCoCBtdXRleF9sb2NrKCZjZGV2
LT5sb2NrKTsgLS0+IExpbmUgMTA2NyAoTG9jayBBKQ0KPiAgwqAgbXV0ZXhfbG9jaygmcGRhdGEt
PmxvY2spOyAtLT4gTGluZSAxNjI0IChMb2NrIEIpDQoNClRoaXMgbG9jayBpcyBmcm9tIHBvcnQg
cGxhdGZvcm0gZGV2aWNlLg0KDQo+IA0KPiBmbWVfcHIoKQ0KPiAgwqAgbXV0ZXhfbG9jaygmcGRh
dGEtPmxvY2spOyAtLT4gTGluZSAxMjYgKExvY2sgQikNCg0KVGhpcyBsb2NrIGlzIGZyb20gZm1l
IHBsYXRmb3JtIGRldmljZS4NCg0KQWN0dWFsbHkgdGhleSBhcmUgZGlmZmVyZW50IGxvY2tzLCBi
dXQgeWVzLCBtYXliZSB3ZSBzaG91bGQgY29uc2lkZXINCmltcHJvdmluZyB0aGUgbmFtaW5nIHRv
IGF2b2lkIG1pc3VuZGVyc3RhbmRpbmcuDQoNClRoYW5rcw0KSGFvDQoNCj4gIMKgIGZwZ2FfcmVn
aW9uX3Byb2dyYW1fZnBnYSgpDQo+ICDCoMKgwqAgZnBnYV9icmlkZ2VzX2VuYWJsZSgpDQo+ICDC
oMKgwqDCoMKgIGZwZ2FfYnJpZGdlX2VuYWJsZSgpDQo+ICDCoMKgwqDCoMKgwqDCoCBmbWVfYnJp
ZGdlX2VuYWJsZV9zZXQoKSAtLT4gZnVuY3Rpb24gcG9pbnRlciB2aWENCj4gImJyaWRnZS0+YnJf
b3BzLT5lbmFibGVfc2V0KCkiDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqAgZGZsX2ZwZ2FfY2Rldl9m
aW5kX3BvcnQoKQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdXRleF9sb2NrKCZjZGV2LT5s
b2NrKTsgLS0+IExpbmUgNDk5IChMb2NrQSkNCj4gDQo+IFdoZW4gZGZsX2ZwZ2FfY2Rldl9hc3Np
Z25fcG9ydCgpIGFuZCBmbWVfcHIoKSBhcmUgY29uY3VycmVudGx5IGV4ZWN1dGVkLA0KPiB0aGUg
ZGVhZGxvY2sgY2FuIG9jY3VyLg0KPiANCj4gSSBhbSBub3QgcXVpdGUgc3VyZSB3aGV0aGVyIHRo
aXMgcG9zc2libGUgZGVhZGxvY2sgaXMgcmVhbCBhbmQgaG93IHRvDQo+IGZpeCBpdCBpZiBpdCBp
cyByZWFsLg0KPiBBbnkgZmVlZGJhY2sgd291bGQgYmUgYXBwcmVjaWF0ZWQsIHRoYW5rcw0KPiAN
Cj4gUmVwb3J0ZWQtYnk6IFRPVEUgUm9ib3QgPG9zbGFiQHRzaW5naHVhLmVkdS5jbj4NCj4gDQo+
IA0KPiBCZXN0IHdpc2hlcywNCj4gSmlhLUp1IEJhaQ0K
