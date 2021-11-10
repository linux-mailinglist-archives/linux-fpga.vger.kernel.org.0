Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2036444BAB6
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Nov 2021 04:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhKJDyo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Nov 2021 22:54:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:10642 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhKJDym (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Nov 2021 22:54:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="219493199"
X-IronPort-AV: E=Sophos;i="5.87,222,1631602800"; 
   d="scan'208";a="219493199"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 19:51:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,222,1631602800"; 
   d="scan'208";a="545805437"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2021 19:51:53 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 19:51:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 9 Nov 2021 19:51:52 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 9 Nov 2021 19:51:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L22PN5KtyLujfsD2UqrrHZFs0nYj8hfpKlXK1eqjwUcMp0g1UAUUmYIVx+l9cYfXeu79bLzEpshMKuGApksV8O/mdKHrWgRJNO6h/xD68IXcSIqAng7xVJ9LBXYw9uX05ugXJGJ3ONxukez/tkYZRstQFPVfCtF3XmzwB30xBEZfuqI9Iqh5uRUUi/RAxYzn1AF8pXSHUIq8OPjn5bCI5ufBwE46QvTiGOXKApTsA0sdL7nKMuh6nKNjc2LL/3MS8Td5yJGHIvjqIok9x1KiK+0doExrV+Q4+rWLTt1KRHK6FI9rhby6yQueyak6Gqj/1yt6aWHcn/6TNnppwDo3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXlV10NvEmqWuS6XL1Q2HM6E0CQhR+DpLgv+tBJjwk8=;
 b=WkBbv2lgAoAwBKy2KfhpqCjQJYtOElWtwaTIdNizGYffdXdBbOGrbuHnp8LLe8eo6Wm53hdHEIrST9ldqoWfJbAW09POxab278wRM5XvtRTeoFHwd18TtepW4Oc/iqJKahW9zqKxESQvnJ4qyjkJLw+KG9+YmuvCWvYgOFGDFULEjdAO8Eohbg3vlvYo3tNfDB/UsasnWYn0t5z4tfvYh1SV8ArPkW9UNh62LKfIWOmGq+6XuvXz5gfq7Vn/be1pLa6ZmbRSjyHrKv+0mEJqpYPWQm/CVtMSOiareZnZ+olwsOfiCavDYydJapmF7RgL1P2w9IlLa2L+K1M5ByH6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXlV10NvEmqWuS6XL1Q2HM6E0CQhR+DpLgv+tBJjwk8=;
 b=s1YAnGjykEcs0I9GrIhzp9iEl9orQutMQGhc+9euBPGxdJdd5a7CmKS40CTpQpKa1zBqBJ+JR8Jaeqye8x7Z5GvIyTKQTno/CW1/9QbcCYwPL7Ncul0zAARQULXJM6+mG27Dmwwp3T+zqhY7kBsNQ0Ra6xY5PtiUY8fwfkJ/IqQ=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3002.namprd11.prod.outlook.com (2603:10b6:5:6d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Wed, 10 Nov
 2021 03:51:46 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104%5]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 03:51:46 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Tom Rix" <trix@redhat.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
Thread-Topic: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
Thread-Index: AQHX1YBKbMaksR0LYEaXc602aNIT/6v7WX+AgAAkWoCAAAYwAIAABpeAgACNMUA=
Date:   Wed, 10 Nov 2021 03:51:46 +0000
Message-ID: <DM6PR11MB381971C2FDA4AF1D024C4D1985939@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
 <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
 <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
 <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
 <alpine.DEB.2.22.394.2111091044060.1548144@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2111091044060.1548144@rhweight-WRK1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80654db7-3978-4278-b712-08d9a3fd6ac6
x-ms-traffictypediagnostic: DM6PR11MB3002:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB3002E47C58FBA6D09110E13A85939@DM6PR11MB3002.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TlbUGdqsK4BFYyIyioquDJ449NJUlKRO6XpIO+Rn6lNcaxm2bfSwfOTuRul/2q38ngI8GKj2RMnR2CEs9LSocPp1H9+J2InKQ/3IWzrD1huZ/RvwItLbv3ifOFoz+A4XSxmdFKS9kY2yTeyuBTopiIpSteFnz1GaOzc54s6wwoxa/7lzEjC1738me/Bo94M6gd4fsvsMVY02cSO44CrEjpEX8tXgz5OI3V2kJVHeKs/+p0p93rqjZ2VhcVcMjwFHNkIPkam7RVPISLLFH5wHmwoN+NeMvMrhaI2auHAnSnF0MpgMQK+0GdWjtEykyATvqVVuudqDkaYGWJU7eDZ40BOqUZg24abPw+zrRrkRTCiE/5Hdxc2TPsBfFSalqtQODOvCNTk5kJOAN3Sf2Expy1cZhpnPzrpuJNkcswer0YrTbR/ZqSvUKR1naCGzB2aj9ofMTqRNe5gzteV1GqwpPOO+/3NCQDRX02h3cjRFrD8LpXnnpHqfuBM6HIsN7jrQ2H0LNoixcCwwMxxRkiKFU0CoN+t6Lh5PiWPpTAtSqjfHdXOxUf+2DyXGJbZvX1gMmcI2G6c6h/9S5HoYJKK/Rt+/P6mhw3rxzOr94rNgNhsdBHK/PxrrrAc+GubSvyUGNulVtCOQ2ODuRW8QTeUAJqQ6Ehwyilrl2DetkZIujmJKKLaWZ1aJasGYCMh2wZ1Mu4p370yVIQQ/3WBGTpYrDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(55016002)(110136005)(7696005)(6506007)(52536014)(71200400001)(4326008)(66946007)(5660300002)(2906002)(508600001)(38100700002)(316002)(66476007)(76116006)(66556008)(64756008)(82960400001)(66446008)(38070700005)(54906003)(122000001)(33656002)(8936002)(26005)(186003)(86362001)(8676002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g0NRfGvi0O22wqHfAtgoKa1dm9fOBTV9E+2nPnLC/cd7ks7nv8vJMtCferww?=
 =?us-ascii?Q?IZlmnF6TJ4ok+usq/tRCyiXItJahVFuovSxxGl7Boqs/cmgBuK8aPGwqupHY?=
 =?us-ascii?Q?fDPxVyJOZx1g01jYz0T8GQAxfJl9/KEhm8iKlVPNjipM+QYf77b2u7/ag1uh?=
 =?us-ascii?Q?FMiNVxUxc68rnKgpyICDAFz1yw8wdCv+JNXvYLgAasrfYHLF6aEVMUxX5b3W?=
 =?us-ascii?Q?iwPikG2D0kzy8aOJIgDlTDJdlwj/gvH6Bxm1LO0pGw1PGpwy9NTa3Yd4k2N/?=
 =?us-ascii?Q?AQupVJ4o1Vey4ML2Rx6ulc7dD0zL82LksitCm4UHqQrBl12ywpZd1MmqPyBU?=
 =?us-ascii?Q?KgAojIHTw5uVs8f2DqclUaqF1PkUywxpycRCMXOeOA04+XwzbVFrV4qDdidk?=
 =?us-ascii?Q?iDHWRvqWysHT9aJf7XKzuiU3IHCp9GRyrUt1JecgX56x1P/h23HeGxgnYMrW?=
 =?us-ascii?Q?tYvcms1hNk7oX8CYE0Aer7z/qlq5wEBI9RxL+f555cR9P0yThOEy9qyWAuUi?=
 =?us-ascii?Q?ip4iFwAwLKHpb3z+WIVu8GFh9qv5vbpiuL0e2vlsYkHp5on+OZ/wKqGC84vz?=
 =?us-ascii?Q?ohxzRUlLEM2zj1GH88Lu9sofTpYYJG8Y/jbRP/aMkEWCqqCQZowuNojgBAkY?=
 =?us-ascii?Q?qARZDBRpFga3Wt2V3EGaAq/X9Hfq1udv2j+va5PnaLiucLu+7jxXLnK2fuC5?=
 =?us-ascii?Q?d5ijUN129qG6LaPiPLgIHSqDh7rW/nDMzza7yatuUxiUyikK+9iiyCP9HHAG?=
 =?us-ascii?Q?hwwHE3gnh6ibjxICCkvyf7kVWNCTdvlmCoDdUZcQelP4oPtSt39Ag4BI34BM?=
 =?us-ascii?Q?6tzlf4KtLZQdckSx9RLQlVpFCJpNkSGHC3KogCeAmSCPn09C+bGTOPwCL02s?=
 =?us-ascii?Q?Nyz0b3ein8eLmGZrr0f0C5WiNyYKzw+W7UwJJLS6prAopb+sZBiSktaC8qX7?=
 =?us-ascii?Q?fxOzeDDY8BYbXBIK1Jj4MjhSikAHqXTI5Km4Vh3unIdxUYIJg/Gn8bwyZACj?=
 =?us-ascii?Q?cS2tQu7zNm+YMK2y+wf3HhX77fYqvJLOlhvG/lTW7eZz29FdFZQPuJwZjmhW?=
 =?us-ascii?Q?AOLlRTS9/6mVWLMSHoFuWejoZ836H07TUJ/ZhfX1x9BWeNJYu8X6SNINDLH9?=
 =?us-ascii?Q?USdAPruinmxp8dBxTCOxkwa/kIF5VXA68VQHl10IhB3LDzWsTDUd/1fYG7kC?=
 =?us-ascii?Q?45yGWZZQlb1mRn+UrToDKuleSSw5OpaJ6FqzgMsHcpAkrKHgS/IDazwXEWuC?=
 =?us-ascii?Q?0a7wb0CAQxboYTo2gBNlPRDuOUv8MLdNdph8IMvEDs7WMdBw7jYHPwj639Fc?=
 =?us-ascii?Q?aBNBR9Cob6s8W7C2PGx5u+sEyjinYjheY9EpwdJ0dVx76qp9E12PpaDWs0Bp?=
 =?us-ascii?Q?CV0PVYKbr3l6abYioNYmmuoOFAvj62CEFuTqrsJejLsle4eRYZzlAHEnF8qa?=
 =?us-ascii?Q?YRI2I6gVHIaTm/Jd/treQKbISugkDcaQisikecEC/e4t3lDU744Yn17gXm35?=
 =?us-ascii?Q?Dc32S6XzpsM0LZE5ne/a3W2vWiFwHvwFaiG1sJtVvYoN3G8PSQG+l+epfQYK?=
 =?us-ascii?Q?0uPcgic1LYaCQmbcUtwnhQCp8Qy/K59Wap5CI0MfnjsUMbPU0tO2OYQHXobJ?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80654db7-3978-4278-b712-08d9a3fd6ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 03:51:46.2247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiGIeaE5UYSytmuWzXhkN5/mbWWPfm4IWIuDBms0IF8KuDOJiJok+X2g4L2UgBVqlenzCP0OsPQlK6bpVhJJog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3002
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Tue, 9 Nov 2021, Tom Rix wrote:
>=20
> >
> > On 11/9/21 10:05 AM, Andy Shevchenko wrote:
> >> On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
> >>> On 11/9/21 7:41 AM, Andy Shevchenko wrote:
> >>>> Currently the find_dfls_by_vsec() opens code pci_find_vsec_capabilit=
y().
> >>>> Refactor the former to use the latter. No functional change intended=
.
> >> Thanks for review, my answers below.
> >>
> >> ...
> >>
> >>>> +	u16 voff;
> >>> The later use of voff in pci_read_config_dword is of type 'int', it m=
ay be
> >>> better to keep voff as an int.
> >> I don't think so. The rule of thumb that the types should match the va=
lue
> >> they
> >> got in the first place. In this case it's u16. Compiler will implicitl=
y
> >> cast it
> >> to whatever is needed as long as the type is good for integer promotio=
n.
> >>
>=20
> I think u16 is more precise than int, but I think it'll get promoted to a=
n
> int anywhen when used with calls to pci_read_config_dword().  Was this
> change tested on real or emulated HW?
>=20
> >> ...
> >>
> >>>> +	voff =3D pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL,
> >>>> PCI_VSEC_ID_INTEL_DFLS);
> >>> This may be a weakness in the origin code, but intel isn't the exclus=
ive
> >>> user of DFL.
> >> This does not change the original code. If you think so, this can be
> >> extended
> >> later on.
> >
> > I would rather see this fixed now or explained why this isn't a problem=
.
>=20
> I agree that a single Vendor/VSEC id being supported is a problem,
> but I think fixing it should be a separate patch. =20

Yes, I think that should be a separate patch.

> Do we need to change
> this a table lookup of Vendor/VSEC id's, or do we need to reserve a more
> generic Vendor/VSEC pair?

No, we don't want to maintain another table in DFL code. Let everybody appl=
y
some new ids sounds like waste of resources too.

What about using DVSEC here? then other devices can reuse the same DVSEC
without conflicts. This is what is done for other Intel tech, e.g. Intel SI=
OV. But
anyway this must be captured in DFL spec firstly.

How do you guys think?

Thanks
Hao
>=20
> >
> > Tom
> >
> >>
> >>>>    	if (!voff) {
> >>>>    		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
> >>>>    		return -ENODEV;
> >
> >
