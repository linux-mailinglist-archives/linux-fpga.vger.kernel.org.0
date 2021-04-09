Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889F6359388
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Apr 2021 06:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhDIEDK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Apr 2021 00:03:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:24009 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhDIEDJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Apr 2021 00:03:09 -0400
IronPort-SDR: lzmKkN/NwN8Nx2QxIBMtlzk2YROhYDMlQ87fIx3xpEEmhgBUPdsP6AsaO3fzxpKnHUB7YNfgQ9
 gulnspWrqMFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="180813497"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="180813497"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 21:02:57 -0700
IronPort-SDR: jSWcHMmqzar3fEh5DPjL+H/8KuVscNmygxYFk8cLFK2KWB18i/fG1wdSYF2Gw55NH1v6YP0OhC
 ppyCB8dbdhNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="520122309"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2021 21:02:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 21:02:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 21:02:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 8 Apr 2021 21:02:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 8 Apr 2021 21:02:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3YMARd3bzv36U4/CGSakrGDFAGtlLfbAXgIRZn2L24RPjl5od5VDTVkPZm9TGAEfup56CnYetUNhjQ8XpkyrV/9me8Us069GxJFLVYo9JVWiyHPHcSOEc1Au5m7P0901piL8V0A2B0N5TJyxLxCCqfMRfrgv70bMK6822GQhnzDOLWmXaEjytF9k8tCF68EcA1maqz+HxaYmsojisKEj8gYjG5pou8yF4DsmGxAXLCZRbfw2+sgYwn2OupMIBRU/RWtCfx3k0ySGCr4nk+nx4Whc1dx8PffXU+PEzhoHWLxp/CMr/zf95YfW3WdcC5y4U9U29BVqFea6weufx6cLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ieih5+WboPdnrmBqCPUP+qiZumf0VrBHFr2OiOaj4gE=;
 b=REc1tZSh1H919yAEifIQ4L0ysezjg4c9YgAq9ExDj+vqKA2WmNfkNpckS/r4cAF1GzNCrlj26cPdpUcRz/RpQo7ZuUU3Lz7l+fpIScm7ZxOXkZ4QNnFlMG23K/Fv27t3xeXaj6wwGPmtRAFBDZcNch1t+jysprjfflGjcBLQ/Gr7ex48AZQx4RKMSyvz9PYBflexfdOUvy/FlQIGBgWAf5xqCqTUp7xrZw//I2YvPl1mWQ0HUlAHBMhPbf6yCgwALxulsjlEm7eQwpRUGksOioqYBr4mDfCe1A2Yel2viLP7w7RQoeG4nZl9nd/APtsRTJWkZ/xm1rSaP/+hmlROJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ieih5+WboPdnrmBqCPUP+qiZumf0VrBHFr2OiOaj4gE=;
 b=JBw4/CPbgQ4LFa/06YEIH0EPtUknJ2G3vc7uuVtj9H2G+FxgciZhgfudwVp5sPZSqtamU3yTHiaPS8ZtyqM0DwBwf13KsVkzwF9xRjciGrVxOVCCk3DREP6OS34MGSDJRqjjAI+ZL98rFrwA0ikzqzQ4CA2KvGV5v7NHJogUtKc=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3916.namprd11.prod.outlook.com (2603:10b6:5:5::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Fri, 9 Apr 2021 04:02:47 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25%6]) with mapi id 15.20.3999.034; Fri, 9 Apr 2021
 04:02:47 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     Moritz Fischer <mdf@kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "russell.h.weight@linux.intel.com" <russell.h.weight@linux.intel.com>
Subject: RE: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Thread-Topic: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Thread-Index: AQHXKnapzaN+e8jiOUasbNG/fZUbfKqmp0KAgAEBK4CAAAt/AIAChFHwgAAQfwCAAAHe8IABIkcAgAAgaTA=
Date:   Fri, 9 Apr 2021 04:02:47 +0000
Message-ID: <DM6PR11MB381912BD810637E0CDA1885F85739@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
 <20210405235301.187542-3-matthew.gerlach@linux.intel.com>
 <YGuvFYvJTMPPm2Jy@epycbox.lan>
 <alpine.DEB.2.22.394.2104060847030.208844@rhweight-WRK1>
 <YGyQdN9uS/niyFDP@epycbox.lan>
 <DM6PR11MB3819E0FC4F735C72746CE54785749@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210408081152.GA2713@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819317A55FD7798E778EC4D85749@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210409013730.GB2713@yilunxu-OptiPlex-7050>
