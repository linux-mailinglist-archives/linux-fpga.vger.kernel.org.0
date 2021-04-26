Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2B36AAAA
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Apr 2021 04:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhDZCkT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Apr 2021 22:40:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:59603 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231550AbhDZCkS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 25 Apr 2021 22:40:18 -0400
IronPort-SDR: Q6Ocy3OexFOcbWgPmG2vpNbaztXZcyY7xNmqJCfN0rgjvXYkQfey6xgBLhu+ndry7C5ymTMHqN
 H85j/170Noow==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="193085009"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="193085009"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 19:39:37 -0700
IronPort-SDR: yPokJM+edFhLSi1AUvgzIz+eO5yACVbz2b6DGVcrsSrBJ+Dxg3u5brK9ZD8LH8RzjzAtyCew8X
 XQx4RzKdcfoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="536050328"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 25 Apr 2021 19:39:37 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 25 Apr 2021 19:39:36 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 25 Apr 2021 19:39:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 25 Apr 2021 19:39:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sun, 25 Apr 2021 19:39:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjniNg7jJHdzmSc1thhXScYjlzm7k3N4ORCTgtm2xHphykSf7HeSZ6kch/qSi+Y8wCGTOH+RerWg+Rt40n9byzzb5wjdIZdaCd7GMAJZ5/YJyHIMeybnxCfA+8FPjn/OkhGWRFYmlPnNEDnBucj0T990MkAiolE0Y/MKtl/WCxf/CgAYgdYzQJbO3H8pJwz3FccjVxaZM2Om/hwSd+ZYYrhXyLILmqwmbc0kkCWr0Z7co47aHN8FDBTROL6aJiL+epOys8TT+dpf4Cc37yZbe0GXYqA0ABmzYg4miK9lolJg2rLc04LeDj/XUmBpIJ1L3yMmUUMr42dwiEacq4t6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT41eE+QNkfL5FWW1H95IBhmMLx4JKzRVNTCBReZ1Mk=;
 b=UVuETRMb0XkTQGA8i6Dcz0ifchqqN/wDJCHVQgx/8ULuXXd6nW5e+qEYalCQ1YIPcccxGDwNzZb7xnJuVAfs64so5AhMKT9XKQOWkmkKqCFfICjjiFg7aCH2iSyLNCoU8wqzMeCelVJtPBEn8CoJBrLKjEC3gkfLqsQQwVx33xOYsqpYj4cLbeUJiGM0I68NGwWw/xDdqQiotzZNGYNcmSqDdY6ywnPyIyj7QBOISGc8RMg7PYEasJz4mpmdQOsioF7c8rg80Fx4OQAwE4KnCXED5sWp3YFPY0WW/3IuOADRDJLLxSDMPrW/u0+Gk9JcL06h01Cit/2GubQlx3xKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT41eE+QNkfL5FWW1H95IBhmMLx4JKzRVNTCBReZ1Mk=;
 b=f547VBo+Dp6VB6r1WdfZnVhPut1yqsDIgAW86c2YHqkv+MlNRUt2ThFsHTVF6l7q5EwOcX/JTaGxGssuD/huLpgXZMsInZudA9Xh5fVzzmr/qCJV8v1Zx1eDNk7kADANuhlnJVjUaOhcm5WGriA2zMEMdhJIYyDTKbFA5oVbZ9g=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 02:39:34 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25%6]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 02:39:34 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>
Subject: RE: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port
 entries
Thread-Topic: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port
 entries
Thread-Index: AQHXNgpK6sZ5wt8PgU2xWx05XVpyOqq+btGQgADGhICABuPGYA==
Date:   Mon, 26 Apr 2021 02:39:34 +0000
Message-ID: <DM6PR11MB3819A3CFA58B11427E813A2F85429@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210420172740.707259-1-matthew.gerlach@linux.intel.com>
 <BYAPR11MB381637F0EFFAFD57902EE47985479@BYAPR11MB3816.namprd11.prod.outlook.com>
 <alpine.DEB.2.22.394.2104211001080.760078@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2104211001080.760078@rhweight-WRK1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15de05d0-02e2-40fb-aa50-08d9085c8723