In-Reply-To: <20210409013730.GB2713@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fab9c03a-23ce-4f67-02f2-08d8fb0c5654
x-ms-traffictypediagnostic: DM6PR11MB3916:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB391673445F9D997D8C55BF5585739@DM6PR11MB3916.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nm0iQ3XHXk8q15iHOMrQPo8vpGx+DhMyf/0JwCLl4pD6ebO93E5z/lrNLz0vkkHLU9tFqrO13rkfifIt3kS3oKga0fYNdI21JtV+jf8HiQvQJTsi8tlTnNi+8maVmcuCOxar3El7avlcsjRvf7muHo0wsG5wVSmbDhOYuYCwnClrt6N5h+Roj2ovPXswkCdYjHLcXu3O9glCQk3IG07W5dCFk+BIOIO/ay7uxcWUOIkLbISl1jwtuHYtUW58GD5pNOslwd6VN8N2tjzDKHpqx21y01T0GD3HcD0cOszu9ve5aYADnHgJ0qgYYC86L8SfD0r/2iapOknTuXbtrCiSqCNpm842l6P35UkgApxkbXCU+86KxFVdxSZFr1RoJDEFPTV6qvgEqIaSlXUUBcw4zTXsPCMb/kzARyZRvNl2mIbpaYHSv4uEbGwzQi9fJtEOB4xuxvIyBQWQMSNS1FCLL2wRYxQuUWs/Vrz2njefPrPQxX8eiZWmmke1G4pHP0U1pDRn70DW7qirm8yfm+Ae/feSws1OQ4g043R6Xmx5ZN10Ad1xKtfNhQ85sY7bzaQd5CGOOu8JKDFCVTk44a0o70dBT/eqAbT5829tawjIdZmHO0odgxqe2bpP16rMSWZjDHNsu8J5Xiptkmj5EQjuwjfL5UHX7DAv9fFBnLFhCF8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(396003)(39860400002)(2906002)(8936002)(9686003)(55016002)(7696005)(54906003)(8676002)(6506007)(83380400001)(33656002)(26005)(5660300002)(7416002)(71200400001)(52536014)(316002)(76116006)(66446008)(66476007)(6862004)(478600001)(186003)(64756008)(66946007)(66556008)(4326008)(86362001)(6636002)(38100700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zC7795KkSmuMSrYHKCqn7Ut2WfxJCwNz/yGEvVzhrhX73ZtwknXN+/frNAB2?=
 =?us-ascii?Q?a1qEC3MkQaj/maeh3RiuA4UNuWGYnZJvBk0soksw6WWlfXDzsmgCHlX2TybR?=
 =?us-ascii?Q?SdZOLsKresFgVmQ/7igoUPkZ4ZtZPscqXeT8E5eGg1gC3KovpZI+f0DEVPm4?=
 =?us-ascii?Q?xSBdOiOTSCSx5SCVZP5byA7HSUp3/tWgkj2G4fe4XG6kjEgznapknhY2Ex85?=
 =?us-ascii?Q?ervlc91zkPxu2YGSNYxZ86Sufn4zixBUbMmUISVihP2ndScjC58tO1NY4lj7?=
 =?us-ascii?Q?4vvh7E6QpoUN5XDcv6+w3F2W9yfnQrWJ8h94+39MN4eFjJwwZ8xPIs3Y3CHy?=
 =?us-ascii?Q?nT8eRmO/0rf4D37elVgOr9yxpLY0G7b4uN9rgfwYb06sCZz3wUutDxvA91nN?=
 =?us-ascii?Q?ruDeMUsURSqtrI+xnpsyCGiTy2HUBZhhu61P/C5jFch5XkS/KZMyVWv7pbPJ?=
 =?us-ascii?Q?oewusxZj9p2jRFFCS7IfONFU87wCTJ0FCwLKvkfesSsG/aZ3bfwndH3AJnVL?=
 =?us-ascii?Q?xLWAsgbzdhHscwQsflJkQDs/EHRen1Fc003Wh9XKL9ERYUjvxd6v+E0QvfaL?=
 =?us-ascii?Q?dP7hFMmAvvyU72Yg2ZccooH4s5MWowhLViiqAzeEMZ47JED1HDpfwObyYWaU?=
 =?us-ascii?Q?GSF/axe7Z6p6N985XLaQHGHanP/PdIO4OL+VQQ0G9V+aBtDhXwXINeTVDQv5?=
 =?us-ascii?Q?4NuAwF7N7vOQL0j7JX4qM86t5ZRh/ImdLQPumV/umRfq9khbGAk4rjB0ZsaZ?=
 =?us-ascii?Q?pgk4by/Xma+9Xa9JaAV+rBcQtCkrmYKIoFl89U8Y2xgOC9TX+hN/SodwkXfc?=
 =?us-ascii?Q?uTV5RAciwoZI5emDy+QzTFf3MIyIBEsHLCnUBSw8WotCHKDMTd3KuY/vcORq?=
 =?us-ascii?Q?YPUnj8sNSsoAeYV9RZc6Gx8vMsHWF7skr4JBwbB5uTtabWBCq3sn+gwBuKXr?=
 =?us-ascii?Q?4MQMtBCdvEcxCcPUrlEPDCrA5Vl6zc0Oq2qmRLRV7a7GaVR1HtkOmyOXkrHS?=
 =?us-ascii?Q?ofTyEiukyDoEOv7jCQBoJrbk9h4psXY+yLby3Qt+ZpR+HRoGfliTmjGJANrw?=
 =?us-ascii?Q?zLWT8dWraA2S51D+rWpj4v57oBGesF3UuekYAslMobrziPjFNr6g83kLzbhx?=
 =?us-ascii?Q?kGmnAlYE/CNEXkeiuiq1s0iVnrCTDAatfRSukspsF4V4vQipZlIyHsil2Gwz?=
 =?us-ascii?Q?R0x22PelvHsj+40MyXhYFsa5/X9IBEUmlNbiJU1221zc9hKEj4kqi/R4k/p0?=
 =?us-ascii?Q?lBN7RaH+3nhOdJNGX+Vy3ac9DoBZfsqZtKl3r2JajtKdTHfq8tZSpQ6BwDaP?=
 =?us-ascii?Q?VhbtwdzDDT8mZPf3Iv8kTv3/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab9c03a-23ce-4f67-02f2-08d8fb0c5654
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 04:02:47.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nf894HLxEBBcNbNDtlVSqu34UF5ceCbqrwpaq8UYziSKhEDH7s+mv6eCaw6Jon/eezG6oFlEbjU3rhJA2eYDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3916
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > > > > > > > +
> > > > > > > > +static void dfl_spi_altera_remove(struct dfl_device *dfl_d=
ev)
> > > > > > > > +{
> > > > > > > > +struct dfl_altera_spi *aspi =3D dev_get_drvdata(&dfl_dev->=
dev);
> > > > > > > > +
> > > > > > > > +platform_device_unregister(aspi->altr_spi);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +#define FME_FEATURE_ID_MAX10_SPI        0xe
> > > > > > > > +
> > > > > > > > +static const struct dfl_device_id dfl_spi_altera_ids[] =3D=
 {
> > > > > > > > +{ FME_ID, FME_FEATURE_ID_MAX10_SPI },
> > > > > > > > +{ }
> > > > > > > > +};
> > > > > > >
> > > > > > > Maybe you can extend the Altera SPI driver with this part?
> > > > > >
> > > > > > The file, drivers/spi/spi-altera.c, already has platform MODULE=
_
> related
> > > > > > code.  Wouldn't moving this code to that file produce conflicts=
?
> > > > >
> > > > > I've seen other drivers support multiple busses, so it should be
> > > > > possible, there might be nuances I'm missing in my brief look at =
this,
> > > > > though.
> > > > >
> > > > > I think one of them would be MODULE_DEVICE_TABLE(platform, ...)
> > > > > and the other one MODULE_DEVICE_TABLE(dfl, ...)
> > > > >
> > > > > See drivers/i2c/busses/i2c-designware-platdrv.c for an example (t=
hough
> > > > > they might be guarding against what you describe with CONFIG_OF v=
s
> > > > > CONFIG_ACPI)
> > > > >
> > > > > If that doesn't work we could split it up into
> > > > >
> > > > > altera-spi-plat.c and altera-spi-dfl.c and altera-spi-core.c
> > > > > or something of that sort?
> > > > >
> > > > > My point being, now that we have a bus, let's use it and develop =
drivers
> > > > > according to the Linux device model where possible :)
> > > >
> > > > Agree. This does make sense from my side too. DFL core provides the
> > > mechanism
> > > > to enumerate different IPs on FPGA, but each function driver needs =
to go
> to
> > > > related subsystem for review.  : )
> > > >
> > > > I understand that for FPGA case, it may have some additional logics=
 for
> specific
> > > > purposes based on common altera spi master IP, then additional code=
 for
> > >
> > > I'm wondering if the additional logics are extensions for common spi-=
altera.
> Like
> > > the
> > > SPI_CORE_PARAMETER register, it is not within the register space of
> > > spi-altera,
> > >
> > >
> > >   |   |      +-------------+
> > >   |DFL|------| +--------+  |
> > >   |BUS|      | |SPI CORE|  |
> > >   |   |      | |PARAM   |  |
> > >   |   |      | +--------+  |
> > >   |   |      |             |
> > >   |   |      | +--------+  |   +-------+
> > >              | |Indirect|  |   |spi    |
> > >              | |access  +--+---|altera |
> > >              | |master  |  |   +-------+
> > >              | +--------+  |
> > >              +-------------+
> > > > a specific product still can be put into altera-spi-xxxx.c or alter=
a-spi-dfl-
> xxxx.c
> > >
> > > So is it proper we integrate this feature into spi-altera? Previously
> > > we have merged the dfl-n3000-nios, its spi part is very similar as
> > > this driver. The dfl-n3000-nios make the spi-altera as a sub device.
> > > Could we borrow the idea, or could we just integrate this driver in
> > > dfl-n3000-nios?
> >
> > Looks like those are enhancements of the IP. They can be applied even
>=20
> I don't think the extra registers are the enhancement of the IP. They
> are not part of the IP because they are not within the IP's register
> space. They are like some external way of describing the IP like
> Devicetree or ACPI.