x-ms-traffictypediagnostic: DM6PR11MB4674:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB467459CF118409D4AA79755385429@DM6PR11MB4674.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iWRPxNT7bgR4PsUYLP7hUtYkVY7fOCzH2+cy9lKnDzuJzO7Z71UNCXKnQVXl0lJ/AO+VBN+nn6/4FR5/xD2I37L1Tv6Md6llmGLkufGPZJPYSn/TjRsP3RXF/nx9m8mnz/Cmf1YV7HgzqufY8RgTiHT6fy5qx6ImfpWTYihYmtzzA2EIVN1+fijG2uhjxypPv05wYkemXjneKxJrODHYjZ5ETj8p2FUismoWHmmxLMLZQW0K2+xramy2wRleUoQs0q6ik8+ajX/z785T1zhf2Q/IQmmhpzzkq4IEH0mZf4M86OqZt3q2wbp+52S6I4JpD7Grtm+eG7rMFKCLpAhf8y01q7C+LBpDlBjNbz1583i2pvtek6/OIS9ta73wi+91VTLMOVJNJAMWMnoXvuXs20NQCdfOLGVqKmGYkfRCDXpnDUizchfh0V6hYuUcKmQIUhQGuMxS2wovFN/M9wyHlYi9M/rplekcHnMjg4xazSCdSrSQblPaXjk4SPOTmRo4gw7dxIEEFQKVPWCAQCDkKnFdjGlvqJGEZwuhsM5kjm0Qzfb4SsqlmBkTKwCrLeujXz5H8H8f63A7fxOOA/rYq6t2uCnsVl+vwLPlyXXxzJQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(396003)(136003)(478600001)(9686003)(186003)(55016002)(26005)(2906002)(5660300002)(4326008)(33656002)(66446008)(8936002)(66476007)(66556008)(66946007)(64756008)(76116006)(6506007)(71200400001)(52536014)(6916009)(7696005)(86362001)(83380400001)(316002)(54906003)(122000001)(38100700002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q53HaJoCPN+O2YqVbBNMeqgfLcZHX0j2v6mK8yUrJ5xg6Fjp3IU0BO+sYo6D?=
 =?us-ascii?Q?lws1c2GGjbCSnEwoHqACrrzYYVOQ2ztCrp83hXHMNDCfB8a/Rs9RcwzCzWG2?=
 =?us-ascii?Q?hr+OC/UBt6aH+NZOvzWsnC0ZtA5/A2zKjWgsBFN+qnktzC7ZMVA67xdFPiZB?=
 =?us-ascii?Q?Q198w/qqZZZsPBGUZPVyr+B6YGsdY7b8XAbgOwB0aqTC8m0v3xR1PvSrOa8d?=
 =?us-ascii?Q?g+d5ypREFHmzZamEk67+K9GerOpHSJhvUIyVpkYLnHOgE8VhrEJg5eqAeF+a?=
 =?us-ascii?Q?TpwdRcNiDdQKodFInobeYoFlfu/Uuw90psfFJUED4sIyjdUQdqyX6z3AnPFK?=
 =?us-ascii?Q?x8iTyn8ilGgeqmcUV9hP5GEIXS/NRpEWrEwr78cC3LU9qKxYbOkKxzR1HNXv?=
 =?us-ascii?Q?5waHUobvTdoHioDXGfy99yAw5JvXdoYpgjzUK2Y3iWGJ2DizVFxKdGFhK8fW?=
 =?us-ascii?Q?O9XSYu/9XNqtQ1DZLMbokIEKYjgtMKoVqdLYnzoPA0iom/OPs9nVjaSphNDR?=
 =?us-ascii?Q?Ki0n6UpHHdkDZmO5z/HOiPYKmc/XxRGE+x0IMqDnp8GJXmOFPnOc1NxULDBS?=
 =?us-ascii?Q?rAjaDuf80mLlL8BvPsWSJ6x4PYnw8wNSrnTvi2XaTWujnTj/ISLlP034XeSx?=
 =?us-ascii?Q?mLajsbkxGRbqVXIcZ0Gq9SfUgC2k9NS1Uz99hTZiqDUDnVHJVM0iez8h4msk?=
 =?us-ascii?Q?XbWku86IPN0w2hqFv70SLijA0cM1c5AKcwq4n/uIaVJlIAMvbKFLYNG7X5Ur?=
 =?us-ascii?Q?dCTFIp0xNh14siWV+ntFRx12+aZhU3Prn0PCmegAYrTwEMZqhh0YdVHdywKp?=
 =?us-ascii?Q?jbylUpn7v5lfcMPYy5hkqO0gz6jxMacZK8iD8ltlVASjtKTNPlO/MLi8+Vla?=
 =?us-ascii?Q?DbI/jFe5GZVukwFpiwTzD7ZKmD2WHWFkj//8iQt+y3MAh4mwtVJDI3jTxDDG?=
 =?us-ascii?Q?Iv1jVRKSw2rn9sDlatZFpsaHJBGiUfInCupkJHQAt9k3utIusMRsiygpXA0J?=
 =?us-ascii?Q?u3GpFyUDrs0Ria/ue/r+W/zL2gEDTVFGnMxbw0k7y8hsVJFK4iXIIP5r923s?=
 =?us-ascii?Q?g3YHgON2lpaIGEy40azs48CPy8hzoQzlt76N7BbH2GNy/b573/L7tZmCm7/X?=
 =?us-ascii?Q?ZzdWmYbroJe9esqnCCNybHXKEsmdMWNfbF9e/M3kmdkrirgcU6Echhq5O+vb?=
 =?us-ascii?Q?XvcJdda0oTnjiiH6FHL3T8eYQEnXOCBLbppS1pxyrtGSQnBA+Psba2BAex/g?=
 =?us-ascii?Q?tz2eu5xKwgBtrHqXGcNikEzITd5w6u5FgpgYJvj8h+Q0Gs/yby/IrNz/5bVo?=
 =?us-ascii?Q?OiY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15de05d0-02e2-40fb-aa50-08d9085c8723
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 02:39:34.6031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBn/7CRklkeNK1wtKzaplbRRVDYxvyGV5YOKcaZQJDHl3qwwly+HCR2+XygXW4S1PmKcaZqX+e7dMDz8nL7Nyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Wed, 21 Apr 2021, Wu, Hao wrote:
>=20
> >> Subject: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port =
entries
> >>
> >> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >>
> >> Gracefully ignore misconfigured port entries encountered in
> >> incorrect FPGA images.
> >>
> >> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >> ---
> >>  drivers/fpga/dfl-pci.c | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> >> index b44523e..660d3b6 100644
> >> --- a/drivers/fpga/dfl-pci.c
> >> +++ b/drivers/fpga/dfl-pci.c
> >> @@ -212,6 +212,7 @@ static int find_dfls_by_default(struct pci_dev *pc=
idev,
> >>  	int port_num, bar, i, ret =3D 0;
> >>  	resource_size_t start, len;
> >>  	void __iomem *base;
> >> +	int bars =3D 0;
> >>  	u32 offset;
> >>  	u64 v;
> >>
> >> @@ -228,6 +229,7 @@ static int find_dfls_by_default(struct pci_dev *pc=
idev,
> >>  	if (dfl_feature_is_fme(base)) {
> >>  		start =3D pci_resource_start(pcidev, 0);
> >>  		len =3D pci_resource_len(pcidev, 0);
> >> +		bars |=3D BIT(0);
> >>
> >>  		dfl_fpga_enum_info_add_dfl(info, start, len);
> >>
> >> @@ -253,9 +255,21 @@ static int find_dfls_by_default(struct pci_dev
> *pcidev,
> >>  			 */
> >>  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> >>  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> >> +			if (bars & BIT(bar)) {
> >> +				dev_warn(&pcidev->dev, "skipping bad port
> >> BAR %d\n", bar);
> >> +				continue;
> >> +			}
> >
> > Will it be a real problem that multiple ports are inside one BAR but di=
fferent
> offsets?
> >
> > Hao
>=20
> I don't think multiple ports within a single BAR is something that has
> been supported in the past.  The genesis for this patch was a
> misconfigured port entry pointing to BAR0.  BAR0 had already been mapped
> for the FME and remapping BAR0 failed resulting in enumeration failure.

could some products put the port in BAR0? Or multiple ports in one BAR.
As we consider this is a common driver can be reused and maintained for
a long time, so I hope that we don't put limitation setup only for some=20
specific products.

Hao

>=20
> Matthew
>=20
> >
> >> +
> >>  			start =3D pci_resource_start(pcidev, bar) + offset;
> >> -			len =3D pci_resource_len(pcidev, bar) - offset;
> >> +			len =3D pci_resource_len(pcidev, bar);
> >> +			if (offset >=3D len) {
> >> +				dev_warn(&pcidev->dev, "bad port
> >> offset %u >=3D %pa\n",
> >> +					 offset, &len);
> >> +				continue;
> >> +			}
> >>
> >> +			len -=3D offset;
> >> +			bars |=3D BIT(bar);
> >>  			dfl_fpga_enum_info_add_dfl(info, start, len);
> >>  		}
> >>  	} else if (dfl_feature_is_port(base)) {
> >> --
> >> 1.8.3.1
> >
> >