Why adding new registers can't be consider as enhancement, those
changes serve the original IP and make it better, right? small mmio
footprint and parameter registers?

>=20
> > other buses are used, not only for DFL, like PCI device or platform dev=
ice,
> > right? then why not put related code together with the original IP?
>=20
> The code of devicetree or ACPI parsing are integrated in the IP drivers,
> but for this case, it may not be proper for now, cause this style is not
> formally introduced by any standard. IP specific parameters description
> are not within the scope of DFL now.

Not sure if I get your point, but it's possible that we add some enhancemen=
ts
to one IP then driver could be simplified and doesn't need devicetree any m=
ore.
For sure, it's IP specific thing, not the scope of DFL.

Then things become this: extension to IP to allow this IP to be used withou=
t
device tree, so that this IP can be used in DFL or PCI or other buses witho=
ut
device tree?

Thanks
Hao

>=20
> >
> > The reason I suggested that function drivers which use DFL bus, still n=
eed
> > to go to related subsystem, because we know DFL quite well but may
> > not be the experts for every subsystem (e.g. SPI), and every IPs (e.g.
> > Altera SPI Master). Altera SPI Master driver maintainer could give more
> > valuable suggestions on your question if this feature can be integrated
> > into spi-altera or not. : )
>=20
> I agree that we put drivers to their related subsystem. I'm just
> wondering if drivers/spi is the proper domain for it. Anyway getting
> some inputs from SPI maintainers is a good suggestion.
>=20
> Thanks,
> Yilun
>=20
> >
> > Hao
> >
> > >
> > > Thanks,
> > > Yilun
> > >
> > > >
> > > > Thanks
> > > > Hao
> > > >
> > > > >
> > > > > Cheers,
> > > > > Moritz
